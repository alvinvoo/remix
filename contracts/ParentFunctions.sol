// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

/*
Calling parent functions
- direct
- super (calls all parent contracts for multi-inheritance)

    E
   / \
  F   G
   \ /
    H
*/

contract E {
    event Log(string message);

    function foo() public virtual {
        emit Log("E.foo");
    }

    function bar() public virtual {
        emit Log("E.bar");
    }
}

contract F is E {
    function foo() public virtual override {
        emit Log("F.foo");
        E.foo();
    }

    function bar() public virtual override{
        emit Log("F.bar");
        super.bar();
    }
}

contract G is E{
    function foo() public virtual override {
        emit Log("G.foo");
        E.foo();
    }

    function bar() public virtual override {
        emit Log("G.bar");
        super.bar();
    }
}

contract H is F, G {
    function foo() public override(F, G) {
        emit Log("H.foo");
        F.foo();
    }

    function bar() public override(F, G) {
        emit Log("H.bar");
        super.bar();
        // expected H.bar, F.bar, G.bar and TWO E.bar.. (but actually only ONE E.bar is called)
        // actual H.bar, G.bar, F.bar and E.bar (notice also G and F position can interchange)
    }
}