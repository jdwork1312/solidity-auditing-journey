
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract DOSProtected is AccessControl, ReentrancyGuard, Pausable {
    // Define roles
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant WITHDRAWER_ROLE = keccak256("WITHDRAWER_ROLE");

    // Use mapping instead of array for better gas efficiency
    mapping(address => uint256) public balances;
    mapping(address => bool) public whitelistedUsers;
    uint256 public totalSupply;

    // Rate limiting variables
    mapping(address => uint256) public lastWithdrawalTime;
    uint256 public constant WITHDRAWAL_COOLDOWN = 24 hours;
    uint256 public constant MAX_WITHDRAWAL_AMOUNT = 100 ether;

    constructor() {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(ADMIN_ROLE, msg.sender);
        _grantRole(WITHDRAWER_ROLE, msg.sender);
    }

    // Use pull-over-push pattern for withdrawals
    function withdraw(uint256 amount) public nonReentrant whenNotPaused {
        require(hasRole(WITHDRAWER_ROLE, msg.sender), "Must have withdrawer role");
        require(amount > 0, "Amount must be greater than 0");
        require(amount <= MAX_WITHDRAWAL_AMOUNT, "Amount exceeds maximum");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        
        // Check withdrawal cooldown
        require(block.timestamp >= lastWithdrawalTime[msg.sender] + WITHDRAWAL_COOLDOWN, 
            "Withdrawal cooldown not expired");
        
        balances[msg.sender] -= amount;
        lastWithdrawalTime[msg.sender] = block.timestamp;
        
        // Use pull-over-push pattern
        emit WithdrawalInitiated(msg.sender, amount);
    }

    // Allow users to claim their withdrawals
    function claimWithdrawal() public nonReentrant whenNotPaused {
        uint256 amount;
        assembly {
            amount := sload(add(balances.slot, mul(calldataoffset, 0x20)))
        }
        
        require(amount > 0, "No pending withdrawal");
        balances[msg.sender] = 0;
        
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");
        
        emit WithdrawalClaimed(msg.sender, amount);
    }

    // Admin function to add/remove whitelisted users
    function whitelistUser(address user, bool allowed) public {
        require(hasRole(ADMIN_ROLE, msg.sender), "Must have admin role");
        whitelistedUsers[user] = allowed;
        emit UserWhitelisted(user, allowed);
    }

    // Emergency pause functionality
    function pause() public {
        require(hasRole(ADMIN_ROLE, msg.sender), "Must have admin role");
        _pause();
    }

    function unpause() public {
        require(hasRole(ADMIN_ROLE, msg.sender), "Must have admin role");
        _unpause();
    }

    // Modifier to check if contract is not paused
    modifier whenNotPaused() {
        require(!paused(), "Contract is paused");
        _;
    }

    // Emergency withdrawal for stuck funds
    function emergencyWithdraw() public nonReentrant whenNotPaused {
        require(hasRole(ADMIN_ROLE, msg.sender), "Must have admin role");
        uint256 amount = balances[msg.sender];
        balances[msg.sender] = 0;
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");
        emit EmergencyWithdrawal(msg.sender, amount);
    }
}
