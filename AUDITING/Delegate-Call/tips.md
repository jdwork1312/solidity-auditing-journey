*   Modifies the Caller’s Storage – delegatecall runs code from another contract but writes data into the calling contract’s storage.
*   Storage Layout Mismatch – If the storage layout of the calling and target contract don’t match, critical variables (e.g., owner) can be overwritten.
*   Malicious Implementation – If the target contract is untrusted, it can execute harmful logic inside your contract.
*   EIP-1967 Proxy Risks – Many upgradeable contracts use delegatecall, and an attacker can hijack the proxy’s logic if misconfigured.
*   Lack of Access Control – If delegatecall is used in a function that anyone can call, an attacker may execute arbitrary code.

Fixes:
✅ Use trusted contracts only – Never delegatecall to an unknown contract.
✅ Ensure storage layout matches in upgradeable contracts.
✅ Restrict access – Use onlyOwner or access control on functions that use delegatecall.
