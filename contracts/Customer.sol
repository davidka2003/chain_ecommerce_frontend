// SPDX-License-Identifier: GPL-3.0
// pragma solidity >=0.7.0 <0.9.0;
pragma solidity ^0.8.0;
import "./Utils.sol";

abstract contract Customer is Utils {
    struct customer {
        uint256 id;
        string title;
        string uri;
        uint256[2][] orders; ///@dev deliveryId, orderId
        uint256 balance;
    }
    uint256 private _customerId = 1;
    mapping(uint256 => customer) internal _customers;
    mapping(address => uint256) private _customerIds;
    event OrderUpdated(uint256 customerId, uint256 deliveryId, uint256 orderId);

    /**
    @param id pass id:0 to get customer by msg.snder
     */
    function getCustomer(uint256 id) public view returns (customer memory) {
        if (id == 0) {
            customer memory _customer = _customers[_customerIds[msg.sender]];
            require(_customer.id > 0 && _customer.id < _customerId, "CNE");
            return _customer;
        }
        require(id < _customerId, "CNE");
        return _customers[id];
    }

    function withdrawCustomer(uint256 amount, address payable _to)
        public
        NonReentrant
    {
        //Pausable();
        customer memory _customer = getCustomer(0);
        require(_customer.balance >= amount, "NE");
        require(_to != address(0), "IA");
        _customers[_customer.id].balance -= amount;
        emit WithdrawBalance(_customer.id, StructureType.customer, amount, _to);
        _to.transfer(amount);
    }

    function _transferEthC(
        uint256 amount,
        uint256 id,
        bool incr
    ) internal {
        require(id > 0 && id < _customerId, "DNE");
        if (incr) {
            _customers[id].balance += amount;
        } else _customers[id].balance -= amount;
    }

    /** 
        @dev Creating a customer
     */
    function editCustomer(
        string memory title,
        string memory metaUri,
        address addr
    ) public {
        customer memory _customer = _customers[_customerIds[msg.sender]];
        if (_customer.id == 0) {
            uint256 currentId = _customerId;
            _customer.id = currentId;
            _customer.title = title;
            _customer.uri = metaUri;
            _customerIds[msg.sender] = currentId;
            _customers[currentId] = _customer;
            _customerId++;
            emit Info(_customer.id, StructureType.customer, EventType.created);
        } else {
            _customer.title = title;
            _customer.uri = metaUri;
            _customers[_customer.id] = _customer;
            if (addr != address(0)) {
                require(_customerIds[addr] == 0, "IA"); ///@dev checking for address not exist
                delete _customerIds[msg.sender];
                _customers[_customer.id] = _customer;
                _customerIds[addr] = _customer.id;
            }
            emit Info(_customer.id, StructureType.customer, EventType.changed);
        }
    }
}
