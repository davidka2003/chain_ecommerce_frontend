// SPDX-License-Identifier: GPL-3.0
// pragma solidity >=0.7.0 <0.9.0;
pragma solidity ^0.8.0;
// import "./Storage.sol";
import "./Shop.sol";
import "./Customer.sol";
import "./Delivery.sol";

contract Ecommerce is Shop, Customer, Delivery {
    // address private _owner;
    // uint256 private _balance;

    constructor() {
        _owner = msg.sender;
    }

    function getBalance() external view returns (uint256) {
        return _balance;
    }

    // function setPause(bool paused) external {
    //     require(msg.sender == _owner, "NAO");
    //     _paused = paused;
    // }

    function approveDelivery(uint256 orderId, string calldata uri) external {
        _editOrder(getDelivery(0).id, orderId, OrderEditType.approve, uri);
    }

    function setBan(
        uint256 id,
        StructureType _type,
        bool banned
    ) external {
        if (_type == StructureType.shop) {
            shop memory _shop = getShop(id);
            _shop.banned = banned;
            _shops[id] = _shop;
        } else if (_type == StructureType.shop) {
            delivery memory _delivery = getDelivery(id);
            _delivery.banned = banned;
            _deliveries[id] = _delivery;
        }
    }

    function deliver(uint256 orderId) external {
        uint256[] memory _ord = new uint256[](1);
        _ord[0] = orderId;
        order memory _order = getOrdersBatch(getDelivery(0).id, _ord)[0];
        _editOrder(_order.deliveryId, orderId, OrderEditType.deliver, "");
        uint256 ethToOwner = (_order.itemsPrice / 100) * 1;
        _transferEthD(_order.deliveryPrice, _order.deliveryId, true);
        _transferEthS(_order.itemsPrice - ethToOwner, _order.shopId, true);
        _balance += ethToOwner;
    }

    ///@dev only for deliveries
    // function cancelOrderDelivery(uint256 orderId) external {
    //     uint256 deliveryId = getDelivery(0).id;
    //     _editOrder(deliveryId, orderId, OrderEditType.cancel, "");
    //     order memory _order;
    //     {
    //         uint256[] memory _ord = new uint256[](1);
    //         _ord[0] = orderId;
    //         _order = getOrdersBatch(deliveryId, _ord)[0];
    //     }
    //     uint256 ethToShop = (_order.itemsPrice / 100) * 1;
    //     _transferEthS(ethToShop, _order.shopId, true);
    //     _transferEthC(
    //         _order.itemsPrice - ethToShop + _order.deliveryPrice,
    //         _order.owner,
    //         true
    //     );
    // }

    ///@dev only for customers
    function cancelOrder(uint256 deliveryId, uint256 orderId) external payable {
        // Pausable();
        order memory _order;
        {
            uint256[] memory _ord = new uint256[](1);
            _ord[0] = orderId;
            _order = getOrdersBatch(getDelivery(deliveryId).id, _ord)[0];
        }
        if (deliveryId > 0) {
            require(msg.value == 0.5 ether, "NE");
            require(_order.owner == getCustomer(0).id, "NAO");
            _balance += 0.5 ether; ///@dev required 0.5 ether
        }
        _editOrder(_order.deliveryId, orderId, OrderEditType.cancel, "");
        ///@dev transfer eth
        uint256 ethToShop = (_order.itemsPrice / 100) * 1;
        _transferEthS(ethToShop, _order.shopId, true);
        _transferEthC(
            _order.itemsPrice - ethToShop + _order.deliveryPrice,
            _order.owner,
            true
        );
    }

    function createOrder(
        uint256 shopId,
        uint256 deliveryId,
        uint256[] calldata tokenIds,
        string[2] calldata _destination,
        string calldata data
    ) external payable {
        // Pausable();
        uint256 customerId = getCustomer(0).id;
        {
            require(getShop(shopId).id != 0, "SNE");
            require(getDelivery(deliveryId).id != 0, "DNE");
            require(_getDestination(deliveryId, _destination).available, "MNE");
            require(_shopsAvail[deliveryId][shopId].available, "SNA");
            require(!_shops[shopId].banned, "SB");
            require(!_deliveries[deliveryId].banned, "DB");
        }
        uint256 price;
        uint256 deliveryPrice = _getDestination(deliveryId, _destination).price;
        {
            for (uint256 index = 0; index < tokenIds.length; index++) {
                item memory _item = _items[shopId][tokenIds[index]];
                require(_item.id != 0, "INE");
                require(_item.isAvailable, "NA");
                require(!_item.isMinted, "AM");
                price += _item.price;
            }
            ///@dev minting items
            require(msg.value == price + deliveryPrice, "NE");
            for (uint256 index = 0; index < tokenIds.length; index++) {
                item memory _item = _items[shopId][tokenIds[index]];
                _item.owner = customerId;
                _item.isMinted = true;
                _item.isAvailable = false;
                _items[shopId][tokenIds[index]] = _item;
            }
            emit Mint(shopId, tokenIds, customerId);
        }
        {
            ///@dev union them in orders and returing orderId
            order memory _order = order({
                deliveryId: deliveryId,
                data: data,
                id: _deliveries[deliveryId].orderId,
                deliveryPrice: deliveryPrice, /* count it */
                destination: _destination,
                itemIds: tokenIds,
                isApproved: false,
                isDelivered: false,
                isCanceled: false,
                shopId: shopId,
                owner: customerId,
                uri: "",
                itemsPrice: price
            });
            _orders[deliveryId][_order.id] = _order;
            _deliveries[deliveryId].orderId++;
            emit OrderChanged(deliveryId, _order.id, OrderEditType.created);
            ///@dev updating customer info
            _customers[customerId].orders.push([deliveryId, _order.id]);
            emit OrderUpdated(customerId, deliveryId, _order.id);
        }
    }
}
