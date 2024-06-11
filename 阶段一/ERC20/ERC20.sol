// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import './IERC20.sol';


contract ERC20 is IERC20{
    mapping(address => uint256) public override balanceOf;
    mapping (address => mapping (address => uint256)) public  override  allowance;
    
    uint256 public override totalSupply;

    string public name;
    string public symbol;

    uint8 public decimals=18;

    //定义部署合约者
    address public owner;
    
    constructor(string memory name_,string memory symbol_){
        name=name_;
        symbol = symbol_;
        owner = msg.sender;
    }

    function transfer(address recipient,uint amount) public override returns (bool){
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");
        balanceOf[msg.sender] -=amount;
        balanceOf[recipient] +=amount;
        emit Transfer(msg.sender, recipient,amount);
        return true;
    }

    function approve(address spender,uint amount) public override returns (bool){
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender,spender,amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) public  override returns (bool){
        require(balanceOf[sender] >= amount, "Insufficient balance");
        require(allowance[sender][msg.sender] >= amount, "Allowance exceeded");

        allowance[sender][msg.sender] -=amount;
        balanceOf[sender] +=amount;
        balanceOf[recipient] +=amount;
        emit Transfer(sender,recipient,amount);
        return true;
    }

    function mint(uint amount) external {
        balanceOf[msg.sender] +=amount;
        totalSupply +=amount;
        emit Transfer(address(0), msg.sender, amount);
    }

   // 定义modifier
   modifier onlyOwner {
      require(msg.sender == owner,"Caller is not the owner"); // 检查调用者是否为owner地址
      _; // 如果是的话，继续运行函数主体；否则报错并revert交易
   }


    function burn(uint amount) external onlyOwner{
        require(balanceOf[msg.sender] >= amount, "Insufficient balance to burn");
        balanceOf[msg.sender] -=amount;
        totalSupply -=amount;
        emit Transfer(msg.sender, address(0), amount);
    }
}