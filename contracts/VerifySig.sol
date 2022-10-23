// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

/*
Process of verifying signature
0. message to sign
1. hash(message)
2. sign(hash(message), private key) to generate the signature <--- done offchain with a wallet (via console)
3. ecrecover(hash(message), signature) == signer
*/

contract VerifySig {
    function verify(address _signer, string memory _message, bytes memory _sig) 
        external pure returns (bool)
        {
            // keccak256 hash message string
            bytes32 messageHash = getMessageHash(_message);
            // --> offchain step here to generate a signature (using the messageHash + wallet owner) via wallet (console)
                // 1. make sure metamask is installed
                // 2. bring up console, type `ethereum.enable()`, allow metamask to connect to remix
                // 3. get the `account` and `hash` (messageHash output)
                // 4. ethereum.request({method: "personal_sign", params: [account, hash]})
                // 5. allow metamask to sign this message, check console, get the value, that would be the signature (_sig)
            // generate a eth_signed message hash 
            bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);

            // ecrecover the eth_signed message hash + sigature is equal to signer address
            return recover(ethSignedMessageHash, _sig) == _signer;
        }

    function getMessageHash(string memory _message) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_message));
    }

    function getEthSignedMessageHash(bytes32 _messageHash) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(
            // prefixed hash to mimic eth_sign
            "\x19Ethereum Signed Message:\n32", // 32 bytes
            _messageHash
        ));
    }

    function recover(bytes32 _ethSignedMessageHash, bytes memory _sig)
        public pure returns (address)
    {
        (bytes32 r, bytes32 s, uint8 v) = _split(_sig);
        return ecrecover(_ethSignedMessageHash, v, r, s);
    }


    // the variable _sig here is just a pointer to where the signature is stored in memory
    // r, s are cryptographic params while v is unique to EVM
    function _split(bytes memory _sig) internal pure
        returns (bytes32 r, bytes32 s, uint8 v)
        {
            //_sig is dynamic bytes array, should have 65 bytes
            //see output is broken down into 32, 32, 1 bytes
            require(_sig.length == 65, "invalid signature length");

            //dynamic data's first 32 bytes store the length of the data
            assembly {
                // skip the first 32 bytes (length of data)
                r := mload(add(_sig, 32))
                s := mload(add(_sig, 64)) // next 32 is s
                v := byte(0, mload(add(_sig, 96)))
            }
        }
}