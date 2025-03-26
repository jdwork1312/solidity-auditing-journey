

*   Unprotected External Calls – If a contract sends ETH before updating state, an attacker can re-enter the function. ✅
*   Recursive Calls – The attacker’s contract calls back into the vulnerable contract before the first execution is completed. ✅
*   Draining Funds – The attacker loops withdrawals, draining the contract’s balance.
*   Multiple Function Reentrancy – Attackers can exploit different functions that interact with the same vulnerable state.
*   Cross-Contract Reentrancy – A malicious contract exploits another contract’s weak logic by calling back into it.
*   DAO Hack Example – The famous 2016 DAO Hack used this exploit to drain ETH.

✅ Checks-Effects-Interactions pattern: Update state before making external calls.
✅ Reentrancy Guard (ReentrancyGuard from OpenZeppelin).
✅ Pull-over-Push: Let users manually withdraw funds instead of sending them automatically.

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Using call() to Send Ether to Contracts with Unknown Behavior

call() is flexible and allows you to send Ether and data to other contracts. However, it can be risky because:

*   It does not limit gas (unlike transfer() or send()).
*   The recipient contract can execute arbitrary code.
*   It can potentially call back into your contract, leading to a reentrancy attack if not handled carefully.

When to use call():
*   Interacting with other contracts that require more gas or custom behavior.
*   Sending data or calling specific functions in the recipient contract.

When not to use call():
1. When Sending Ether to an Externally Owned Account (EOA)
*   Use transfer() or send() instead. These are safer for transferring Ether to EOA because they restrict gas and prevent reentrancy attacks.

2. When You Don’t Need to Call Functions on Another Contract
*   call() is for calling functions in other contracts. If you only need to transfer Ether, transfer() or send() are safer.

3. When You Are Interacting with Untrusted Contracts
*   If the recipient contract is untrusted or external, call() opens the risk of reentrancy attacks or unexpected behavior. Use transfer() to limit potential issues.

- Avoid call() when sending Ether to simple addresses (use transfer() or send()).

- Avoid call() if you are unsure of the recipient contract’s behavior.

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
