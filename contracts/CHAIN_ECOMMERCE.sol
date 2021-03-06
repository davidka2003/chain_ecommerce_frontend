// SPDX-License-Identifier: GPL-3.0
// pragma solidity >=0.7.0 <0.9.0;
pragma solidity ^0.8.0;
import "./ReentrancyGuard.sol";
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
///@title CHAIN_ECOMMERCE 8623763 gas
contract Chain_ecommerce is ReentrancyGuard{
    string public constant CUSTOMER_NOT_EXIST = "Customer doesn't exist";
    string public constant SHOP_NOT_EXIST = "Shop doesn't exist";
    string public constant DELIVERY_NOT_EXIST = "Delivery doesn't exist";
    string public constant ITEM_NOT_EXIST = "Item doesn't exist";
    string public constant ADDRESS_NOT_EXIST = "Address doesn't exist";
    string public constant NOT_ENOUGH_ETHER = "Not enough ether";
    string public constant TRANSFER_FAILURE = "Transfer failure";
    string public constant INVALID_ARGS = "Invalid args";
    string public constant ALREADY_MINTED = "Item already minted";
    string public constant ALREADY_DELIVERED = "Already delivered";
    string public constant ALREADY_CANCELED = "Already canceled";
    string public constant ORDER_NOT_EXIST = "Order not exist";
    uint256 public constant MINIMAL_PRICE = 0.5 ether;
    uint256 public constant FIXED_COMISSION = 0.1 ether;
    string public constant DEFAULT_META_URI = "DEFAULT_META_URI";
    using SafeMath for uint256;
    uint256 private _shopId = 1;/* if 0 _customers[_customerIds[msg.sender]] always would return customer with 0 id for non existing addresses */
    uint256 private _deliveryId = 1;
    uint256 private _customerId = 1;
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
        string title;
        uint256 tokenId;
        string metaUri;
        uint256 ownerId;
        uint256 shopId;
        uint256 price;
        bool isAvailable;/* shop can change that before mint */
        // bool isApprovedForDelivery;
        bool isDelivered;
        bool isMinted;
        bool isCanceled;
        // uint256 deliveryId;
        // uint256 deliveryPrice;
    }
    struct Shop {
        uint256 shopId;
        string metaUri; /* shop metadata */
        string title;
        bool isBanned;
        bool exist;
        uint256 _itemId;
        mapping(uint256 => Item) items;
        // uint256[] _itemIdsArray;
        uint256 availableBalance; /* available to withdraw */
    }
    struct Order{
        uint256[] itemIds;
        string metaUri;
        uint256 orderId;
        uint256 shopId;
        uint256 deliveryId;
        string hashedAddress;
        string country;
        string city;
        uint256 ownerId;
        uint256 deliveryPrice;
        uint256 itemsPrice;
        bool isApprovedForDelivery;
        bool isDelivered;
        bool isCanceled;
        bool exist;
    }
    struct Delivery {
        /* or _countries array */
        uint256 deliveryId;
        // uint256 deliveryPrice;
        string metaUri; /* shop metadata */
        string title;
        bool exist;
        bool isBanned;
        uint256 _orderId;
        mapping(string => mapping(string=> uint256)) destinationPrice;/* country=>city=>price */
        mapping(uint256 => bool) isAvailableForShop; /* shopId => availability*/
        mapping(uint256=>Order) orders;/* orderId => Order */
        uint256[] _shopIds;
        uint256 availableBalance; /* available to withdraw */
    }
    struct Customer {
        // mapping(address=>bool) wallets;/* wallet address => isExist */
        uint256 customerId;
        string metaUri;
        string title;
        bool exist;
        mapping(uint256=>mapping(uint256=>Order)) _orders;
        mapping(uint256 => Order[]) orders;/* shopId => order[] */
        uint256[] _shops;
        /* add shops array to get orders from shops */
    }
    /* STORAGE */
    /* Customers storage */
    /** 
    @dev address customer address
    @dev uint256 customer id
    */ 
    mapping(address => uint256) private _customerIds;/* customer address => customerId */
    /** 
    @dev uint256 customer id
    @dev Customer
    */ 
    mapping(uint256 => Customer) private _customers;/* customerId => code accessable struct */
    /* Shops storage */
    /** 
    @dev address shop address
    @dev uint256 shop id
    */ 
    mapping(address => uint256) private _shopIds;/* shop address => shopId */
    /** 
    @dev uint256 shop id
    @dev Shop
    */ 
    mapping(uint256 => Shop) private _shops;/* shopId => code accessable struct */
    /* Deliveries storage */
    /** 
    @dev address delivery address
    @dev uint256 delivery id
    */ 
    mapping(address => uint256) private _deliveryIds;/* delivery address => deliveryId */
    /** 
    @dev uint256 delivery id
    @dev Delivery
    */ 
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
        if(!_customers[_customerIds[msg.sender]].exist) addCustomer("CUSTOMER",DEFAULT_META_URI);
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
        require(address(0) != addr, ADDRESS_NOT_EXIST);
        _owner = addr;
        return addr;
    }

    function changeShopOwner(address addr) external onlyShop returns (address) {
        require(address(0) != addr, ADDRESS_NOT_EXIST);
        require(!_shops[_shopIds[addr]].exist,"Shop with this address already exist");
        _shopIds[addr] = _shopIds[msg.sender];
        delete _shopIds[msg.sender];
        return addr;
    }
    function changeCustomerOwner(address addr) external onlyCustomer returns (address) {
        require(address(0) != addr, ADDRESS_NOT_EXIST);
        require(!_customers[_customerIds[addr]].exist,"Customer with this address already exist");
        _customerIds[addr] = _customerIds[msg.sender];
        delete _customerIds[msg.sender];
        return addr;
    }
    function changeDeliveryOwner(address addr)
        external
        onlyDelivery
        returns (address)
    {
        require(address(0) != addr, ADDRESS_NOT_EXIST);
        require(!_deliveries[_deliveryIds[addr]].exist,"Delivery with this address already exist");
        _deliveryIds[addr] = _deliveryIds[msg.sender];
        delete _deliveryIds[msg.sender];
        // _deliveries[_deliveryIds[msg.sender]].owner = addr;
        return addr;
    }
    /* WITHDRAWING BALANCE */
    function withdrawShopBalance(address payable addr, uint256 amount)
        external
        onlyShop
        nonReentrant
        returns (address, uint256)
    {
        require(addr != address(0), ADDRESS_NOT_EXIST);
        require(
            _shops[_shopIds[msg.sender]].availableBalance >= amount,
            NOT_ENOUGH_ETHER
        );
        _shops[_shopIds[msg.sender]].availableBalance -= amount;
        (bool sent, ) = addr.call{value: amount}("");
        require(sent, TRANSFER_FAILURE);
        return (addr, amount);
    }

    function withdrawDeliveryBalance(address payable addr, uint256 amount)
        external
        onlyDelivery
        nonReentrant
        returns (address, uint256)
    {
        require(addr != address(0), ADDRESS_NOT_EXIST);
        require(
            _deliveries[_deliveryIds[msg.sender]].availableBalance >= amount,
            NOT_ENOUGH_ETHER
        );
        _deliveries[_deliveryIds[msg.sender]].availableBalance -= amount;
        (bool sent, ) = addr.call{value: amount}("");
        require(sent, TRANSFER_FAILURE);
        return (addr, amount);
    }

    function withdrawBalance(address payable addr, uint256 amount)
        external
        onlyOwner
        nonReentrant
        returns (address, uint256)
    {
        require(addr != address(0), ADDRESS_NOT_EXIST);
        require(_availableBalance >= amount, NOT_ENOUGH_ETHER);
        _availableBalance -= amount;
        (bool sent, ) = addr.call{value: amount}("");
        require(sent, TRANSFER_FAILURE);
        return (addr, amount);
    }
    /* BAN SETTERS */
    function setDeliveryBan(uint256 deliveryId, bool _isBanned)
        external
        onlyOwner
        returns (bool)
    {
        require(
            _deliveries[deliveryId].exist,
            DELIVERY_NOT_EXIST
        );
        _deliveries[deliveryId].isBanned = _isBanned;
        return _isBanned;
    }

    function setShopBan(uint256 shopId, bool _isBanned)
        external
        onlyOwner
        returns (bool)
    {
        require(_shops[shopId].exist, SHOP_NOT_EXIST);
        _shops[shopId].isBanned = _isBanned;
        return _isBanned;
    }
    /* BAN GETTERS */
    /* ADD ITEMS, EDIT RETURN OR ADD EMIT */
    function addItems(string[] memory metaUris, uint256[] memory prices, string[] memory titles)
        external
        onlyShop
        shopBanCheck(_shopIds[msg.sender])
        returns (Item[] memory)
    {
        
        require(metaUris.length == prices.length&&titles.length == metaUris.length, INVALID_ARGS);
        for (uint256 index = 0; index < prices.length; index++) {
            require(prices[index]>MINIMAL_PRICE, "Price too low");
            require(bytes(metaUris[index]).length>0,"Invalid metaUri");
            require(bytes(titles[index]).length>0,"Invalid title");
        }
        Shop storage shop = _shops[_shopIds[msg.sender]];
        Item[] memory items = new Item[](metaUris.length);
        for (uint256 index = 0; index < metaUris.length; index++) {
            Item storage item = _shops[_shopIds[msg.sender]].items[_shops[_shopIds[msg.sender]]._itemId];            
            item.title = titles[index];
            item.metaUri = metaUris[index];
            item.price = prices[index];
            item.shopId = _shopIds[msg.sender];
            item.ownerId = 0;/* non-existing id */
            item.isAvailable = true;
            item.exist = true;
            item.tokenId = shop._itemId;
            shop._itemId++;
            items[index] = item;
        }
        return items;
        // emit AddReceipts(metaUris, ids, prices);
    }
    /* ITEMS MINTING */
    function mintItems(
        uint256 shopId,
        uint256[] memory tokenIds,
        uint256 deliveryId,
        string memory sessionId, /* bcrypted!!!! */
        string memory country,
        string memory city,
        string memory hashedAddress
    )
        external
        payable
        onlyCustomer
        shopBanCheck(shopId)
        returns (
            Order memory _order,
            string memory _sessionid
        )
    {
        uint256 fullPrice;
        // Shop storage shop = _shops[shopId];
        // Delivery storage delivery = _deliveries[deliveryId];
        // Customer storage customer = _customers[_customerIds[msg.sender]];
        Order storage order = _deliveries[deliveryId].orders[_deliveries[deliveryId]._orderId];
        require(!order.exist, "Order already exist");
        require(_shops[shopId].exist,SHOP_NOT_EXIST);
        require(_deliveries[deliveryId].exist,DELIVERY_NOT_EXIST);
        require(_deliveries[deliveryId].destinationPrice[country][city]>0,"Can't be delivered");
        require(_deliveries[deliveryId].isAvailableForShop[shopId],
            "Delivery not available for shop"
        );
        for (uint256 index = 0; index < tokenIds.length; index++) {
            // uint256 tokenId = tokenIds[index];
            // Item memory item = shop.items[tokenIds[index]];
            require(
                _shops[shopId].items[tokenIds[index]].exist,
                ITEM_NOT_EXIST
            );
            require(
                !_shops[shopId].items[tokenIds[index]].isMinted,
                ALREADY_MINTED
            );
            require(
                _shops[shopId].items[tokenIds[index]].isAvailable,
                "Token not available for mint"
            );
            fullPrice += _shops[shopId].items[tokenIds[index]].price;
        }
        require(msg.value == fullPrice+_deliveries[deliveryId].destinationPrice[country][city], NOT_ENOUGH_ETHER);
        /* add shopId to customer if no orders */
        if(_customers[_customerIds[msg.sender]].orders[shopId].length == 0){
            _customers[_customerIds[msg.sender]]._shops.push(shopId);
        }
        for (uint256 index = 0; index < tokenIds.length; index++) {
            // uint256 tokenId = tokenIds[index];
            // Item storage item = shop.items[tokenIds[index]];
            _shops[shopId].items[tokenIds[index]].ownerId = _customerIds[msg.sender];
            _shops[shopId].items[tokenIds[index]].isMinted = true;
            _shops[shopId].items[tokenIds[index]].isAvailable = false;
            order.itemIds.push(tokenIds[index]);

        }
        order.ownerId = _customerIds[msg.sender];
        order.orderId = _deliveries[deliveryId]._orderId;
        order.shopId = shopId;
        order.deliveryId = deliveryId;
        order.hashedAddress = hashedAddress;
        order.country = country;
        order.city = city;
        order.exist = true;
        order.itemsPrice = fullPrice;
        order.deliveryPrice = _deliveries[deliveryId].destinationPrice[country][city];
        _customers[_customerIds[msg.sender]].orders[shopId].push(order);
        _customers[_customerIds[msg.sender]]._orders[shopId][_deliveries[deliveryId]._orderId] = order;
        _deliveries[deliveryId]._orderId+=1;
        return (order, sessionId);
    }
    /* decline for delivery add */
    function acceptForDelivery(uint256 orderId, string memory metaUri) external onlyDelivery returns (Order memory){
        Delivery storage delivery = _deliveries[_deliveryIds[msg.sender]];
        Order storage order = _deliveries[_deliveryIds[msg.sender]].orders[orderId];
        Shop storage shop = _shops[order.shopId];
        require(shop.exist,SHOP_NOT_EXIST);
        require(order.exist,ORDER_NOT_EXIST);
        require(!order.isApprovedForDelivery,"Already approved fro delivery");
        require(!order.isCanceled,ALREADY_CANCELED);
        require(delivery.destinationPrice[order.country][order.city]>0,"Couldn't be delivered");
        require(delivery.isAvailableForShop[order.shopId],"Delivery method not available for shop");

        order.metaUri = metaUri;
        order.isApprovedForDelivery = true;
        return order;
    }
    /* DELIVERY APPROVAL */
    function approveDelivery(uint256 shopId,uint256 orderId, address owner,string memory /* as sessionId */deliverySessionId) external onlyDelivery returns(Order memory _order,string memory sessionId){
        /* for couriers only */
        Shop storage shop = _shops[shopId];
        Delivery storage delivery = _deliveries[_deliveryIds[msg.sender]];
        Order storage order = delivery.orders[orderId];
        require(order.exist,ORDER_NOT_EXIST);
        require(order.isApprovedForDelivery,"Not approved for delivery");
        require(!order.isDelivered, ALREADY_DELIVERED);
        require(order.ownerId == _customerIds[owner], "Not an owner");
        /* logic of transfer eth to courier and proj owner */
        uint256 ethToOwner = order.itemsPrice.div(100)*1 + FIXED_COMISSION;
        uint256 ethToDelivery = order.itemsPrice.div(100)*1+order.deliveryPrice;/* edit minimal prices */
        // uint256 ethToShop = fullPrice - ethToOwner - ethToDelivery;
        shop.availableBalance +=  order.itemsPrice - ethToOwner - ethToDelivery;
        delivery.availableBalance += ethToDelivery;
        _availableBalance +=ethToOwner;
        for (uint256 index = 0; index < order.itemIds.length; index++) {
            uint256 tokenId = order.itemIds[index];
            shop.items[tokenId].isDelivered = true;
        }
        order.isDelivered = true;
        return (order,deliverySessionId);

    }
    /* CANCEL ORDER */
    function cancelOrder(uint256 shopId, uint256 orderId)
        external
        payable
        onlyCustomer
        nonReentrant
        returns(Order memory)
        /* onlyCustomer || onlyDelivery */
    {
        Shop storage shop = _shops[shopId];
        Customer storage customer = _customers[_customerIds[msg.sender]];
        Order storage order = customer._orders[shopId][orderId];
        require(shop.exist,SHOP_NOT_EXIST);
        require(order.exist,ORDER_NOT_EXIST);
        require(!order.isApprovedForDelivery,"Already approved for delivery");
        require(!order.isCanceled,ALREADY_CANCELED);
        /* 1% to shop + fixed gas fees */
        require(
            msg.value == FIXED_COMISSION, /* 0.05 * priceToCancel */
            NOT_ENOUGH_ETHER
        );
        uint256 ethToShop = order.itemsPrice.div(100) * 1;
        uint256 ethToCanceler = order.itemsPrice+order.deliveryPrice - ethToShop;
        uint256 ethToOwner = FIXED_COMISSION;
        // uint256 ethToCanceler = priceToCancel;
        _availableBalance += ethToOwner;
        shop.availableBalance += ethToShop;
        for (uint256 index = 0; index < order.itemIds.length; index++) {
            Item storage item = shop.items[order.itemIds[index]];
            item.isCanceled = true;
            // item.isAvailable = false;
        }
        order.isCanceled = true;
        (bool transferToCanceler, ) = msg.sender.call{value: ethToCanceler}("");
        require(transferToCanceler, TRANSFER_FAILURE);
        return order;
    }

    /* ADD DELIVERY METHODS */
    function addDeliveryMethodToShops(uint256[] memory shopIds) external onlyDelivery returns (uint256 id, uint256 [] memory shops){
        /* mb add modifier to shop too, like a p2p */
        Delivery storage delivery = _deliveries[_deliveryIds[msg.sender]];
        for (uint256 index = 0; index < shopIds.length; index++) {
            if(!delivery.isAvailableForShop[shopIds[index]]){
                delivery.isAvailableForShop[shopIds[index]] = true;
                delivery._shopIds.push(shopIds[index]);
            }
        }
        return (_deliveryIds[msg.sender],shopIds);
    }
    function removeDeliveryDestinations(string[]memory _countries,string [] memory _cities) external onlyDelivery returns(string[] memory countries, string[] memory cities){
        require(_countries.length == _cities.length,INVALID_ARGS);
        Delivery storage delivery = _deliveries[_deliveryIds[msg.sender]];
        for (uint256 index = 0; index < _countries.length; index++) {
            delivery.destinationPrice[_countries[index]][_cities[index]] =0;
        }
        return (_countries,_cities);
    }
    function editDeliveryDestinations(string[]memory _countries,string [] memory _cities,uint256 []memory _prices ) external onlyDelivery returns(string[] memory countries, string[] memory cities, uint256 [] memory prices){
        require(_countries.length == _cities.length && _cities.length == _prices.length,INVALID_ARGS);
        Delivery storage delivery = _deliveries[_deliveryIds[msg.sender]];
        for (uint256 index = 0; index < _prices.length; index++) {
            require(_prices[index]>0,INVALID_ARGS);
        }
        for (uint256 index = 0; index < _countries.length; index++) {
            delivery.destinationPrice[_countries[index]][_cities[index]] = _prices[index];
        }
        return (_countries,_cities,_prices);
    }
    /* ADD STRUCTS */
    function addDelivery(
        string memory title,
        string memory metaUri,
        address deliveryOwnerWalletAddress
    )
        external
        onlyOwner
    {
        require(bytes(title).length > 0&&bytes(metaUri).length > 0&&deliveryOwnerWalletAddress != address(0),INVALID_ARGS);
        require(!_deliveries[_deliveryIds[deliveryOwnerWalletAddress]].exist,"Shop already exist");
        _deliveryIds[deliveryOwnerWalletAddress] = _deliveryId;
        _deliveries[_deliveryId];
        _shops[_shopId].metaUri = metaUri;
        _deliveries[_deliveryId].title = title;
        _deliveries[_deliveryId].exist = true;
        _deliveries[_deliveryId].deliveryId = _deliveryId;
        _deliveryId++;
    }
    function addCustomer (string memory title, string memory metaUri) public returns(uint256 id,string memory _title,string memory _metaUri){
        require(bytes(title).length > 0&&bytes(metaUri).length > 0,INVALID_ARGS);
        require(!_customers[_customerIds[msg.sender]].exist,"Customer already exist");
        _customerIds[msg.sender] = _customerId;
        _customers[_customerId].exist = true;
        _customers[_customerId].title = title;
        _customers[_customerId].metaUri = metaUri;
        _customers[_customerId].customerId = _customerId;
        _customerId++;
        return (_customerId-1,title, metaUri);
    }
    function addShop(
        string memory title,
        string memory metaUri,
        address shopOwnerWalletAddress
    ) external onlyOwner {
        require(bytes(title).length > 0&&bytes(metaUri).length > 0&&shopOwnerWalletAddress != address(0),INVALID_ARGS);
        require(!_shops[_shopIds[shopOwnerWalletAddress]].exist,"Shop already exist");
        _shopIds[shopOwnerWalletAddress] = _shopId;
        // _shops[_shopId];
        _shops[_shopId].metaUri = metaUri;
        _shops[_shopId].title = title;
        _shops[_shopId].exist = true;
        _shops[_shopId].shopId = _shopId;
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
        string memory metaUri/* ,
        uint256 deliveryPrice */
    ) external onlyDelivery {
        if (bytes(title).length > 0) _deliveries[_deliveryIds[msg.sender]].title = title;
        if (bytes(metaUri).length > 0) _deliveries[_deliveryIds[msg.sender]].metaUri = metaUri;
        // if(deliveryPrice > 0) _deliveries[_deliveryIds[msg.sender]].deliveryPrice = deliveryPrice;
    }
    function changeCustomer(
        string memory title,
        string memory metaUri
    ) external onlyCustomer returns(string memory _title, string memory _metaUri){
        if (bytes(title).length > 0) _customers[_customerIds[msg.sender]].title = title;
        if (bytes(metaUri).length > 0) _customers[_customerIds[msg.sender]].metaUri = metaUri;
        return (title,metaUri);
    }
    /* CHANGE ITEMS */

    function changeItems(
        uint256[] memory tokenIds, extBoolean[]memory availability, uint256[] memory prices,string[] memory metaUris,
        string [] memory titles
    ) external onlyShop returns (Item[] memory){
        require(
            tokenIds.length == availability.length && 
            tokenIds.length == prices.length && 
            tokenIds.length == metaUris.length&&
            titles.length == tokenIds.length,
            INVALID_ARGS
        );
        Shop storage shop = _shops[_shopIds[msg.sender]];
        for (uint256 index = 0; index < tokenIds.length; index++) {
            shop.items[tokenIds[index]];
            Item memory item = shop.items[tokenIds[index]];
            require(item.exist, ITEM_NOT_EXIST);
            require(!item.isMinted, ALREADY_MINTED);
        }
        Item[] memory _items = new Item[](tokenIds.length);
        for (uint256 index = 0; index < tokenIds.length; index++) {
            Item storage item = shop.items[tokenIds[index]];
            if(bytes(metaUris[index]).length > 0) {
                item.metaUri = metaUris[index];
                }
            if(bytes(titles[index]).length > 0) {
                item.title = titles[index];
            }
            if(prices[index] >MINIMAL_PRICE) {
                item.price = prices[index];
            }
            if(availability[index] == extBoolean.False){
                item.isAvailable = false;
            }
            else if(availability[index] == extBoolean.True){
                item.isAvailable = true;
            }
            _items[index] = item;
        }
        return _items;
    }
    /* GETTERS */
    function getItem(uint256 shopId, uint256 itemId)
        external
        view
        returns (Item memory)
    {
        require(
            _shops[shopId].items[itemId].exist,
            ITEM_NOT_EXIST
        );
        return _shops[shopId].items[itemId];
    }
    function getItemsBatch(uint256[]memory shopIds, uint256[]memory itemIds) public view returns (Item[]memory){
        require(shopIds.length == itemIds.length, INVALID_ARGS);
        Item[] memory items = new Item[](itemIds.length);
        for (uint256 index = 0; index < items.length; index++) {
            require(_shops[shopIds[index]].exist,SHOP_NOT_EXIST);
            require( _shops[shopIds[index]].items[itemIds[index]].exist, ITEM_NOT_EXIST);
            items[index] = _shops[shopIds[index]].items[itemIds[index]];
        }
        return items;
    }
    function getCustomers() external view returns (uint256[] memory/* address[] memory */) {
        // return _shopAddresses;
        uint256[] memory customerIds = new uint256[](_customerId-1);
        for (uint256 index = 0; index < customerIds.length; index++) {
            customerIds[index] = index+1;
        }
        return customerIds;
    }

    function getCustomer(uint256 customerId)public view returns(string memory title, string memory metaUri, uint256 [] memory shops){
        Customer storage customer = _customers[customerId];
        require(customer.exist, CUSTOMER_NOT_EXIST);
        return(customer.title,customer.metaUri, customer._shops);
    }
    function getCustomerId() public view returns (uint256){
        Customer storage customer = _customers[_customerIds[msg.sender]];
        require(customer.exist, CUSTOMER_NOT_EXIST);
        return _customerIds[msg.sender];
    }
    /* onlyServer function nneds cache */
    function getCustomerOrders(uint256 customerId,uint256 shopId)public view returns(Order[] memory){
        // Customer storage customer = _customers[_customerIds[msg.sender]];
        Customer storage customer = _customers[customerId];
        require(customer.exist, CUSTOMER_NOT_EXIST);
        return customer.orders[shopId];
    }
    function getShops() external view returns (uint256[] memory/* address[] memory */) {
        // return _shopAddresses;
        uint256[] memory shopIds = new uint256[](_shopId-1);
        for (uint256 index = 0; index < shopIds.length; index++) {
            shopIds[index] = index+1;
        }
        return shopIds;
    }
    /** 
    @dev return Shop by id
    @param id shop Id
    @dev uint256 shopId, string memory metaUri, string memory title, bool isBanned, uint256 itemId,uint256 balance

     */
    function getShop(uint256 shopId)external view returns(uint256 id,string memory metaUri,string memory title,bool isBanned,uint256 _itemId,uint256 balance){
        Shop storage shop = _shops[shopId];
        require(shop.exist, SHOP_NOT_EXIST);
        return (shop.shopId,shop.metaUri,shop.title,shop.isBanned,shop._itemId, shop.availableBalance);
    }
    function getShopId() public view returns (uint256){
        Shop storage shop = _shops[_shopIds[msg.sender]];
        require(shop.exist, CUSTOMER_NOT_EXIST);
        return _customerIds[msg.sender];
    }
    function getShopItems(uint256 shopId) external view returns(Item[] memory){
        Shop storage shop = _shops[shopId];
        require(shop.exist, SHOP_NOT_EXIST);
        Item[] memory items = new Item [](shop._itemId);
        for (uint256 index = 0; index < items.length; index++) {
            items[index] = shop.items[index];
        }
        return (items);
    } 
    /** 
    @dev highly recommend to use standard codes
      */
    function getDeliveryDestinationsBatch(uint256 deliveryId, string[] memory countries, string[] memory cities) external view returns(uint256 [] memory){
        Delivery storage delivery = _deliveries[deliveryId];
        require(delivery.exist, DELIVERY_NOT_EXIST);
        require(countries.length == cities.length, INVALID_ARGS);
        uint256[] memory prices = new uint256[](countries.length);
        for (uint256 index = 0; index < prices.length; index++) {
            prices[index] = delivery.destinationPrice[countries[index]][cities[index]];
        }
        return prices;
    }
    function getDeliveryPrice(uint256 deliveryId,string memory country,string memory city) public view returns(uint256){
        Delivery storage delivery = _deliveries[deliveryId];
        require(delivery.exist,DELIVERY_NOT_EXIST);
        require(delivery.destinationPrice[country][city]>0,"No price");
        return delivery.destinationPrice[country][city];
    }
    /**
    @dev Get deliveries ids
     @return ids array 
     */
    function getDeliveries() external view returns (uint256[] memory/* address[] memory */) {
        // return _deliveryAddresses;
        uint256[] memory deliveryIds = new uint256[](_deliveryId-1);
        for (uint256 index = 0; index < deliveryIds.length; index++) {
            deliveryIds[index] = index+1;
        }
        return deliveryIds;
    }
    function getDeliveryOrdersBatch(uint256 deliveryId, uint256[]memory orderIds) external view returns (Order[]memory){
        Delivery storage delivery = _deliveries[deliveryId];
        require(delivery.exist, DELIVERY_NOT_EXIST);
        Order [] memory orders = new Order[](orderIds.length);
        for (uint256 index = 0; index < orderIds.length; index++) {
            orders[index] = delivery.orders[orderIds[index]];
        }
        return orders;
    }
    function getDeliveryOrders(uint256 deliveryId) external view returns(uint256[] memory){
        Delivery storage delivery = _deliveries[deliveryId];
        require(delivery.exist, DELIVERY_NOT_EXIST);
        uint256 [] memory ids = new uint256[](delivery._orderId);
        for (uint256 index = 0; index < ids.length; index++) {
            ids[index] = index;
        }
        return ids;
    }
    function getDelivery(uint256 deliveryId)external view returns(uint256 id,string memory metaUri,string memory title,bool isBanned,uint256[] memory shopIds,uint256 balance){
        Delivery storage delivery = _deliveries[deliveryId];
        require(delivery.exist, DELIVERY_NOT_EXIST);
        return (delivery.deliveryId,delivery.metaUri,delivery.title,delivery.isBanned,delivery._shopIds, delivery.availableBalance);
    }
    function getDeliveryId() public view returns (uint256){
        Delivery storage delivery = _deliveries[_deliveryIds[msg.sender]];
        require(delivery.exist, CUSTOMER_NOT_EXIST);
        return _deliveryIds[msg.sender];
    }

    /* ADD DATA CHANGING, COMISSIONS AND READ ALL THE COMMENTS, ADD EVENTS, REURNS AND SO ON */
    /* ADD MINIMAL PRICE +delivery constant price */
}




