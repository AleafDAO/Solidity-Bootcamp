// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC721.sol";
import "./ERC20.sol";

contract NFTMarket {
    ERC20 public token;
    MyNFT public nft;
    event List(address indexed seller,uint256 indexed tokenId, uint256 price);
    event Purchase(address indexed buyer,  uint256 indexed tokenId, uint256 price);
    event Revoke(address indexed seller,  uint256 indexed tokenId);    
    event Update(address indexed seller,  uint256 indexed tokenId, uint256 newPrice);

    struct Listing {
        address seller;
        uint256 price;
    }

   mapping(uint256 => Listing) public nftlist;

    constructor(address tokenAddress, address nftAddress) {
        token = ERC20(tokenAddress);
        nft = MyNFT(nftAddress);
    }
    //购买
    function buynft(uint256 _tokenId) public {
        Listing storage _order = nftlist[_tokenId]; //设置NF持有人和价格
        uint256 price = _order.price;
        address seller = _order.seller; 
        require(price > 0);
        require(token.balanceOf(msg.sender) >= price, "unenough balance");
        require(token.transferFrom(msg.sender, seller, price), "no transfer");
        nft.transferFrom(address(this), msg.sender, _tokenId);
        _order.price= 0;
        _order.seller= address(0);
        delete nftlist[_tokenId];
        emit Purchase(msg.sender, _tokenId, price);
    }
    //上架

    function list(uint256 _tokenId, uint256 _price) public {

        require(nft.getApproved(_tokenId) == address(this), "Need Approval"); // 合约得到授权
        require(_price > 0); // 价格大于0

        Listing storage _order = nftlist[_tokenId]; //设置NF持有人和价格
        _order.seller = msg.sender;
        _order.price = _price;
        // 将NFT转账到合约
        nft.transferFrom(msg.sender, address(this), _tokenId);

        emit List(msg.sender, _tokenId, _price);
    }
    //撤单
    function revoke(uint256 _tokenId) public {
        Listing storage _order = nftlist[_tokenId]; // 取得Order        
        require(_order.seller == msg.sender, "Not Owner"); // 必须由持有人发起
        // 声明IERC721接口合约变量
       
        require(nft.ownerOf(_tokenId) == address(this), "Invalid Order"); // NFT在合约中
        
        // 将NFT转给卖家
        nft.transferFrom(address(this), msg.sender, _tokenId);
        delete nftlist[_tokenId]; // 删除order
      
        // 释放Revoke事件
        emit Revoke(msg.sender, _tokenId);
    }


}
