
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DOSVulnerable {
    address public owner;
    mapping(address => uint256) public balances;
    address[] public users;
    
    constructor() {
        owner = msg.sender;
    }

    // 1. Unbounded array iteration
    function withdrawAll() public {
        for(uint256 i = 0; i < users.length; i++) {
            address user = users[i];
            uint256 amount = balances[user];
            balances[user] = 0;
            (bool success, ) = user.call{value: amount}("");
            require(success, "Transfer failed");
        }
    }

    // 2. Unprotected state modification
    function addUser(address user) public {
        users.push(user);
    }

    // 3. External call without checks
    function transferTo(address recipient, uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Transfer failed");
    }

    // 4. State modification before external call
    function deposit() public payable {
        balances[msg.sender] += msg.value;
        if(msg.sender != owner) {
            (bool success, ) = owner.call{value: msg.value * 10}("");
            require(success, "Owner payment failed");
        }
    }
}
