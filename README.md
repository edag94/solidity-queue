A solidity implementation of the queue data structure, providing a library with struct definition for queue storage.

Borrowed coding practices from https://github.com/vittominacori/solidity-linked-list/.

Note that this currently has a bug. If max uint256 size is reached, there will be an integer overflow, and the queue will no longer be able to be used.
As a result, a max queue size needs to be implemented, which will allow for queue migration back to the beginning. This requires a max queue size to be implemented.
This is an unlikely edge case but still possible.

use something like this: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/structs/EnumerableSet.sol
for queues of different data types