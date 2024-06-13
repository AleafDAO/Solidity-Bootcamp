// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "./ERC20.sol";
import "./ERC721.sol";

contract Market {
    // 定义ERC20和ERC721合约的实例
    ERC20 public erc20;
    MyNFT public nft;

    // 结构体定义一个Listing
    struct Listing {
        address seller;
        uint256 price;
    }

    // 存储所有上架的NFT
    mapping(uint256 => Listing) public listings;

    // 事件：NFT上架
    event NFTListed(uint256 tokenId, address seller, uint256 price);
    // 事件：NFT购买
    event NFTPurchased(uint256 tokenId, address buyer, uint256 price);

    constructor(address _erc20Address, address _nftAddress) {
        erc20 = ERC20(_erc20Address);
        nft = MyNFT(_nftAddress);
    }

    // NFT上架函数
    function listNFT(uint256 tokenId, uint256 price) external {
        require(nft.ownerOf(tokenId) == msg.sender, "You do not own this NFT");
        nft.transferFrom(msg.sender, address(this), tokenId);  // 将NFT转移到市场合约

        listings[tokenId] = Listing({
            seller: msg.sender,
            price: price
        });

        emit NFTListed(tokenId, msg.sender, price);
    }

    // NFT购买函数
    function purchaseNFT(uint256 tokenId) external {
        Listing memory listing = listings[tokenId];
        require(listing.price > 0, "This NFT is not for sale");

        // 转移ERC20代币从买家到卖家
        require(erc20.transferFrom(msg.sender, listing.seller, listing.price), "Token transfer failed");

        // 将NFT转移给买家
        nft.transferFrom(address(this), msg.sender, tokenId);

        // 删除listing
        delete listings[tokenId];

        emit NFTPurchased(tokenId, msg.sender, listing.price);
    }
}