




// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract DoS {
    address[] entrants;         //array of all entrants in the contest, one address per entry

    function enter() public {                                           
        // loop Check for duplicate entrants                         // more gas
        for (uint256 i; i < entrants.length; i++) {                 // for 1 persoon goes trough the loop once for 10 ten times etc.
         if (entrants[i] == msg.sender) {                           // every next person that joins pays more gas because of the loop
                revert("You've already entered!");
            }
        }
        entrants.push(msg.sender);
    }
}
