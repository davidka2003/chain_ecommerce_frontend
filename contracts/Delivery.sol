// SPDX-License-Identifier: GPL-3.0
// pragma solidity >=0.7.0 <0.9.0;
pragma solidity ^0.8.0;
import "./Utils.sol";

abstract contract Delivery is Utils {
    struct delivery {
        uint256 id;
        string title;
        string uri;
        uint256 orderId;
        uint256 balance;
        string[2][] destinations;
        uint256[] shops;
        bool banned;
    }
    struct order {
        uint256 id;
        uint256 owner;
        string uri;
        uint256 shopId;
        uint256 deliveryId;
        uint256[] itemIds;
        uint256 itemsPrice; ///@dev u can remove this filed if u would use getItemsPriceBach
        uint256 deliveryPrice;
        string[2] destination;
        string data;
        bool isApproved;
        bool isDelivered;
        bool isCanceled;
    }
    struct destination {
        uint256 price;
        bool exist;
        bool available;
    }
    struct avaiability {
        bool exist;
        bool available;
    }
    enum OrderEditType {
        cancel,
        approve,
        uri,
        deliver,
        created
    }
    uint256 private _deliveryId = 1;
    mapping(uint256 => delivery) internal _deliveries;
    mapping(address => uint256) private _deliveryIds;
    mapping(uint256 => mapping(uint256 => avaiability)) internal _shopsAvail;
    mapping(uint256 => mapping(string => mapping(string => destination)))
        private _destinations; ///@dev id => country => city => price
    mapping(uint256 => mapping(uint256 => order)) internal _orders;

    event OrderChanged(uint256 deliveryId, uint256 id, OrderEditType _type);

    function getOrdersBatch(uint256 deliveryId, uint256[] memory ids)
        public
        view
        returns (order[] memory)
    {
        require(deliveryId > 0 && deliveryId < _deliveryId, "DNE");
        order[] memory orders = new order[](ids.length);
        for (uint256 index = 0; index < ids.length; index++) {
            uint256 id = ids[index];
            require(id > 0 && id < _deliveries[deliveryId].orderId, "ONE");
            orders[index] = _orders[deliveryId][id];
        }
        return orders;
    }

    function getShopAvailBatch(uint256 deliveryId, uint256[] calldata shopIds)
        external
        view
        returns (bool[] memory)
    {
        bool[] memory _avails = new bool[](shopIds.length);
        for (uint256 index = 0; index < shopIds.length; index++) {
            _avails[index] = _shopsAvail[deliveryId][shopIds[index]].available;
        }
        return _avails;
    }

    function withdrawDelivery(uint256 amount, address payable _to)
        public
        NonReentrant
    {
        //Pausable();
        uint256 deliveryId = _deliveryIds[msg.sender];
        require(deliveryId > 0, "DNE");
        require(_deliveries[deliveryId].balance >= amount, "NE");
        require(_to != address(0), "IA");
        _deliveries[deliveryId].balance -= amount;
        emit WithdrawBalance(deliveryId, StructureType.delivery, amount, _to);
        _to.transfer(amount);
    }

    /**
    @param id pass id:0 to get delivery by msg.snder
     */
    function getDelivery(uint256 id) public view returns (delivery memory) {
        if (id == 0) {
            delivery memory _delivery = _deliveries[_deliveryIds[msg.sender]];
            require(_delivery.id != 0, "DNE");
            return _delivery;
        }
        require(id < _deliveryId, "DNE");
        return _deliveries[id];
    }

    function editConnectedShopBatch(
        uint256[] calldata shops,
        bool[] calldata availabilities
    ) public {
        //Pausable();
        uint256 deliveryId = _deliveryIds[msg.sender];
        require(deliveryId > 0, "DNE");
        require(shops.length == availabilities.length, "IA");
        for (uint256 index = 0; index < shops.length; index++) {
            avaiability memory _availability = _shopsAvail[deliveryId][
                shops[index]
            ];
            if (!_availability.exist) {
                _deliveries[deliveryId].shops.push(shops[index]);
                _availability.exist = true;
            }
            _availability.available = availabilities[index];
            _shopsAvail[deliveryId][shops[index]] = _availability;
        }
        emit Info(deliveryId, StructureType.delivery, EventType.changed);
    }

    function getDestinationBatch(uint256 id, string[2][] calldata destinations)
        public
        view
        returns (destination[] memory)
    {
        //Pausable();
        destination[] memory dests = new destination[](destinations.length);
        for (uint256 index = 0; index < destinations.length; index++) {
            destination memory _dest = _destinations[id][
                destinations[index][0]
            ][destinations[index][1]];
            require(_dest.exist, "DNA");
            dests[index] = _dest;
        }
        return dests;
    }

    /* remove this one if so, require dest.available*/
    function _getDestination(uint256 id, string[2] calldata _destination)
        internal
        view
        returns (
            // string memory country,
            // string memory city
            destination memory
        )
    {
        destination memory _dest = _destinations[id][_destination[0]][
            _destination[1]
        ];
        require(_dest.exist && _dest.available, "MNA");
        return _dest;
    }

    function editDestinationBatch(
        string[] calldata countries,
        string[] calldata cities,
        uint256[] calldata prices
    ) public {
        //Pausable();
        uint256 deliveryId = _deliveryIds[msg.sender];
        require(deliveryId > 0, "DNE");
        require(
            countries.length == cities.length && cities.length == prices.length,
            "IA"
        );
        for (uint256 index = 0; index < countries.length; index++) {
            destination memory _destination = _destinations[deliveryId][
                countries[index]
            ][cities[index]];
            if (!_destination.exist) {
                _deliveries[deliveryId].destinations.push(
                    [countries[index], cities[index]]
                ); ///@dev make a memory array to make lower gas costs
            }
            _destination.price = prices[index];
            _destination.exist = true;
            _destination.available = prices[index] != 0;
            ///@dev 142 make here delivery edit
            _destinations[deliveryId][countries[index]][
                cities[index]
            ] = _destination;
        }
        emit Info(deliveryId, StructureType.delivery, EventType.changed);
    }

    /** 
        @dev Changing or creatnig a delivery
     */
    function editDelivery(
        string calldata title,
        string calldata metaUri,
        address addr,
        bool create
    ) public {
        //Pausable();
        delivery memory _delivery;
        if (create) {
            ///@dev creating new delivery
            uint256 currentId = _deliveryId;
            require(msg.sender == _owner, "NAO");
            require(addr != address(0) && _deliveryIds[addr] == 0, "IA");
            _delivery.title = title;
            _delivery.uri = metaUri;
            _delivery.id = currentId;
            _delivery.orderId = 1;
            _deliveries[currentId] = _delivery;
            _deliveryIds[addr] = currentId;
            _deliveryId++;
            emit Info(_delivery.id, StructureType.delivery, EventType.created);
        } else {
            _delivery = getDelivery(0);
            // require(_delivery.id != 0, "DNE");
            _delivery.title = title;
            _delivery.uri = metaUri;
            if (addr != address(0)) {
                require(_deliveryIds[addr] == 0, "IA"); ///@dev checking for address not exist
                delete _deliveryIds[msg.sender];
                _deliveryIds[addr] = _delivery.id;
                _deliveries[_delivery.id] = _delivery;
            }
            emit Info(_delivery.id, StructureType.delivery, EventType.changed);
        }
    }

    function _transferEthD(
        uint256 amount,
        uint256 id,
        bool incr
    ) internal {
        require(id > 0 && id < _deliveryId, "DNE");
        if (incr) {
            _deliveries[id].balance += amount;
        } else _deliveries[id].balance -= amount;
    }

    ///@dev no transfer eth here
    function _editOrder(
        uint256 deliveryId,
        uint256 orderId,
        OrderEditType _type,
        string memory uri
    ) internal {
        require(deliveryId > 0 && deliveryId < _deliveryId, "DNE");
        order memory _order = _orders[deliveryId][orderId];
        require(_order.id != 0, "ONE");
        require(_order.deliveryId == deliveryId, "NAD");
        if (_type == OrderEditType.uri) {
            require(
                !_order.isApproved && !_order.isCanceled && !_order.isDelivered,
                "NU"
            );
            _order.uri = uri;
        } else if (_type == OrderEditType.cancel) {
            require(
                !_order.isApproved && !_order.isCanceled && !_order.isDelivered,
                "NC"
            );
            _order.isCanceled = true;
        } else if (_type == OrderEditType.approve) {
            require(
                !_order.isApproved && !_order.isCanceled && !_order.isDelivered,
                "NA"
            );
            _order.isApproved = true;
        } else if (_type == OrderEditType.deliver) {
            require(
                _order.isApproved && !_order.isCanceled && !_order.isDelivered,
                "ND"
            );
            _order.isDelivered = true;
        }
        _orders[deliveryId][orderId] = _order;
        emit OrderChanged(deliveryId, orderId, _type);
    }
}
