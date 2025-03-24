
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FrontRunFixed {
    mapping(address => uint256) public balances;
    mapping(address => bool) public hasClaimed;
    
    function claimTokens(address recipient) public {
        require(!hasClaimed[msg.sender], "Already claimed");
        require(balances[msg.sender] >= 100 ether, "Insufficient balance");
        
        // State changes first
        hasClaimed[msg.sender] = true;
        balances[msg.sender] -= 100 ether;
        balances[recipient] += 100 ether;
        
        // Emit event last
        emit Claim(msg.sender, recipient);
    }
    
    event Claim(address indexed sender, address indexed recipient);
}
