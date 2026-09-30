// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// Custom ERC-20 token for the Session 05 assignment.
// Owner gets the full supply at deploy time, owner can mint more later,
// and anyone can burn tokens they hold.
contract SWKToken is ERC20, ERC20Burnable, Ownable {

    event TokensMinted(address indexed to, uint256 amount);

    constructor(uint256 initialSupply)
        ERC20("Sathwik Token", "SWK")
        Ownable(msg.sender)
    {
        _mint(msg.sender, initialSupply * 10 ** decimals());
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount * 10 ** decimals());
        emit TokensMinted(to, amount);
    }
}
