//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "forge-std/Test.sol";
import "../src/UniswapV2Pair.sol";
import "../src/ERC20.sol";
contract erc20mintable is ERC20{
    constructor(string memory _name,string memory _symbol)
        ERC20(_name,_symbol){}
    function mint(uint256 _amount) public {
        _mint(msg.sender, _amount);
    }
}
contract TestUniswapV2Pair is Test{
    UniswapV2Pair pair;
    erc20mintable token0;
    erc20mintable token1;

    function setUp() public {
        token0 = new erc20mintable("tokenA","TKNA");
        token1 = new erc20mintable("tokenB","TKNB");
        pair = new UniswapV2Pair(address(token0),address(token1));

        token0.mint(10 ether);
        token1.mint(10 ether);
    }
    function testMintBootstrap() public{
        token0.transfer(address(pair),1 ether);
        token1.transfer(address(pair),1 ether);
        pair.mint();
        assertEq(pair.balanceOf(address(this)),1 ether -1000);
        assertReserves(1 ether,1 ether);
        assertEq(pair.totalSupply(),1 ether);
    }
    function testBurn() public{
        token0.transfer(address(pair),1 ether);
        token1.transfer(address(pair),1 ether);
        pair.mint();
        assertEq(pair.balanceOf(address(this)),1 ether -1000);
        pair.burn(msg.sender);
        assertEq(pair.balanceOf(address(this)),0);
    }

    function assertReserves(uint256 _reserve0,uint256 _reserve1) internal {
        (uint256 reserve0,uint256 reserve1,)=pair.getReserves();
        assertEq(_reserve0, reserve0,"reserve0 done");
        assertEq(_reserve1, reserve1,"reserve1 done");

    }

    function testMintTwiceLiquidity() public{
        token0.transfer(address(pair),1 ether);
        token1.transfer(address(pair),1 ether);
        pair.mint();

        token0.transfer(address(pair),2 ether);
        token1.transfer(address(pair),2 ether);
        pair.mint();

        assertEq(pair.balanceOf(address(this)),3 ether -1000);
        assertReserves(3 ether,3 ether);
        assertEq(pair.totalSupply(),3 ether);
    }
    function testMintErrorLiquidity() public{
        token0.transfer(address(pair),1 ether);
        token1.transfer(address(pair),1 ether);
        pair.mint();

        token0.transfer(address(pair),2 ether);
        token1.transfer(address(pair),1 ether);
        pair.mint();

        assertEq(pair.balanceOf(address(this)),2 ether -1000);
        assertReserves(3 ether,2 ether);
        assertEq(pair.totalSupply(),2 ether);
    }

    function testSwap() public{
        token0.transfer(address(pair),1 ether);
        token1.transfer(address(pair),1 ether);
        pair.mint();
        assertEq(token0.balanceOf(address(this)),9 ether);
        token1.transfer(address(pair),1 ether);
        pair.swap(0.5 ether,0,address(this));
        assertReserves(0.5 ether,2 ether);
        assertEq(token0.balanceOf(address(this)),9.5 ether);

    }
}