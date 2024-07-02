// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "./ERC20.sol"; 
import "./ERC721.sol";

contract market {
    struct Listing {
        address seller;
        uint256 price;
    }
    ERC20 public token;
    SKCNFT public nft;

    // tokenId到Listing的映射
    mapping(uint256 => Listing) public listings;

    event NFTListed(address indexed seller, uint256 indexed tokenId, uint256 price);
    event NFTPurchased(address indexed buyer, uint256 indexed tokenId, uint256 price);

    constructor(address _tokenAddress, address _nftAddress) {
        token = ERC20(_tokenAddress);
        nft = SKCNFT(_nftAddress);
    }

    // 上架NFT
    function listNFT(uint256 tokenId, uint256 price) external {
        require(nft.ownerOf(tokenId) == msg.sender);//确认调用者是该nft的owner
        require(price > 0);//价格必须大于0

        listings[tokenId] = Listing({
            seller: msg.sender,
            price: price
        });

        emit NFTListed(msg.sender, tokenId, price);
    }

    // 购买NFT
    function buyNFT(uint256 tokenId) external {
        Listing memory listing = listings[tokenId];
        require(listing.price > 0);//确认nft已经上架
        //确认买家有足够的ERC20代币余额
        require(token.balanceOf(msg.sender) >= listing.price, "The balance is insufficient");
        //确认买家已经授权合约转移足够的ERC20代币
        require(token.allowance(msg.sender, address(this)) >= listing.price, "Token allowance too low");
        token.transferFrom(msg.sender, listing.seller, listing.price);
        nft.safeTransferFrom(listing.seller, msg.sender, tokenId);
        emit NFTPurchased(msg.sender, tokenId, listing.price);
    }
}