// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// can alias/rename function
import {Unauthorized, helper as h1} from "./CustomError.sol";

function helper(uint x) pure returns (uint) {
}

contract Import {
}