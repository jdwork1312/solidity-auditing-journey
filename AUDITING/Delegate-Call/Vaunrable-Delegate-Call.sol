
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DelegateCallVulnerable {
    address public owner;
    mapping(address => uint256) public balances;
    
    constructor() {
        owner = msg.sender;
    }
    
    function transfer(address recipient, uint256 amount) public {
        balances[msg.sender] -= amount;
        balances[recipient] += amount;
    }
    
    fallback() external payable {
        (bool success, ) = msg.sender.delegatecall(abi.encodeWithSelector(bytes4(keccak256("transfer(address,uint256)"))));
        require(success, "Delegate call failed");
    }
}
