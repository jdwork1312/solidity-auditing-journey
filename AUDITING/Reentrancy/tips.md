

*   Unprotected External Calls – If a contract sends ETH before updating state, an attacker can re-enter the function.
*   Recursive Calls – The attacker’s contract calls back into the vulnerable contract before the first execution is completed.
*   Draining Funds – The attacker loops withdrawals, draining the contract’s balance.
*   Multiple Function Reentrancy – Attackers can exploit different functions that interact with the same vulnerable state.
*   Cross-Contract Reentrancy – A malicious contract exploits another contract’s weak logic by calling back into it.
*   DAO Hack Example – The famous 2016 DAO Hack used this exploit to drain ETH.

✅ Checks-Effects-Interactions pattern: Update state before making external calls.
✅ Reentrancy Guard (ReentrancyGuard from OpenZeppelin).
✅ Pull-over-Push: Let users manually withdraw funds instead of sending them automatically.
