// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract Market is Ownable, ReentrancyGuard {
    IERC20 public token; // ERC20代币合约实例
    IERC721 public nft; // ERC721 NFT合约实例

    struct Listing {
        address seller; // 卖家地址
        uint256 price; // NFT价格（以ERC20代币计价）
    }

    // NFT ID到Listing详情的映射
    mapping(uint256 => Listing) public listings;

    // 事件：NFT上架
    event Listed(uint256 indexed tokenId, address indexed seller, uint256 price);
    // 事件：NFT被购买
    event Purchased(uint256 indexed tokenId, address indexed buyer, uint256 price);
    // 事件：NFT下架
    event Delisted(uint256 indexed tokenId, address indexed seller);

    /**
     * 构造函数
     */
    constructor(address owner) Ownable(owner) ReentrancyGuard() {
        token = IERC20(0x9423C692C10554f5e23C451f84F07ad7e513891E); // 设置ERC20代币合约地址
        nft = IERC721(0x167cD78c5522e9aAba4f970b8Df6485598bc910C); // 设置ERC721 NFT合约地址
    }

    /**
     * 上架NFT
     * @param tokenId NFT的ID
     * @param price 以ERC20代币计价的价格
     */
    function listNFT(uint256 tokenId, uint256 price) external nonReentrant {
        require(nft.ownerOf(tokenId) == msg.sender, "You do not own this NFT"); // 检查调用者是否为NFT的持有者
        require(price > 0, "Price must be greater than zero"); // 检查价格是否大于零

        nft.transferFrom(msg.sender, address(this), tokenId); // 将NFT从持有者转移到合约
        listings[tokenId] = Listing({
            seller: msg.sender,
            price: price
        });

        emit Listed(tokenId, msg.sender, price); // 触发上架事件
    }

    /**
     * 下架NFT
     * @param tokenId NFT的ID
     */
    function delistNFT(uint256 tokenId) external nonReentrant {
        Listing memory listing = listings[tokenId];
        require(listing.seller == msg.sender, "You are not the seller"); // 检查调用者是否为卖家

        nft.transferFrom(address(this), msg.sender, tokenId); // 将NFT从合约转移回卖家
        delete listings[tokenId]; // 删除上架记录

        emit Delisted(tokenId, msg.sender); // 触发下架事件
    }

    /**
     * 购买NFT
     * @param tokenId NFT的ID
     */
    function purchaseNFT(uint256 tokenId) external nonReentrant {
        Listing memory listing = listings[tokenId];
        require(listing.price > 0, "NFT not listed for sale"); // 检查NFT是否已上架

        require(token.transferFrom(msg.sender, listing.seller, listing.price), "Token transfer failed"); // 将代币从买家转移到卖家
        nft.transferFrom(address(this), msg.sender, tokenId); // 将NFT从合约转移到买家

        delete listings[tokenId]; // 删除上架记录

        emit Purchased(tokenId, msg.sender, listing.price); // 触发购买事件
    }

    /**
     * 获取NFT的上架信息
     * @param tokenId NFT的ID
     * @return 卖家地址和价格
     */
    function getListing(uint256 tokenId) external view returns (address, uint256) {
        Listing memory listing = listings[tokenId];
        return (listing.seller, listing.price);
    }
}
