// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract Enum {
    enum Status { // internally its uint8
        None,
        Pending,
        Shipped,
        Completed,
        Rejected,
        Cancelled
    }

    // usages:
    Status public status;

    struct Order {
        address buyer;
        Status status;
    }

    Order[] public orders;

    function get() view external returns (Status) {
        return status;
    }

    function set(Status _status) external {
        status = _status;
    } 

    function ship() external {
        status = Status.Shipped;
    }

    function reset() external {
        delete status; // reset status to first item, which is None
    }
}