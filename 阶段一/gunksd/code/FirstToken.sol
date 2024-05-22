// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract FirstToken is ERC20 , Ownable {
        constructor() ERC20("FirstToken" , "FTK") Ownable(msg.sender){
                _mint(msg.sender , 21000000 * (10 ** uint256(decimals())));
        }
        function burn(uint256 amount) public onlyOwner {
                _burn(msg.sender, amount);
        }
}

