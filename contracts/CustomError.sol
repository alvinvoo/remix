// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// custom error 
//  - extract outside the contract so can be imported and used in other contracts
// this reduce gas fee required - much cheaper than sending a string
error Unauthorized(address caller);

contract VendingMachine {
    address payable owner = payable(msg.sender);

    function withdraw() public {
        if (msg.sender != owner)
            // 207402 gas
            // revert("error");
            // cheaper - 200081 gas
            revert Unauthorized(msg.sender);
        
        owner.transfer(address(this).balance);
    }
}