
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract SecureAccessControl is AccessControl, ReentrancyGuard {
    // Define roles
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant WITHDRAWER_ROLE = keccak256("WITHDRAWER_ROLE");

    mapping(address => uint256) public balances;
    uint256 public totalSupply;

    constructor() {
        // Grant default admin role to deployer
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        // Grant specific roles to deployer
        _grantRole(ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
        _grantRole(WITHDRAWER_ROLE, msg.sender);
    }

    // Role-based access control for minting
    function mint(address to, uint256 amount) public nonReentrant {
        require(hasRole(MINTER_ROLE, msg.sender), "Must have minter role");
        require(amount > 0, "Amount must be greater than 0");
        require(to != address(0), "Invalid recipient");

        balances[to] += amount;
        totalSupply += amount;
        emit Minted(msg.sender, to, amount);
    }

    // Role-based access control for withdrawal
    function withdraw(uint256 amount) public nonReentrant {
        require(hasRole(WITHDRAWER_ROLE, msg.sender), "Must have withdrawer role");
        require(amount > 0, "Amount must be greater than 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");
        emit Withdrawn(msg.sender, amount);
    }

    // Admin function to manage roles
    function grantRole(bytes32 role, address account) public {
        require(hasRole(ADMIN_ROLE, msg.sender), "Must have admin role");
        _grantRole(role, account);
    }

    // Admin function to revoke roles
    function revokeRole(bytes32 role, address account) public {
        require(hasRole(ADMIN_ROLE, msg.sender), "Must have admin role");
        _revokeRole(role, account);
    }

    // Emergency pause functionality
    bool public paused;
    event Paused(address account);
    event Unpaused(address account);

    function pause() public {
        require(hasRole(ADMIN_ROLE, msg.sender), "Must have admin role");
        paused = true;
        emit Paused(msg.sender);
    }

    function unpause() public {
        require(hasRole(ADMIN_ROLE, msg.sender), "Must have admin role");
        paused = false;
        emit Unpaused(msg.sender);
    }

    // Modifier to check if contract is not paused
    modifier whenNotPaused() {
        require(!paused, "Contract is paused");
        _;
    }

    // Add pause check to sensitive functions
    function transfer(address recipient, uint256 amount) public whenNotPaused {
        require(amount > 0, "Amount must be greater than 0");
        require(recipient != address(0), "Invalid recipient");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        balances[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
    }
}
