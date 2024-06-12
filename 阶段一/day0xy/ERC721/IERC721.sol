// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IERC165.sol";

//接口继承IERC65
interface IERC721 is IERC165 {
    event Transfer(address indexed from,address indexed to, uint256 indexed  TokenId);
    //在授权时释放          owner 授权地址， approved 被授权地址
    event Approval(address indexed owner,address indexed approved,uint256 indexed TokenId);
    //批量授权时释放，记录批量授权的发出地址owner和被授权地址operator
    event ApprovalForAll(address indexed owner,address indexed operator,bool approved);

    function balanceOf(address onwer) external view returns (uint256 balance);

    function ownerOf(uint256 tokenId) external view returns (address owner);

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes calldata data
    )external;

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;

    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;

    //授权另一个地址使用你的NFT
    function approve(address to, uint256 tokenId) external ;
    //将自己持有的该系列NFT批量授权给某个地址
    function setApprovalForAll (address operator,bool _approved) external ;
    //查询tokenId被授权给了哪个地址
    function getApproved(uint256 tokenId) external view returns (address operator);
    
    function isApprovedForAll(address owner,address operator) external view returns (bool);


}