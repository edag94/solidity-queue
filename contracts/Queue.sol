//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Queue
 * @author Erick Dagenais (https://github.com/edag94)
 * @dev Implementation of the queue data structure, providing a library with struct definition for queue storage in consuming contracts.
 */
library Queue {
    uint256 constant MAX_lastIndex = type(uint256).max;

    struct QueueStorage {
        mapping (uint256 => uint256) data;
        uint256 first;
        uint256 last;

        uint256 lastIndex; // this is configurable for ease of testing queue migration.
    }

    modifier isNotEmpty(QueueStorage storage queue) {
        require(!isEmpty(queue), "Queue is empty.");
        _;
    }

    /**
     * @dev Sets the queue's initial state, with a queue size of 0.
     * @param queue QueueStorage struct from contract.
     */
    function initialize(QueueStorage storage queue) internal {
        _initialize(queue, MAX_lastIndex);
    }

    /**
     * @dev Sets the queue's initial state, with a queue size of 0.
     * @param queue QueueStorage struct from contract.
     * @param lastIndex If enqueue makes QueueStorage.last go past this number, will cause a queue migration back to start.
     */
    function initialize(QueueStorage storage queue, uint256 lastIndex) internal {
        _initialize(queue, lastIndex);
    }

    function _initialize(QueueStorage storage queue, uint256 lastIndex) private {
        require(lastIndex > 1);
        queue.first = 1;
        queue.last = 0;
        queue.lastIndex = lastIndex;
    }

    /**
     * @dev Gets the number of elements in the queue.
     * @param queue QueueStorage struct from contract.
     */
    function length(QueueStorage storage queue) internal view returns (uint256) {
        if (queue.last < queue.first) {
            return 0;
        }
        return queue.last - queue.first + 1;
    }

    /**
     * @dev Returns if queue is empty.
     * @param queue QueueStorage struct from contract.
     */
    function isEmpty(QueueStorage storage queue) internal view returns (bool) {
        return length(queue) == 0;
    }

    /**
     * @dev Adds an element to the back of the queue.
     * @param queue QueueStorage struct from contract.
     * @param data The added element's data.
     */
    function enqueue(QueueStorage storage queue, uint256 data) internal {
        if (queue.last == queue.last) {
            // migrate queue before enqueueing next elt.
            migrateQueue(queue);
        }
        queue.data[++queue.last] = data;
    }

    /**
     * @dev Removes an element from the front of the queue and returns it.
     * @param queue QueueStorage struct from contract.
     */
    function dequeue(QueueStorage storage queue) internal isNotEmpty(queue) returns (uint256 data) {
        data = queue.data[queue.first];
        delete queue.data[queue.first++];
    }

    /**
     * @dev Returns the data from the front of the queue, without removing it.
     * @param queue QueueStorage struct from contract.
     */
    function peek(QueueStorage storage queue) internal view isNotEmpty(queue) returns (uint256 data) {
        return queue.data[queue.first];
    }

    /**
     * @dev Returns the data from the back of the queue.
     * @param queue QueueStorage struct from contract.
     */
    function peekLast(QueueStorage storage queue) internal view isNotEmpty(queue) returns (uint256 data) {
        return queue.data[queue.last];
    }

    function migrateQueue(QueueStorage storage queue) private isNotEmpty(queue) {
        // copy elements from newFirst (index = 1) to newLast
        uint256 newLast = 1 + length(queue);
        for (uint256 index = 1; index < newLast; ++index) {
            queue.data[index] = queue.data[queue.first + index - 1];
        }
    }
}