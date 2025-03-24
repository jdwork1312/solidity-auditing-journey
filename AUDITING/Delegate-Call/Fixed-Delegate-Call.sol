
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DelegateCallFixed {
    address public owner;
    mapping(address => uint256) public balances;
    
    constructor() {
        owner = msg.sender;
    }
    
    function transfer(address recipient, uint256 amount) public {
        require(msg.sender != address(this), "Cannot call through delegatecall");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        balances[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
    }
    
    fallback() external payable {
        revert("Delegate calls not allowed");
    }
    
    event Transfer(address indexed from, address indexed to, uint256 amount);
}
