//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Queue.sol";

contract QueueMock {
    using Queue for Queue.QueueStorage;

    Queue.QueueStorage public queue;

    constructor() {
        queue.initialize();
    }

    /**
     * @dev Gets the number of elements in the queue.
     */
    function length() public view returns (uint256) {
        return queue.length();
    }

    /**
     * @dev Returns if queue is empty.
     */
    function isEmpty() public view returns (bool) {
        return queue.isEmpty();
    }

    /**
     * @dev Adds an element to the back of the queue.
     * @param data The added element's data.
     */
    function enqueue(bytes32 data) public {
        queue.enqueue(data);
    }

    /**
     * @dev Removes an element from the front of the queue and returns it.
     */
    function dequeue() public returns (bytes32 data) {
        return queue.dequeue();
    }

    /**
     * @dev Returns the data from the front of the queue, without removing it.
     */
    function peek() public view returns (bytes32 data) {
        return queue.peek();
    }

    /**
     * @dev Returns the data from the back of the queue.
     */
    function peekLast() public view returns (bytes32 data) {
        return queue.peekLast();
    }
}