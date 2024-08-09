//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "./ERC20.sol";
import "./math.sol";
import "./UQ.sol";//计算浮点数
error TransferFailed();
error InsufficientLiquidityBurned();
error InsufficientLiquidityMinted();
error InsufficientOutputAmount();
error InsufficientLiquidity();
error InvalidK();
error BalanceOverflow();
error AlreadyInitialized();
contract UniswapV2Pair is ERC20,math{
    uint256 constant mini_liquidity=1000;
    address public token0;
    address public token1;
    uint256 private reserve0;//防止有人恶意操纵价格
    uint256 private reserve1;
    using UQ for uint256;

    uint private blockTimestampLast;//最新时间戳
    uint256 public price0CumulativeLast;
    uint256 public price1CumulativeLast;
    //价格合计
    event Burn(address indexed sender,uint256 amount0,uint256 amount1);
    event Mint(address indexed sender,uint256 amount0,uint256 amount1);
    event Live(uint256 balance);
    event Sync(uint256 reserve0,uint256 reserve1);
    event Swap(
        address indexed sender,
        address indexed to,
        uint256 amount0Out,
        uint256 amount1Out);
    
    uint256 private unlocked =1;
    modifier lock(){
        require(unlocked==1,"UniswapV2:LOCKED");
        unlocked =0;
        _;
        unlocked =1;
    }
    constructor(address _token0,address _token1)
            ERC20("UNI2Pair","UNI2")
    {
        token0=_token0;
        token1=_token1;
    }   

    function initialize(address _token0,address _token1)public {
        if(token0!=address(0)||token1!=address(0)){
            revert AlreadyInitialized();
        }
        token0 =_token0;
        token1 =_token1;
    }
    function mint() public {//添加流动性
        (uint256 _reserve0 ,uint256 _reserve1,) = getReserves();
        uint256 balance0 = IERC20(token0).balanceOf(address(this));
        uint256 balance1 = IERC20(token1).balanceOf(address(this));
        uint256 amount0 = balance0 -_reserve0;
        uint256 amount1 = balance1 -_reserve1;
        
        uint256 liquidity;

        if(totalSupply==0){
            liquidity = math.sqrt(amount0*amount1) - mini_liquidity;
            _mint(address(0),mini_liquidity);     
        }else{
            liquidity = math.min((totalSupply *amount0)/_reserve0,(totalSupply *amount1)/_reserve1);

        }
        if(liquidity<= 0) revert InsufficientLiquidityMinted();

        _mint(msg.sender,liquidity);
        _update(balance0,balance1,_reserve0,_reserve1);
        emit Mint(msg.sender,amount0,amount1);
    }

    function burn(address to) public returns(uint256 amount0,uint256 amount1){
        uint256 balance0 = IERC20(token0).balanceOf(address(this));
        uint256 balance1 = IERC20(token1).balanceOf(address(this));
        uint256 liquidity = balanceOf[address(msg.sender)];
        amount0 = liquidity * balance0/totalSupply; //tokenA取出的值
        amount1 = liquidity * balance1/totalSupply; //tokenB取出的值
        emit Live(liquidity);
        _burn(address(msg.sender),liquidity);
        IERC20(token0).transferFrom(address(this),to,amount0);
        IERC20(token1).transferFrom(address(this),to,amount1);

        balance0 = IERC20(token0).balanceOf(address(this));
        balance1 = IERC20(token1).balanceOf(address(this));


    }

    function swap(uint256 amount0Out,uint256 amount1Out,address to)public lock {
        if(amount0Out==0&&amount1Out==0){
            revert InsufficientOutputAmount();
        }
        (uint256 reserve0_,uint256 reserve1_, )=getReserves();
        if(amount0Out > reserve0_ || amount1Out > reserve1_){
            revert InsufficientLiquidity();
        }
        uint256 balance0 =IERC20(token0).balanceOf(address(this)) -amount0Out;
        uint256 balance1 =IERC20(token1).balanceOf(address(this)) -amount1Out;
        if(balance0 *balance1 < reserve0_ * reserve1_){
            revert InvalidK();
        }
        _update(balance0, balance1, reserve0_, reserve1_);
       
        if(amount0Out>0){
            IERC20(token0).transfer(to,amount0Out);
        }
        if(amount1Out>0){
            IERC20(token1).transfer(to,amount1Out);
        }

        emit Swap(msg.sender,to,amount0Out,amount1Out);

    }


    function getReserves()public view
        returns(uint256,uint256,uint32) 
    {
        return (reserve0,reserve1,0);
    }


    function _update(uint256 balance0,uint256 balance1,uint256 reserve0_,uint256 reserve1_)private{

        unchecked {
            uint timeElapsed = uint(block.timestamp)-blockTimestampLast;

            if(timeElapsed>0 && reserve0_>0 && reserve1_>0) {
                price0CumulativeLast +=
                    uint256(UQ.encode(reserve1_).uqdiv(reserve0_))*timeElapsed;
                price1CumulativeLast +=
                    uint256(UQ.encode(reserve0_).uqdiv(reserve1_))*timeElapsed;
            }
        }

        reserve0 = balance0;
        reserve1 = balance1;
        blockTimestampLast = uint(block.timestamp);
        emit Sync(reserve0,reserve1);

    }
   
}

