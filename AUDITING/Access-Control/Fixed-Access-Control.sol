
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VulnerableAccessControl {
    address public owner;
    mapping(address => uint256) public balances;
    mapping(address => bool) public managers;
    
    constructor() {
        owner = msg.sender;
    }

    // 1. Missing access control modifier
    function setManager(address newManager) public {
        managers[newManager] = true;
    }

    // 2. Incorrect modifier usage
    modifier onlyOwner {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    // 3. Overpowered role
    function withdrawAll(address recipient) public {
        require(managers[msg.sender], "Only managers can call this function");
        (bool success, ) = recipient.call{value: address(this).balance}("");
        require(success, "Transfer failed");
    }

    // 4. Unprotected critical function
    function transferOwnership(address newOwner) public {
        owner = newOwner;
    }

    // 5. Missing input validation
    function mintTokens(address recipient, uint256 amount) public {
        balances[recipient] += amount;
    }
}
