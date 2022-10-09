// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// Salted contract creations / create2
contract D {
    uint public x;
    constructor(uint a) {
        x = a;
    }
}

contract Create2 {
    function getBytes32(uint salt) external pure returns (bytes32) {
        // just convert a uint256 to 32 bytes as `salt`
        return bytes32(salt);
    }

    function getPredictedAddress(bytes32 salt, uint arg) external view returns (address) {
        // This complicated expression just tells you how the address
        // can be pre-computed. It is just there for illustration.
        // You actually only need ``new D{salt: salt}(arg)``.
        address predictedAddress = address(uint160(uint(keccak256(abi.encodePacked(
            bytes1(0xff),
            address(this),
            salt,
            keccak256(abi.encodePacked(
                type(D).creationCode,
                abi.encode(arg)
            ))
        )))));

        return predictedAddress;
    }    

    address public deployedAddress;

    function createDSalted(bytes32 salt, uint arg) public {
        D d = new D{salt: salt}(arg);
        //require(address(d) == predictedAddress);1

        deployedAddress = address(d);
    }
}