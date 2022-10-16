// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract TodoList {
    struct Todo {
        string text;
        bool completed;
    }

    Todo[] public todos;

    function create(string calldata _text) external {
        todos.push(Todo({
            text: _text,
            completed: false
        }));
    }

    function updateText(uint _index, string calldata _text) external {
        // if just want to access the array and update it once, use direct access as below
        // update text once - 32255
        // update text 4 times - 35174
        todos[_index].text = _text;

        // if want to update multiple times, consider using a storage variable,
        // becoz it store the storage array ONCE here and can access multiple times
        // 34614 gas
        // Todo storage todo = todos[_index];
        // todo.text = _text;
        // todo.text = _text;
        // todo.text = _text;
        // todo.text = _text;
    }

    function get(uint _index) external view returns (string memory, bool) {
        // storage - 29397; memory - 29480
        // storage doesnt copy to memory
        // memory creates another copy here
        Todo storage todo = todos[_index];
        return (todo.text, todo.completed);
    }

    function get2(uint _index) external view returns (string memory, bool) {
        // access directly TWICE - 29553 gas
        return (todos[_index].text, todos[_index].completed);
    }

    function toggleCompleted(uint _index) external {
        // 46165 - why more expensive?
        // just accessing storage 23847
        Todo storage todo = todos[_index];
        // think becoz it needs to copy the entire struct into memory before doing this reassignment
        todo.completed = !todo.completed; 

        // access storage plus only accessing completed OR !completed - 25985
        // todo.completed;
        // assigning completed to a fixed bool value - 26120
        // todo.completed = false;
    }

    function toggleCompleted2(uint _index) external {
        // 24399
        todos[_index].completed = !todos[_index].completed;
    }
}