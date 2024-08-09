//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./UniswapV2Pair.sol";
interface IUniswapV2Pair  {
    function initialize(address,address) external;
    function getReserves() external returns(uint256,uint256,uint256);
    function mint(address) external returns(uint256);

}
contract UniswapV2Factory{
    error IdenticalAddresses();
    error PairExists();
    error ZeroAddress();

    event PairCreated(
        address indexed token0,
        address indexed token1,
        address pair,
        uint256
    );
    mapping (address => mapping(address=>address)) public pairs;
    address[] public allpairs;
    function creatPair(address tokenA,address tokenB)public returns(address pair) {
        if(tokenA==tokenB) revert IdenticalAddresses();
        (address token0,address token1) =tokenA<tokenB
            ?(tokenA,tokenB)
            :(tokenB,tokenB);
        if(token0==address(0)) revert ZeroAddress();
        if(pairs[token0][token1]!=address(0)) revert PairExists();
        //判断币对是否符合标准
        bytes memory bytecode =type(UniswapV2Pair).creationCode;
        bytes32 salt =keccak256(abi.encodePacked(token0,token1));
        assembly{
            pair :=create2(0,add(bytecode,32),mload(bytecode),salt)
        } 

        IUniswapV2Pair(pair).initialize(token0,token1);
        pairs[token0][token1]=pair;
        pairs[token1][token0]=pair;
        allpairs.push(pair);
        emit PairCreated(token0,token1,pair,allpairs.length);
    }
}

