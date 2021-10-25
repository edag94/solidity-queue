A solidity implementation of the queue data structure, providing a library with struct definition for queue storage.

Borrowed coding practices from https://github.com/vittominacori/solidity-linked-list/.

Note that in the extreme theoretical case that the `last` variable hits type(uint256).max, the queue would be rendered unusable.