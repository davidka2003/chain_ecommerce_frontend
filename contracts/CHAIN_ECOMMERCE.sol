// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
            // benefit is lost if 'b' is also tested.
            // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator.
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {trySub}.
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting with custom message when dividing by zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryMod}.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a % b;
        }
    }
}

contract CHAIN_ECOMMERCE {
    /* private ids need only for recognize */
    using SafeMath for uint256;
    uint256 private _shopId;
    uint256 private _deliveryId;
    uint256 private _customerId;
    /* 
    shop and delivery addresse need only for msg.sender validation
    use for another cases only Ids
     */
    /* balance, available for withdraw by project owner */
    uint256 private _availableBalance;
    address private _owner;
    /* boolean with default */
    enum extBoolean{
        False,
        True,
        Default
    }
    /* structs */
    struct Item {
        bool exist;
        uint256 tokenId;
        string metaUri;
        address owner;
        uint256 price;
        bool isAvailable;
        bool isDelivered;
        bool isMinted;
        bool isCanceled;
        uint256 deliveryId;
        uint256 deliveryPrice;
    }
    struct Shop {
        string metaUri; /* shop metadata */
        string title;
        bool isBanned;
        bool exist;
        uint256 _itemId;
        mapping(uint256 => Item) items;
        uint256[] _itemIdsArray;
        uint256 availableBalance; /* available to withdraw */
    }
    struct Delivery {
        /* or countries array */
        uint256 deliveryPrice;
        string metaUri; /* shop metadata */
        string title;
        bool exist;
        bool isBanned;
        mapping(uint256 => bool) isAvailableForShop; /* shopId => availablity*/
        uint256[] _shopIdsArray;
        uint256 availableBalance; /* available to withdraw */
    }
    struct Customer {
        // mapping(address=>bool) wallets;/* wallet address => isExist */
        string metaUri;
        string title;
        bool exist;
        mapping(uint256 => uint256[]) orders;/* shopId => itemIds[] */
        /* add shops array to get orders from shops */
    }
    /* STORAGE */
    /* Customers storage */
    mapping(address => uint256) private _customerIds;/* customer address => customerId */
    mapping(uint256 => Customer) private _customers;/* customerId => code accessable struct */
    /* Shops storage */
    mapping(address => uint256) private _shopIds;/* shop address => shopId */
    mapping(uint256 => Shop) private _shops;/* shopId => code accessable struct */
    /* Deliveries storage */
    mapping(address => uint256) private _deliveryIds;/* delivery address => deliveryId */
    mapping(uint256 => Delivery) private _deliveries;/* deliveryId => code accessable struct */
    /* MODIFIERS */
    /* access gets only project owner */
    modifier onlyOwner() {
        require(_owner == msg.sender, "Not an owner");
        _;
    }
    /* access gets only shop owner */
    modifier onlyShop() {
        require(_shops[_shopIds[msg.sender]].exist, "Not a shop owner");
        _;
    }
    /* access gets only customer */
    modifier onlyCustomer(){
        require(_customers[_customerIds[msg.sender]].exist, "Not a customer");
        _;
    }
    /* access gets only delivery owner */   
    modifier onlyDelivery() {
        /* remake for delivery employeers*/
        require(
            _deliveries[_deliveryIds[msg.sender]].exist,
            "Not a delivery owner"
        );
        _;
    }
    /* revert if shop banned */
    modifier shopBanCheck(uint256 shopId) {
        require(!_shops[shopId].isBanned, "Shop is banned");
        _;
    }

    constructor() {
        _owner = msg.sender;
    }
    /* CHANGING OWNERSHIP  */
    function changeOwner(address addr) external onlyOwner returns (address) {
        require(address(0) != addr, "Invalid address");
        _owner = addr;
        return addr;
    }

    function changeShopOwner(address addr) external onlyShop returns (address) {
        require(address(0) != addr, "Invalid address");
        _shopIds[addr] = _shopIds[msg.sender];
        delete _shopIds[msg.sender];
        return addr;
    }
    function changeCustomerOwner(address addr) external onlyCustomer returns (address) {
        require(address(0) != addr, "Invalid address");
        _customerIds[addr] = _customerIds[msg.sender];
        delete _customerIds[msg.sender];
        return addr;
    }
    function changeDeliveryOwner(address addr)
        external
        onlyDelivery
        returns (address)
    {
        require(address(0) != addr, "Invalid address");
        _deliveryIds[addr] = _deliveryIds[msg.sender];
        delete _deliveryIds[msg.sender];
        // _deliveries[_deliveryIds[msg.sender]].owner = addr;
        return addr;
    }
    /* WITHDRAWING BALANCE */
    function withdrawShopBalance(address payable addr, uint256 amount)
        external
        onlyShop
        returns (address, uint256)
    {
        require(addr != address(0), "Address doesn't exist");
        require(
            _shops[_shopIds[msg.sender]].availableBalance >= amount,
            "Your shop doesn't has this amount eth"
        );
        (bool sent, ) = addr.call{value: amount}("");
        require(sent, "Transfer failure");
        _shops[_shopIds[msg.sender]].availableBalance -= amount;
        return (addr, amount);
    }

    function withdrawDeliveryBalance(address payable addr, uint256 amount)
        external
        onlyDelivery
        returns (address, uint256)
    {
        require(addr != address(0), "Address doesn't exist");
        require(
            _deliveries[_deliveryIds[msg.sender]].availableBalance >= amount,
            "Your shop doesn't has this amount eth"
        );
        (bool sent, ) = addr.call{value: amount}("");
        require(sent, "Transfer failure");
        _deliveries[_deliveryIds[msg.sender]].availableBalance -= amount;
        return (addr, amount);
    }

    function withdrawBalance(address payable addr, uint256 amount)
        external
        onlyOwner
        returns (address, uint256)
    {
        require(addr != address(0), "Address doesn't exist");
        require(_availableBalance >= amount, "Doesn't has this amount eth");
        (bool sent, ) = addr.call{value: amount}("");
        require(sent, "Transfer failure");
        _availableBalance -= amount;
        return (addr, amount);
    }
    /* BAN SETTERS */
    function setDeliveryBan(address addr, bool _isBanned)
        external
        onlyOwner
        returns (bool)
    {
        require(
            _deliveries[_deliveryIds[addr]].exist,
            "Delivery doesn't exist"
        );
        _deliveries[_deliveryIds[addr]].isBanned = _isBanned;
        return _isBanned;
    }

    function setShopBan(address addr, bool _isBanned)
        external
        onlyOwner
        returns (bool)
    {
        require(_shops[_shopIds[addr]].exist, "Shop doesn't exist");
        _shops[_shopIds[addr]].isBanned = _isBanned;
        return _isBanned;
    }
    /* BAN GETTERS */
    function getDeliveryBan(address addr) external view returns (bool) {
        require(
            _deliveries[_deliveryIds[addr]].exist,
            "Delivery doesn't exist"
        );
        return _deliveries[_deliveryIds[addr]].isBanned;
    }

    function getShopBan(address addr) external view returns (bool) {
        require(_shops[_shopIds[addr]].exist, "Shop doesn't exist");
        return _shops[_shopIds[addr]].isBanned;
    }
    /* BALANCE GETTERS */
    /* ADD OWNER BALANCE GETTER */
    function getShopBalance(address addr) external view returns (uint256) {
        require(_shops[_shopIds[addr]].exist, "Shop doesn't exist");
        return _shops[_shopIds[addr]].availableBalance;
    }

    function getDeliveryBalance(address addr) external view returns (uint256) {
        require(_deliveries[_deliveryIds[addr]].exist, "Shop doesn't exist");
        return _deliveries[_deliveryIds[addr]].availableBalance;
    }
    /* GET STRUCTS, NOW ONLY GETITEM */
    function getItem(address addr, uint256 itemId)
        external
        view
        returns (Item memory)
    {
        require(
            _shops[_shopIds[addr]].items[itemId].exist,
            "Item doesn't exist"
        );
        return _shops[_shopIds[addr]].items[itemId];
    }
    /* ADD ITEMS, EDIT RETURN OR ADD EMIT */
    function addItems(string[] memory metaUris, uint256[] memory prices)
        external
        onlyShop
    {
        /* _itemId[] for current call */
        /* 107k gas with Recepiet()*/
        // require(msg.sender);
        require(!_shops[_shopIds[msg.sender]].isBanned, "Shop is banned");
        require(metaUris.length == prices.length, "Invalid args");
        uint256[] memory ids = new uint256[](metaUris.length);
        for (uint256 index = 0; index < metaUris.length; index++) {
            require(prices[index]>100000, "Price too low");
            require(prices[index]>100000, "Price too low");
            _shops[_shopIds[msg.sender]]
                .items[_shops[_shopIds[msg.sender]]._itemId]
                .metaUri = metaUris[index];
            _shops[_shopIds[msg.sender]]
                .items[_shops[_shopIds[msg.sender]]._itemId]
                .price = prices[index];
            _shops[_shopIds[msg.sender]]
                .items[_shops[_shopIds[msg.sender]]._itemId]
                .owner = _owner;
            _shops[_shopIds[msg.sender]]
                .items[_shops[_shopIds[msg.sender]]._itemId]
                .isAvailable = true;
            _shops[_shopIds[msg.sender]]
                .items[_shops[_shopIds[msg.sender]]._itemId]
                .exist = true;
            ids[index] = _shops[_shopIds[msg.sender]]._itemId;
            _shops[_shopIds[msg.sender]]._itemId++;
        }
        // emit AddReceipts(metaUris, ids, prices);
    }
    /* ITEMS MINTING */
    function mintItems(
        uint256 shopId,
        uint256[] memory tokenIds,
        uint256 delievryId,
        string memory sessionId /* bcrypted!!!! */
    )
        external
        payable
        onlyCustomer
        shopBanCheck(shopId)
        returns (
            uint256,
            uint256[] memory,
            string memory
        )
    {
        uint256 fullPrice;
        require(
            _deliveries[delievryId].isAvailableForShop[shopId],
            // _shops[shopId].items[tokenId].exist,
            "This delivery method is not available for this shop"
        );
        for (uint256 index = 0; index < tokenIds.length; index++) {
            uint256 tokenId = tokenIds[index];
            require(
                _shops[shopId].items[tokenId].exist,
                "No such token"
            );
            require(
                !_shops[shopId].items[tokenId].isMinted,
                "Token already minted"
            );
            require(
                _shops[shopId].items[tokenId].isAvailable,
                "Token not available for mint"
            );
            fullPrice += _shops[shopId].items[tokenId].price;
        }
        require(msg.value == fullPrice, "Invalid amount eth");
        for (uint256 index = 0; index < tokenIds.length; index++) {
            uint256 tokenId = tokenIds[index];
            _shops[shopId].items[tokenId].owner = msg.sender;
            _shops[shopId].items[tokenId].isMinted = true;
            _shops[shopId]
                .items[tokenId]
                .deliveryId = delievryId;
            _customers[_customerIds[msg.sender]].orders[shopId].push(tokenId);
        }
        // _shopBalance += msg.value;
        /* emit */
        return (shopId, tokenIds, sessionId);
    }
    /* DELIVERY APPROVAL */
    function approveDelivery(address shopAddress,uint256[] memory tokenIds, address owner,string memory /* as sessionId */deliverySessionId) external onlyDelivery {
        /* for couriers only */
        uint256 fullPrice;
        deliverySessionId;
        for (uint256 index = 0; index < tokenIds.length; index++) {
            uint256 tokenId = tokenIds[index];
            _shops[_shopIds[shopAddress]].items[tokenId];
            require(_shops[_shopIds[shopAddress]].items[tokenId].exist, "No such token");
            require(_shops[_shopIds[shopAddress]].items[tokenId].deliveryId == _deliveryIds[msg.sender], "No such token");
            require(_shops[_shopIds[shopAddress]].items[tokenId].isMinted, "Token not minted");
            require(!_shops[_shopIds[shopAddress]].items[tokenId].isDelivered, "Already delivered");
            require(!_shops[_shopIds[shopAddress]].items[tokenId].isCanceled, "Already canceled");
            require(_shops[_shopIds[shopAddress]].items[tokenId].owner == owner, "Not owner");
            fullPrice += _shops[_shopIds[shopAddress]].items[tokenId].price;
        }

        // require(
        //     !_recipiets[tokenId].isAvailable,
        //     "Token not available for mint"
        // );
        /* logic of transfer eth to courier and proj owner */
        uint256 ethToOwner = fullPrice.div(100)*1 + 100;
        uint256 ethToDelivery = fullPrice.div(100)*1+100000;/* edit minimal prices */
        // uint256 ethToShop = fullPrice - ethToOwner - ethToDelivery;
        _shops[_shopIds[shopAddress]].availableBalance +=  fullPrice - ethToOwner - ethToDelivery;
        _deliveries[_deliveryIds[msg.sender]].availableBalance += ethToDelivery;
        _availableBalance +=ethToOwner;
        // uint256 ethToOwner = 50;
        // uint256 ethToDelivery = 50;
        // // https://pastebin.com/DHBzh9eM
        // // https://ethereum.stackexchange.com/questions/114948/how-to-integrate-2-5-sales-fee-in-an-nft-marketplace
        // uint256 ethToShop = fullPrice - 100;
        /* instead of transfers, all the balance will be contains in smartcontract */
        // (bool transferToOwner, ) = _owner.call{value: ethToOwner}("");
        // require(transferToOwner, "Transfer to project owner failure");
        // (bool transferToDelivery, ) = msg.sender.call{value: ethToDelivery}("");
        // require(transferToDelivery, "Transfer to delivery failure");
        // _availableShopBalance += ethToShop; /* minus comissions */
        for (uint256 index = 0; index < tokenIds.length; index++) {
            uint256 tokenId = tokenIds[index];
            _shops[_shopIds[shopAddress]].items[tokenId].isDelivered = true;
        }
        // emit Delivery(
        //     msg.sender,
        //     tokenIds,
        //     ethToOwner,
        //     ethToDelivery,
        //     ethToShop
        // );
    }
    /* CANCEL ORDER */
    function cancelItems(address shopAddress, uint256[] memory tokenIds)
        external
        payable
        onlyCustomer
        /* onlyCustomer || onlyDelivery */
    {
        /* payable!!! msg.value */
        /* 1% to shop + fixed gas fees */
        // require(_customers[_customerIds[msg.sender]].exist || , "Not a customer");
        uint256 priceToCancel;
        for (uint256 index = 0; index < tokenIds.length; index++) {
            uint256 tokenId = tokenIds[index];
            require(
                _shops[_shopIds[shopAddress]].items[tokenId].exist,
                "No such token"
            );
            require(
                _shops[_shopIds[shopAddress]].items[tokenId].isMinted,
                "Token not minted"
            );
            require(
                !_shops[_shopIds[shopAddress]].items[tokenId].isDelivered,
                "Already delivered"
            );
            require(
                !_shops[_shopIds[shopAddress]].items[tokenId].isCanceled,
                "Already canceled"
            );
            require(
                _shops[_shopIds[shopAddress]].items[tokenId].owner ==
                    msg.sender,
                "Not owner"
            );
            priceToCancel += _shops[_shopIds[shopAddress]].items[tokenId].price;
        }

        require(
            msg.value == 1000, /* 0.05 * priceToCancel */
            "Not enough ether to cancel"
        );
        uint256 ethToOwner = 50;
        uint256 ethToCanceler = priceToCancel - 100;

        (bool transferToOwner, ) = _owner.call{value: ethToOwner}("");
        require(transferToOwner, "Transfer to project owner failure");
        (bool transferToCanceler, ) = msg.sender.call{value: ethToCanceler}("");
        require(transferToCanceler, "Transfer to delivery failure");
        _shops[_shopIds[shopAddress]].availableBalance += msg.value; /* minus comissions */
        // _availableShopBalance -= priceToCancel; /* minus comissions */
        for (uint256 index = 0; index < tokenIds.length; index++) {
            _shops[_shopIds[shopAddress]]
                .items[tokenIds[index]]
                .isCanceled = true;
            _shops[_shopIds[shopAddress]]
                .items[tokenIds[index]]
                .isAvailable = false;
        }
    }

    /* GET CURRENT _STRUCTID */
    function getShops() external view returns (uint256/* address[] memory */) {
        // return _shopAddresses;
        return _shopId;
    }

    function getDeliveries() external view returns (uint256/* address[] memory */) {
        // return _deliveryAddresses;
        return _deliveryId;
    }
    /* ADD DELIVERY METHODS */
    function addDeliveryMethodToShops(uint256[] memory shopIds) external onlyDelivery{
        /* mb add modifier to shop too, like a p2p */
        for (uint256 index = 0; index < shopIds.length; index++) {
            _deliveries[_shopIds[msg.sender]].isAvailableForShop[shopIds[index]] = true;
        }
    }
    /* ADD STRUCTS */
    function addDelivery(
        string memory title,
        string memory metaUri,
        address deliveryOwnerWalletAddress,
        uint256 deliveryPrice
    )
        external
        // address[][] memory servicedStoreAddresses /* unnecessary, deliveries can add from delivery contract */
        onlyOwner
    {
        require(bytes(title).length > 0&&bytes(metaUri).length > 0&&deliveryOwnerWalletAddress != address(0),"Invalid args");
        _deliveryIds[deliveryOwnerWalletAddress] = _deliveryId;
        _deliveries[_deliveryId];
        _shops[_shopId].metaUri = metaUri;
        _deliveries[_deliveryId].title = title;
        _deliveries[_deliveryId].exist = true;
        _deliveries[_deliveryId].deliveryPrice = deliveryPrice;
        // _deliveryAddresses.push(
        //     deliveryOwnerWalletAddress
        //     // address(new ShopOwner(address(this), shopOwnerWalletAddress))
        // );
        _deliveryId++;
    }

    function addCustomer (string memory title, string memory metaUri) external {
        require(bytes(title).length > 0&&bytes(metaUri).length > 0,"Invalid args");
        _customerIds[msg.sender] = _customerId;
        _customers[_customerId].exist = true;
        _customers[_customerId].title = title;
        _customers[_customerId].metaUri = metaUri;
        // _customerAddresses.push(msg.sender);
        _customerId++;
    }
    function addShop(
        string memory title,
        string memory metaUri,
        address shopOwnerWalletAddress
    ) external onlyOwner {
        require(bytes(title).length > 0&&bytes(metaUri).length > 0&&shopOwnerWalletAddress != address(0),"Invalid args");
        _shopIds[shopOwnerWalletAddress] = _shopId;
        // _shops[_shopId];
        _shops[_shopId].metaUri = metaUri;
        _shops[_shopId].title = title;
        _shops[_shopId].exist = true;
        // _shopAddresses.push(
        //     shopOwnerWalletAddress
        //     // address(new ShopOwner(address(this), shopOwnerWalletAddress))
        // );
        _shopId++;
    }
    /* CHANGE DATA IN STRUCTS, items change need too */
    function changeShop(
        string memory title,
        string memory metaUri
    ) external onlyShop {
        if (bytes(title).length > 0) _shops[_shopIds[msg.sender]].title = title;
        if (bytes(metaUri).length > 0) _shops[_shopIds[msg.sender]].metaUri = metaUri;
    }
    function changeDelivery(
        string memory title,
        string memory metaUri,
        uint256 deliveryPrice
    ) external onlyDelivery {
        if (bytes(title).length > 0) _deliveries[_deliveryIds[msg.sender]].title = title;
        if (bytes(metaUri).length > 0) _deliveries[_deliveryIds[msg.sender]].metaUri = metaUri;
        if(deliveryPrice > 0) _deliveries[_deliveryIds[msg.sender]].deliveryPrice = deliveryPrice;
    }
    function changeCustomer(
        string memory title,
        string memory metaUri
    ) external onlyCustomer {
        if (bytes(title).length > 0) _customers[_customerIds[msg.sender]].title = title;
        if (bytes(metaUri).length > 0) _customers[_customerIds[msg.sender]].metaUri = metaUri;
    }
    /* CHANGE ITEMS */
    function changeItems(
        uint256[] memory tokenIds, extBoolean[]memory availablity, uint256[] memory prices,string[] memory metaUris
    ) external onlyShop returns (uint256[] memory,bool[] memory,uint256[] memory,string[] memory){
        require(
            tokenIds.length == availablity.length && 
            tokenIds.length == prices.length && 
            tokenIds.length == metaUris.length,
            "Invalid args"
        );
        bool[] memory _availablity = new bool[](availablity.length);
        uint256[] memory _prices = new uint256[](prices.length);
        string[] memory _metaUris = new string[](metaUris.length);
        for (uint256 index = 0; index < tokenIds.length; index++) {
            _shops[_shopIds[msg.sender]].items[tokenIds[index]];
            require(_shops[_shopIds[msg.sender]].items[tokenIds[index]].exist, "Token doesn't exist");
            require(!_shops[_shopIds[msg.sender]].items[tokenIds[index]].isMinted, "Token already minted");
            if(bytes(metaUris[index]).length > 0) {
            _shops[_shopIds[msg.sender]].items[tokenIds[index]].metaUri = metaUris[index];
                _metaUris[index] = metaUris[index];
                }
            else {
                _metaUris[index] = _shops[_shopIds[msg.sender]].items[tokenIds[index]].metaUri;
            }
            if(prices[index] >/* minimal price */ 100000) {
                _shops[_shopIds[msg.sender]].items[tokenIds[index]].price = prices[index];
                _prices[index] = prices[index];
                }
            else {
                _prices[index] = _shops[_shopIds[msg.sender]].items[tokenIds[index]].price;
            }
            if(availablity[index] == extBoolean.False){
                _shops[_shopIds[msg.sender]].items[tokenIds[index]].isAvailable = false;
                // _availablity[index] = false;
            }
            else if(availablity[index] == extBoolean.True){
                _shops[_shopIds[msg.sender]].items[tokenIds[index]].isAvailable = true;
                _availablity[index] = true;
            }
            else{
                _availablity[index] = _shops[_shopIds[msg.sender]].items[tokenIds[index]].isAvailable;

            }


        }
        return (tokenIds,_availablity,_prices,_metaUris);
    }
    function getCustomer()public view returns(string memory, string memory){
        // Customer storage customer = _customers[_customerIds[msg.sender]];
        return(_customers[_customerIds[msg.sender]].title,_customers[_customerIds[msg.sender]].metaUri);
    }
    

    /* ADD DATA CHANGING, COMISSIONS AND READ ALL THE COMMENTS, ADD EVENTS, REURNS AND SO ON */
    /* ADD MINIMAL PRICE +delivery constant price */
}


