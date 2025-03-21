[function visibility]
public: Accessible from everywhere (inside and outside the contract).
private: Only accessible within the contract (not even in derived contracts).
internal: Accessible within the contract and derived (inherited) contracts.
external: Can only be called from outside the contract (not from within it).
//////////////////////////////////////////////////////////////////////////////////////
[function call/delegate call send]
call() 
*   Runs a function in another contract
*   Medium risk can call any function, even if it doesn’t exist
*   Use when calling a known, safe contract

delegatecall()
*	Runs another contract's function inside your contract's storage
*   Very dangerous – can change your contract's variables
*   Only use with trusted contracts

send()
*	Sends Ether
*   Safe, but can fail if recipient needs more gas
*   Use when sending Ether to a normal wallet
//////////////////////////////////////////////////////////////////////////////////////
REENTRANCY
 Always update the state (such as balances) before transferring Ether to prevent reentrancy attacks.
*   Check the conditions (e.g., require()).
*   Effect (update the state).
*   Interact (send Ether).
//////////////////////////////////////////////////////////////////////////////////////
Gas Efficiency Best Practices:
*   Minimize state changes: Try to avoid unnecessary state changes.
*   Loops that go through large arrays or perform many operations increase gas.
*   Use memory instead of storage when you don't need permanent data.
*   For example, use uint8 if instead of uint256.
//////////////////////////////////////////////////////////////////////////////////////
