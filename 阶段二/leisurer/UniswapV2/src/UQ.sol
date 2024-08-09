//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
library UQ{//计算浮点数
    uint256 constant Q112 =2**12;
    function encode(uint256 y) internal pure returns(uint256 z) {
        z = y*Q112;
    }
    function uqdiv(uint256 x,uint256 y) internal pure returns(uint256 z) {
        z = x/y;
    }
    
}