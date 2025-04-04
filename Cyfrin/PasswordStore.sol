
// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;                                                     // is this the correct compilier version to use?

/*
 * @author not-so-secure-dev
 * @title PasswordStore
 * @notice This contract allows you to store a private password that others won't be able to see. 
 * You can update your password at any time.
 */
contract PasswordStore {
    error PasswordStore__NotOwner();

    address private s_owner;
    string private s_password;                                              //private data on chain is not private it is not private not a safe palce to secure password
                                                                            // all data on chain is public information
    event SetNetPassword();

    constructor() {
        s_owner = msg.sender;
    }

    /*
     * @notice This function allows only the owner to set a new password.
     * @param newPassword The new password to set.
     */
    function setPassword(string memory newPassword) external {                          // only owner modifier
    //MISSING: if(msg.sender !=s_owner( {
        //revert revert NotOwner();}
        s_password = newPassword;
        emit SetNetPassword();
    }

    /*
     * @notice This allows only the owner to retrieve the password.
     * @param newPassword The new password to set. [PARAMETER NOT SET]      // function getPassword(_newpassword)
     */
    function getPassword() external view returns (string memory) {                  
        if (msg.sender != s_owner) {
            revert PasswordStore__NotOwner();
        }
        return s_password;
    }
}
