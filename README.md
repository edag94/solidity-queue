A solidity implementation of the queue data structure, providing a library with struct definition for queue storage.

Borrowed coding practices from https://github.com/vittominacori/solidity-linked-list/.
Borrowed generic library pattern to have a library for multiple types that fit into 32 bytes from https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/structs/EnumerableSet.sol

Note that in the extreme theoretical case that the `last` variable hits type(uint256).max, the queue would be rendered unusable.