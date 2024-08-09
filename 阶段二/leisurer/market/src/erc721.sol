// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
contract MyNFT{
    string public symbol;
    string public name;
    uint256 public tokenid;

    //tokenId 到 owner address 的持有人映射
    mapping(uint => address) private _owners;
    //address 到 持仓数量 的持仓量映射
    mapping(address => uint) private _balances;
    //tokenID 到 授权地址 的授权映射
    mapping(uint => address) private _tokenApprovals;
    //owner地址。到operator地址 的批量授权映射
    mapping(address => mapping(address => bool)) private _operatorApprovals;
    //_tokenURIs
    mapping(uint256 => string) private _tokenURIs;

    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    constructor(string memory name_1, string memory symbol_1) {
        name = name_1;
        symbol = symbol_1;
        tokenid = 0;
    }
 
    function balanceOf(address owner) external view  returns (uint) 
    {
        require(owner != address(0), "owner = zero address");
        return _balances[owner];
    }
    function ownerOf(uint tokenId) public view  returns (address owner) 
    {
        owner = _owners[tokenId];
        require(owner != address(0), "token doesn't exist");
    }

    function isApprovedForAll(address owner, address operator)external view  returns (bool)//判断是否授权
    {
        return _operatorApprovals[owner][operator];
    }
    
    function getApproved(uint tokenId) external view  returns (address) //利用_tokenApprovals变量查询tokenId的授权地址。
    {
        require(_owners[tokenId] != address(0), "token doesn't exist");
        return _tokenApprovals[tokenId];
    }
    function approve(address to, uint tokenId) external //approve授权函数调用
    {
        address owner = _owners[tokenId];
        require(msg.sender == owner || _operatorApprovals[owner][msg.sender],"not owner nor approved for all");
        _approve(owner, to, tokenId);
    }
    function _approve(
        address owner,
        address to,
        uint tokenId
    ) private 
    {
        _tokenApprovals[tokenId] = to;
        emit Approval(owner, to, tokenId);
    }

    // 查询 spender地址是否可以使用tokenId（需要是owner或被授权地址）
    function _isApprovedOrOwner(
        address owner,
        address spender,
        uint tokenId
    ) private view returns (bool) {
        return (spender == owner ||
            _tokenApprovals[tokenId] == spender ||
            _operatorApprovals[owner][spender]);
    }

    function transferFrom(
        address from,
        address to,
        uint tokenId
    ) external {
        address owner = ownerOf(tokenId);
        require(
            _isApprovedOrOwner(owner, msg.sender, tokenId),
            "not owner nor approved"
        );
        _transfer(owner, from, to, tokenId);
    }

    function _transfer(
        address owner,
        address from,
        address to,
        uint tokenId
    ) private 
    {
        require(from == owner, "not owner");
        require(to != address(0), "transfer to the zero address");

        _approve(owner, address(0), tokenId);
        _balances[from] -= 1;
        _balances[to] += 1;
        _owners[tokenId] = to;

        emit Transfer(from, to, tokenId);
    }


    //铸造函数。
    function mint(string memory baseURI) public returns (uint256) {
        uint256 id =tokenid;

        _owners[id] = msg.sender;
        _balances[msg.sender] += 1;
        _tokenURIs[id] = baseURI;

        tokenid += 1;

        emit Transfer(address(0), msg.sender, id);
        return id;
    }

    function tokenURI(uint256 tokenId) public view returns (string memory) {
        require(_owners[tokenId] != address(0), "Token doesn't exist");
        return _tokenURIs[tokenId];
    }
}

