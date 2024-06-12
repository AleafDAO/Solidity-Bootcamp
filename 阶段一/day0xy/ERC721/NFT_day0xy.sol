// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "./ERC721.sol";

contract NFT_day0xy is ERC721{
    uint public MAX_APES = 10000; // 总量

    // 构造函数
    constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_){
    }


    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://QmeDgFHk7CSFo8cLJobzywNzCbSv7xEqj97ujTWubeXeiQ/";
    }
    
    // 铸造函数
    function mint(address to, uint tokenId) external {
        require(tokenId >= 0 && tokenId < MAX_APES, "tokenId out of range");
        _mint(to, tokenId);
    }
}