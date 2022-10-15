// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract Structs {
    struct Car {
        string model;
        uint year;
        address owner;
    }

    Car public car;
    Car[] public cars;
    mapping(address => Car[]) public carsByOwner;

    function examples() external {
        // initialization
        // memory means this object will only exist within this function
        Car memory toyota = Car("Toyota", 1990, msg.sender);
        Car memory lambo = Car({ // order doesnt matter
            model: "Lambo",
            year: 1980,
            owner: msg.sender
        });
        // default values
        Car memory tesla;
        tesla.model = "Tesla";
        tesla.year = 2010;
        tesla.owner = msg.sender;

        cars.push(toyota);
        cars.push(lambo);
        cars.push(tesla);

        // directly push to state variable (storage)
        cars.push(Car("Ferrari", 2020, msg.sender));

        // just just access in memory
        Car memory _car = cars[0];
        _car.model;
        _car.year;
        _car.owner;

        // to update the data in storage
        Car storage _car1 = cars[0];
        _car1.year = 1999;
        delete _car1.owner;

        delete cars[1];
    }
}