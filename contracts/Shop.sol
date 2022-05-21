// SPDX-License-Identifier: GPL-3.0
// pragma solidity >=0.7.0 <0.9.0;
pragma solidity ^0.8.0;
import "./Utils.sol";

abstract contract Shop is Utils {
    struct shop {
        uint256 id;
        string title;
        string uri;
        uint256 itemId;
        uint256 balance;
        bool banned;
    }
    struct item {
        uint256 id;
        uint256 price;
        string uri;
        uint256 owner;
        uint256 shopId;
        bool isMinted;
        bool isAvailable;
    }
    uint256 private _shopId = 1;
    mapping(uint256 => shop) internal _shops;
    mapping(address => uint256) private _shopIds;
    mapping(uint256 => mapping(uint256 => item)) internal _items;
    event Mint(uint256 shopId, uint256[] ids, uint256 owner);

    /**
    @param id pass id:0 to get shop by msg.snder
     */
    function getShop(uint256 id) public view returns (shop memory) {
        if (id == 0) {
            shop memory _shop = _shops[_shopIds[msg.sender]];
            require(_shop.id != 0, "SNE");
            return _shop;
        }
        require(id < _shopId, "SNE");
        return _shops[id];
    }

    function getItemsBatch(uint256 shopId, uint256[] calldata ids)
        public
        view
        returns (item[] memory)
    {
        require(shopId > 0 && shopId < _shopId, "SNE");
        item[] memory items = new item[](ids.length);
        for (uint256 index = 0; index < ids.length; index++) {
            uint256 id = ids[index];
            require(id > 0 && id < _shops[shopId].itemId, "INE");
            items[index] = _items[shopId][id];
        }
        return items;
    }

    function _transferEthS(
        uint256 amount,
        uint256 id,
        bool incr
    ) internal {
        require(id > 0 && id < _shopId, "SNE");
        if (incr) {
            _shops[id].balance += amount;
        } else _shops[id].balance -= amount;
    }

    /** 
        @dev add and edit items
        @param ids if u pass id:0, u would add new item to shop
     */
    function editItemBatch(
        uint256[] calldata ids,
        uint256[] calldata prices,
        string[] calldata uris,
        bool[] calldata availabilities
    ) public {
        //Pausable();
        require(
            ids.length == prices.length &&
                uris.length == availabilities.length &&
                prices.length == uris.length,
            "IA"
        );
        // shop memory _shop = _shops[_shopIds[msg.sender]];
        uint256 shopId = _shopIds[msg.sender];
        require(shopId > 0, "SNE");
        for (uint256 index = 0; index < ids.length; index++) {
            item memory _item = _items[shopId][ids[index]];
            if (!_item.isMinted) {
                ///@dev triggers only when item not minted, no matter if it not exist
                _item.shopId = shopId;
                _item.price = prices[index];
                _item.uri = uris[index];
                _item.isAvailable = availabilities[index];
            }
            if (_item.id == 0) {
                ///@dev item not exist
                uint256 currentItemId = _shops[shopId].itemId;
                _item.id = currentItemId;
                _item.isAvailable = availabilities[index];
                _items[shopId][currentItemId] = _item;
                _items[shopId][currentItemId] = _item;
                _shops[shopId].itemId++;
            } else {
                ///@dev u can remove this part
                ///@dev item exist
                _items[shopId][ids[index]] = _item;
            }
        }
        emit Info(shopId, StructureType.shop, EventType.changed);
    }

    function withdrawShop(uint256 amount, address payable _to)
        public
        NonReentrant
    {
        //Pausable();
        shop memory _shop = getShop(0);
        require(_shop.balance >= amount, "NE");
        require(_to != address(0), "IA");
        _shops[_shop.id].balance -= amount;
        emit WithdrawBalance(_shop.id, StructureType.shop, amount, _to);
        _to.transfer(amount);
    }

    /** 
        @dev Changing or creating a shop
     */
    function editShop(
        string calldata title,
        string calldata metaUri,
        address addr,
        bool create
    ) public {
        //Pausable();
        shop memory _shop;
        if (create) {
            ///@dev creating new shop
            uint256 currentId = _shopId;
            require(msg.sender == _owner, "NAO");
            require(addr != address(0) && _shopIds[addr] == 0, "IA");
            _shop.title = title;
            _shop.uri = metaUri;
            _shop.id = currentId;
            _shop.itemId = 1;
            _shops[currentId] = _shop;
            _shopIds[addr] = currentId;
            _shopId++;
            emit Info(_shop.id, StructureType.shop, EventType.created);
        } else {
            _shop = getShop(0);
            _shop.title = title;
            _shop.uri = metaUri;
            if (addr != address(0)) {
                require(_shopIds[addr] == 0, "IA"); ///@dev checking for address not exist
                delete _shopIds[msg.sender];
                _shopIds[addr] = _shop.id;
                _shops[_shop.id] = _shop;
            }
            emit Info(_shop.id, StructureType.shop, EventType.changed);
        }
    }

    // function getItemPriceBatch(uint256 shopId, uint256[] calldata ids)
    //     public
    //     view
    //     returns (uint256)
    // {
    //     require(shopId > 0 && shopId < _shopId, "SNE");
    //     uint256 total;
    //     for (uint256 index = 0; index < ids.length; index++) {
    //         item memory _item = _items[shopId][ids[index]];
    //         require(_item.id > 0 && _item.id < _shops[shopId].itemId, "INE");
    //         total += _item.price;
    //     }
    //     return total;
    // }
}
