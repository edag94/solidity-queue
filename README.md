# About

A solidity implementation of the queue data structure, providing a library with struct definition for queue storage.

Borrowed coding practices from https://github.com/vittominacori/solidity-linked-list/.
Borrowed generic library pattern to have a library for multiple types that fit into 32 bytes from https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/structs/EnumerableSet.sol

# Notes

* In the extreme theoretical case that the `last` variable hits type(uint256).max, the queue would be rendered unusable.
* This data structure was originally implemented for on-chain batching. On cheaper sidechains a queue may be viable solution, but on more expensive chains,
it's advisable to figure out a more storage efficient solution. An example of a more efficient solution would be to store the lower and upper index that would signify a batch section of that array.
In that case, the storage writes are minimized to 2 indices rather than every element that needs to be added to the queue. If you do find an justifiable use case for the queue data structure on-chain, I am open to hearing it in the `Issues` section of this repo.

