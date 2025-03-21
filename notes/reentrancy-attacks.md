REENTRANCY
 Always update the state (such as balances) before transferring Ether to prevent reentrancy attacks.
*   Check the conditions (e.g., require()).
*   Effect (update the state).
*   Interact (send Ether).
