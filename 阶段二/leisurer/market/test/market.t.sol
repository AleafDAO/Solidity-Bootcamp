// SPDX-License-Identifier:MIT
pragma solidity ^0.8.4;
import "forge-std/Test.sol";
import "../src/market.sol";
import "../src/ERC20.sol";
import "../src/ERC721.sol";

contract marketTest is Test {
    NFTMarket public market;
    MyNFT public NFT;
    ERC20 public token;
    function setUp() public{
        NFT = new MyNFT("NNN","3N");
        token = new ERC20();
        market = new NFTMarket(address(token),address(NFT));
        
    }
    function testlist(uint256 x) public{
        vm.assume(x>0);
        NFT.mint("ipfs://QmcAB5tf6ZyfgRbbopX9P94LJnEdLnj6hQX1K5ZHhLNSmd");
        NFT.approve(address(market), 0 );
        market.list(0,x);
        assertEq(NFT.getApproved(0), address(market));
    }
    function testbuyNFT(uint256 x) public{
        vm.assume(x>0&&x<2.1e22);
        NFT.mint("ipfs://QmcAB5tf6ZyfgRbbopX9P94LJnEdLnj6hQX1K5ZHhLNSmd");
        NFT.approve(address(market), 0 );
        market.list(0,x);
        token.transfer(address(market),x);
        token.approve(address(market),x);
        market.buynft(0);
        
    }
}