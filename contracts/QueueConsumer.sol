//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Queue.sol";

contract QueueConsumer {
    using Queue for Queue.QueueStorage;

    QueueStorage public queue;

    constructor() {
        queue.initialize();
    }
}