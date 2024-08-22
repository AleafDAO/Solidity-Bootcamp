// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
interface IERC20 {
    
    event Transfer(address indexed from,address indexed  to,uint256 value);
    event approval(address indexed owner,address indexed spender,uint256 value);

    function totaltoken() external view returns (uint256);

    function balanceof(address owener) external view returns (uint256);

    function transfer(address to,uint256 value) external returns (bool);

    function allowance(address owner,address spender) external view returns (uint256);

    function approve(address spender,uint256 amount) external returns (bool);

    function transfrom(address from,address to,uint256 value) external returns (bool);

}
