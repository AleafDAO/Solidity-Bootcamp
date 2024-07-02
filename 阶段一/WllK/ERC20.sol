// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

interface IERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}

contract ERC20 is IERC20 {
    mapping(address => uint256) public override balanceOf;
    mapping(address => mapping(address => uint256)) public override allowance;
    uint256 public override totalSupply = 21000000 * 10**18; // 代币总供给
    string public name = "skctoken";   // 名称
    string public symbol = "skc";  // 代号
    uint8 public decimals = 18; // 小数位数
    address public owner; // 管理员地址

    constructor() {
        owner = msg.sender;
        balanceOf[msg.sender] = totalSupply; // 将所有初始代币分配给合约创建者
        emit Transfer(address(0), msg.sender, totalSupply);
    }

    modifier onlyowner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    function transfer(address recipient, uint amount) public override returns (bool) {
         // 确保发送者有足够的余额
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint amount) public override returns (bool) {
         // 设置允许的转账额度
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint amount) public override returns (bool) {
        // 确保发送者有足够的余额
        require(balanceOf[sender] >= amount, "Insufficient balance");
         // 确保批准的额度足够
        require(allowance[sender][msg.sender] >= amount, "Allowance exceeded");
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    function mint(uint amount) external onlyowner {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    function burn(uint amount) external onlyowner {
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
}