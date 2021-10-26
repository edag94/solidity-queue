// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Queue.sol";

contract Bytes32QueueMock {
    using Queue for Queue.Bytes32Queue;

    Queue.Bytes32Queue private _queue;

    // to be consumed in tests since non-constant return values not accessible off-chain (refer to https://ethereum.stackexchange.com/questions/88119/i-see-no-way-to-obtain-the-return-value-of-a-non-view-function-ethers-js)
    event OperationResult(bytes32 data);

    constructor() {
        _queue.initialize();
    }

    function length() external view returns (uint256) {
        return _queue.length();
    }

    function isEmpty() external view returns (bool) {
        return _queue.isEmpty();
    }

    function enqueue(bytes32 data) external {
        _queue.enqueue(data);
    }

    function dequeue() external returns (bytes32 data) {
        data = _queue.dequeue();
        emit OperationResult(data);
    }

    function peek() external view returns (bytes32 data) {
        return _queue.peek();
    }

    function peekLast() external view returns (bytes32 data) {
        return _queue.peekLast();
    }
}

contract AddressQueueMock {
    using Queue for Queue.AddressQueue;

    Queue.AddressQueue private _queue;

    event OperationResult(address data);

    constructor() {
        _queue.initialize();
    }

    function length() external view returns (uint256) {
        return _queue.length();
    }

    function isEmpty() external view returns (bool) {
        return _queue.isEmpty();
    }

    function enqueue(address data) external {
        _queue.enqueue(data);
    }

    function dequeue() external returns (address data) {
        data = _queue.dequeue();
        emit OperationResult(data);
    }

    function peek() external view returns (address data) {
        return _queue.peek();
    }

    function peekLast() external view returns (address data) {
        return _queue.peekLast();
    }
}

contract Uint256QueueMock {
    using Queue for Queue.Uint256Queue;

    Queue.Uint256Queue private _queue;

    event OperationResult(uint256 data);

    constructor() {
        _queue.initialize();
    }

    function length() external view returns (uint256) {
        return _queue.length();
    }

    function isEmpty() external view returns (bool) {
        return _queue.isEmpty();
    }

    function enqueue(uint256 data) external {
        _queue.enqueue(data);
    }

    function dequeue() external returns (uint256 data) {
        data = _queue.dequeue();
        emit OperationResult(data);
    }

    function peek() external view returns (uint256 data) {
        return _queue.peek();
    }

    function peekLast() external view returns (uint256 data) {
        return _queue.peekLast();
    }
}