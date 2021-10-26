// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../Queue.sol";

contract UniqueBytes32QueueMock {
    using Queue for Queue.UniqueBytes32Queue;

    Queue.UniqueBytes32Queue private _queue;

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

    function exists(bytes32 data) external view returns (bool) {
        return _queue.exists(data);
    }
}

contract UniqueAddressQueueMock {
    using Queue for Queue.UniqueAddressQueue;

    Queue.UniqueAddressQueue private _queue;

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

    function exists(address data) external view returns (bool) {
        return _queue.exists(data);
    }
}

contract UniqueUint256QueueMock {
    using Queue for Queue.UniqueUint256Queue;

    Queue.UniqueUint256Queue private _queue;

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

    function exists(uint256 data) external view returns (bool) {
        return _queue.exists(data);
    }
}
