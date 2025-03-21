*   Transaction Visibility – Pending transactions are public before being confirmed, allowing attackers to see and exploit them.
*   MEV (Maximal Extractable Value) – Bots or miners reorder transactions to profit from arbitrage or priority execution.
*   Unprotected Function Calls – If a function allows price changes or token swaps without protection, attackers can front-run trades.
*   Priority Gas Auction (PGA) Attacks – Attackers bid higher gas fees to get their transaction executed first.
*   Lack of Commit-Reveal Scheme – If bids or actions are publicly submitted, attackers can copy and submit first.
*   Slippage Exploits – Attackers manipulate price slippage in DEX trades, forcing users to accept worse rates.

Fix: Use commit-reveal schemes, private transactions, max gas limits, and fair sequencing mechanisms to prevent front-running.
