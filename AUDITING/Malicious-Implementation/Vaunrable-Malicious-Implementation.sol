
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IToken {
    function transfer(address recipient, uint256 amount) external;
}

contract MaliciousImplementationVulnerable {
    address public owner;
    mapping(address => uint256) public balances;
    
    constructor() {
        owner = msg.sender;
    }
    
    function setToken(address tokenAddress) public {
        // No validation of token implementation
        IToken token = IToken(tokenAddress);
        token.transfer(owner, balances[msg.sender]);
    }
}
