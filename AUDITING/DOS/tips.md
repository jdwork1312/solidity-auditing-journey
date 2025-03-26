
*   Gas Limit DoS – If a function uses too much gas (e.g., unbounded loops), it can fail execution.
*   Blocking Withdrawals – A contract that requires a recipient to accept Ether (without a fallback function) can block other withdrawals.
*   Griefing Attacks – Attackers deliberately make transactions expensive to execute (e.g., spam invalid transactions).
*   Front-Running DoS – Attackers flood the mempool with high-fee transactions to delay or block execution.
*   Unexpected Revert DoS – If a critical function depends on an external contract that can revert, it may break the system.
*   Self-Destruct DoS – If an attacker gains control and calls selfdestruct(), the contract becomes unusable.

Fix: Always limit loops, handle external calls safely, and use fail-safe mechanisms to prevent execution failures. 


Unbouded for loop
*   is the loop bounded to a certain size? 
*   Can a user just add arbitary amout of items ?
*   How much does it cost for user to to that ?
  

An external call failing
*   transfering ether
*   making a call to a thirdparty contract
*   Is there a way for this calls to fail
*   If they di fail do they cause the transaction to revert entirely?
*   How can that affect the system

WAYS FOR EXTERNAL CALL TO FAIL
*   CONTRACT DOES NOT ACCEPT ETHER NO (FALLBACK OR RECIEVE FNCTN)
*   CALLING A FNCTN THAT DOESNT EXCIST ON THE CONTRACT YOUR CALLING
*   IF 
