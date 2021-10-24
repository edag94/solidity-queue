//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Queue.sol";

contract QueueConsumer {
    using Queue for QueueStorage;

    QueueStorage public queue;
}