// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

interface IERC20 {
    /**
     * @dev 释放条件：当 `value` 单位的货币从账户 (`from`) 转账到另一账户 (`to`)时.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev 释放条件：当 `value` 单位的货币从账户 (`owner`) 授权给另一账户 (`spender`)时.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev 返回代币总供给.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev 返回账户`account`所持有的代币数.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev 转账 `amount` 单位代币，从调用者账户到另一账户 `to`.
     *
     * 如果成功，返回 `true`.
     *
     * 释放 {Transfer} 事件.
     */
    function transfer(address to, uint256 amount) external returns (bool);

    /**
     * @dev 返回`owner`账户授权给`spender`账户的额度，默认为0。
     *
     * 当{approve} 或 {transferFrom} 被调用时，`allowance`会改变.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev 调用者账户给`spender`账户授权 `amount`数量代币。
     *
     * 如果成功，返回 `true`.
     *
     * 释放 {Approval} 事件.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev 通过授权机制，从`from`账户向`to`账户转账`amount`数量代币。转账的部分会从调用者的`allowance`中扣除。
     *
     * 如果成功，返回 `true`.
     *
     * 释放 {Transfer} 事件.
     */
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}

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