//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Queue
 * @author Erick Dagenais (https://github.com/edag94)
 * @dev Implementation of the queue data structure, providing a library with struct definition for queue storage in consuming contracts.
 */
library Queue {
    struct QueueStorage {
        mapping (uint256 => bytes32) data;
        uint256 first;
        uint256 last;
    }

    modifier isNotEmpty {
        require(!isEmpty(queue), "Queue is empty.");
        _;
    }

    /**
     * @dev Sets the queue's initial state, with a queue size of 0.
     * @param queue QueueStorage struct from contract.
     */
    function initialize(QueueStorage storage queue) internal {
        queue.first = 1;
        queue.last = 0;
    }

    /**
     * @dev Gets the number of elements in the queue.
     * @param queue QueueStorage struct from contract.
     */
    function length(QueueStorage storage queue) internal returns (uint256) {
        if (isEmpty(queue)) {
            return 0;
        }
        return last - first + 1;
    }

    /**
     * @dev Returns if queue is empty.
     * @param queue QueueStorage struct from contract.
     */
    function isEmpty(QueueStorage storage queue) internal returns (bool) {
        return length(queue) > 0;
    }

    /**
     * @dev Adds an element to the back of the queue.
     * @param queue QueueStorage struct from contract.
     * @param data The added element's data.
     */
    function enqueue(QueueStorage storage queue, bytes32 data) internal {
        queue.data[++last] = data;
    }

    /**
     * @dev Removes an element from the front of the queue and returns it.
     * @param queue QueueStorage struct from contract.
     */
    function dequeue(QueueStorage storage queue) returns (bytes32 data) internal isNotEmpty {
        data = queue.data[first];
        delete queue.data[first++];
    }

    /**
     * @dev Returns the data from the front of the queue, without removing it.
     * @param queue QueueStorage struct from contract.
     */
    function peek(QueueStorage storage queue) returns (bytes32 data) internal isNotEmpty {
        return queue.data[first];
    }

    /**
     * @dev Returns the data from the back of the queue.
     * @param queue QueueStorage struct from contract.
     */
    function peekLast(QueueStorage storage queue) returns (bytes32 data) internal isNotEmpty {
        return queue.data[last];
    }
}