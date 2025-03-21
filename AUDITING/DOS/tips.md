
*   Gas Limit DoS – If a function uses too much gas (e.g., unbounded loops), it can fail execution.
*   Blocking Withdrawals – A contract that requires a recipient to accept Ether (without a fallback function) can block other withdrawals.
*   Griefing Attacks – Attackers deliberately make transactions expensive to execute (e.g., spam invalid transactions).
*   Front-Running DoS – Attackers flood the mempool with high-fee transactions to delay or block execution.
*   Unexpected Revert DoS – If a critical function depends on an external contract that can revert, it may break the system.
*   Self-Destruct DoS – If an attacker gains control and calls selfdestruct(), the contract becomes unusable.
