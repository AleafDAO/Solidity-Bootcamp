// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "./IERC20.sol";

contract ERC20 is IERC20{
    mapping(address => uint256) public override balanceof;
    mapping(address => mapping(address => uint256)) public override allowance;
    uint256 public override  totaltoken;
    string public name;
    string public symbol;
    uint8  public decimals=18;

    constructor(string memory name_,string memory symbol_){
        name = name_;
        symbol = symbol_;
    }
    
    function transfer(address spender,uint256 value) public override returns(bool){
        require(balanceof[msg.sender]>=value, "insufficient balance");
        balanceof[msg.sender]-=value;
        balanceof[spender]+=value;
        emit Transfer(msg.sender,spender,value);
        return true;
    } 
    function approve(address spender,uint value) public  override  returns(bool){
        allowance[msg.sender][spender]=value;
        emit approval(msg.sender,spender,value);
        return true;
    }
    function transfrom(address sender, address spender,uint value) public override returns (bool){
        require(allowance[sender][msg.sender]>=value,"insufficient balance");
        require(balanceof[sender]>=value,"insufficient balance");
        allowance[sender][msg.sender]-=value;
        balanceof[sender]-=value;
        balanceof[spender]+=value;
        emit Transfer(sender,spender, value);
        return true;
    }
    function mint(uint value) external {
        balanceof[msg.sender]+=value;
        totaltoken+=value;
        emit Transfer(address(0),msg.sender,value);
    }
    function burn(uint value) external {
        require(balanceof[msg.sender]>=value,"insuffcient balance");
        balanceof[msg.sender]-=value;
        totaltoken-=value;
        emit Transfer(msg.sender, address(0), value);
    }
}
    

