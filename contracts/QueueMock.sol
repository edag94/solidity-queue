//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Queue.sol";

contract QueueMock {
    using Queue for Queue.QueueStorage;

    Queue.QueueStorage public queue;

    event Dequeued(uint256 data); // to be consumed in tests since non-constant return values not accessible off-chain (refer to https://ethereum.stackexchange.com/questions/88119/i-see-no-way-to-obtain-the-return-value-of-a-non-view-function-ethers-js)

    constructor() {
        queue.initialize();
    }

    /**
     * @dev Gets the number of elements in the queue.
     */
    function length() external view returns (uint256) {
        return queue.length();
    }

    /**
     * @dev Returns if queue is empty.
     */
    function isEmpty() external view returns (bool) {
        return queue.isEmpty();
    }

    /**
     * @dev Adds an element to the back of the queue.
     * @param data The added element's data.
     */
    function enqueue(uint256 data) external {
        queue.enqueue(data);
    }

    /**
     * @dev Removes an element from the front of the queue and returns it.
     */
    function dequeue() external returns (uint256 data) {
        data = queue.dequeue();
        emit Dequeued(data);
    }

    /**
     * @dev Returns the data from the front of the queue, without removing it.
     */
    function peek() external view returns (uint256 data) {
        return queue.peek();
    }

    /**
     * @dev Returns the data from the back of the queue.
     */
    function peekLast() external view returns (uint256 data) {
        return queue.peekLast();
    }
}