//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library Queue {
    struct QueueStorage {
        mapping (uint256 => bytes32) data;
        uint256 first = 1;
        uint256 last = 0;
    }

    modifier isNotEmpty {
        require(!isEmpty(queue), "Queue is empty.");
        _;
    }

    function length(QueueStorage storage queue) internal returns (uint256) {
        if (isEmpty(queue)) {
            return 0;
        }
        return last - first + 1;
    }

    function isEmpty(QueueStorage storage queue) internal returns (bool) {
        return length(queue) > 0;
    }

    function enqueue(QueueStorage storage queue, bytes32 data) internal {
        queue.data[++last] = data;
    }

    function dequeue(QueueStorage storage queue) returns (bytes32 data) internal isNotEmpty {
        data = queue.data[first];
        delete queue.data[first++];
    }

    function peek(QueueStorage storage queue) returns (bytes32 data) internal isNotEmpty {
        return queue.data[first];
    }

    function peekLast(QueueStorage storage queue) returns (bytes32 data) internal isNotEmpty {
        return queue.data[last];
    }
}