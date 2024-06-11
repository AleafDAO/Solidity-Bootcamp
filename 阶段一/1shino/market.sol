// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// IERC721 Interface from OpenZeppelin
interface IERC721 {
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    function balanceOf(address owner) external view returns (uint256 balance);
    function ownerOf(uint256 tokenId) external view returns (address owner);
    function safeTransferFrom(address from, address to, uint256 tokenId) external;
    function transferFrom(address from, address to, uint256 tokenId) external;
    function approve(address to, uint256 tokenId) external;
    function getApproved(uint256 tokenId) external view returns (address operator);
    function setApprovalForAll(address operator, bool _approved) external;
    function isApprovedForAll(address owner, address operator) external view returns (bool);
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes calldata data) external;
}

// IERC20 Interface from OpenZeppelin
interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

// ShinoMarket Contract
contract ShinoMarket {
    IERC721 public nft;
    IERC20 public token;
    mapping(uint256 => uint256) public prices;
    mapping(uint256 => address) public sellers;
    event nftlisted(uint256 indexed tokenId, address indexed seller, uint256 price);
    event nftsold(uint256 indexed tokenId, address indexed seller, address indexed buyer, uint256 price);

    constructor(address _tokenAddress, address _nftAddress) {
        token = IERC20(_tokenAddress);
        nft = IERC721(_nftAddress);
    }
//上架
    function listnft(uint256 _price, uint256 _tokenId) public {
        require(nft.ownerOf(_tokenId) == msg.sender);
        require(nft.getApproved(_tokenId) == address(this));
        prices[_tokenId] = _price;
        sellers[_tokenId] = msg.sender;
        emit nftlisted(_tokenId, msg.sender, _price);
    }
//购买
    function buynft(uint256 _tokenId) public {
        uint256 price = prices[_tokenId];
        address seller = sellers[_tokenId];
        require(price > 0);
        require(token.balanceOf(msg.sender) >= price, "unenough balance");
        require(token.transferFrom(msg.sender, seller, price), "no transfer");
        nft.transferFrom(seller, msg.sender, _tokenId);
        prices[_tokenId] = 0;
        sellers[_tokenId] = address(0);
        emit nftsold(_tokenId, seller, msg.sender, price);
    }
}