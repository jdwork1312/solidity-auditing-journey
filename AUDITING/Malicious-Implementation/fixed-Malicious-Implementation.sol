
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract MaliciousImplementationFixed is ReentrancyGuard {
    address public owner;
    mapping(address => uint256) public balances;
    
    constructor() {
        owner = msg.sender;
    }
    
    function setToken(address tokenAddress) public nonReentrant {
        // Validate token implementation
        IERC20 token = IERC20(tokenAddress);
        require(token.totalSupply() > 0, "Invalid token");
        require(token.decimals() == 18, "Invalid decimals");
        
        uint256 balance = token.balanceOf(msg.sender);
        require(balance >= balances[msg.sender], "Insufficient token balance");
        
        balances[msg.sender] = 0;
        emit TokenSet(msg.sender, tokenAddress);
    }
    
    event TokenSet(address indexed user, address indexed token);
}
