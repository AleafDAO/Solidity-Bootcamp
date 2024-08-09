//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
interface IERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);
    //转账事件，代表有value值的token从from转到了to里面
    event Approval(address indexed owner, address indexed spender, uint256 value);
    //授权事件，代表有owner授权给spender使用value值的token

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);//通过授权机制，从`from`账户向`to`账户转账`amount`数量代币。转账的部分会从调用者的`allowance`中扣除。
    function approve(address spender, uint256 amount) external returns (bool);//授权函数
    function totalSupply() external view returns (uint256);//查看代币的总供给
    function balanceOf(address account) external view returns (uint256);//返回账户account所持有的代币数.
    function transfer(address to, uint256 amount) external returns (bool);//调用者转账amount值的代币到to账户
    function allowance(address owner, address spender) external view returns (uint256);//返回owner账户授权给spender账户的额度
}

contract ERC20 is IERC20{
    mapping(address => uint256) public override balanceOf;
    mapping(address => mapping(address => uint256)) public override allowance;
    uint256 public override totalSupply;   // 代币总供给
    string public name;   // 名称
    string public symbol;  // 符号
    uint8 public decimals = 18; // 小数位数
    address public owner;
    constructor(){
        name = "Mytoken";
        symbol = "MTK";
        owner = msg.sender;
        balanceOf[msg.sender]=21000000 * 10 ** uint256(decimals);
         totalSupply +=21000000 * 10 ** uint256(decimals);
    }
    
    
    function transfer(address recipient, uint amount) external override returns (bool) {
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }
    function approve(address spender, uint amount) external override returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
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

    function mint(uint amount) external onlyOwner{
        balanceOf[msg.sender] +=amount;
        totalSupply +=amount;
        emit Transfer(address(0), msg.sender, amount);
    }
    modifier onlyOwner {
        require(msg.sender == owner,"You can't burn the token."); 
        _; 
   }
    function burn(uint amount) external onlyOwner{
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
    
}