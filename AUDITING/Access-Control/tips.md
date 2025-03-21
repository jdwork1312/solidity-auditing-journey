
*   Unrestricted Access – Functions can be called by anyone if not properly restricted (e.g., missing onlyOwner).
*   Improper Modifier Usage – Incorrect or missing access control modifiers (onlyOwner, onlyAdmin, etc.).
*   Ownership Takeover – If transferOwnership() is callable by anyone, an attacker can take control.
*   tx.origin Exploit – Using tx.origin for authentication is dangerous since it can be spoofed.
*   Default Public Functions – Solidity functions are public by default, allowing unauthorized access if not explicitly restricted.
*   Upgradeable Contracts Risk – In proxy contracts, misconfigured access control can lead to unauthorized upgrades.
