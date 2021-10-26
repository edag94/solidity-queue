import { BigNumber } from "@ethersproject/bignumber";
import { expect } from "chai";
import { ethers } from "hardhat";
import { QueueMock } from "../typechain";

const Uint256QueueMock = "Uint256QueueMock"

describe(Uint256QueueMock, () => {
  const contractInfo = {
    name: Uint256QueueMock
  };

  const setup = async (): Promise<QueueMock> => {
    const QueueMock = await ethers.getContractFactory(
      contractInfo.name,
    );
    const queueMock = (await QueueMock.deploy()) as unknown as QueueMock;
    await queueMock.deployed();
    return queueMock;
  }

  it("should initialize properly", async () => {
    const queueMock = await setup();
    const isEmpty = await queueMock.isEmpty();
    const length = await queueMock.length();

    expect(isEmpty).to.equal(true);
    expect(length).to.equal(0);
  });

  it("FIFO works correctly", async () => {
    const queueMock = await setup();

    const first = 1;
    const second = 2;
    const third = 3;
    const fourth = 4;
    
    console.log("add first element");
    await queueMock.enqueue(first);
    let isEmpty = await queueMock.isEmpty();
    let length = await queueMock.length();
    let peekResult = await queueMock.peek();

    expect(isEmpty).to.equal(false);
    expect(length).to.equal(1);
    expect(peekResult).to.equal(first);
    
    console.log("add second element");
    await queueMock.enqueue(second);
    length = await queueMock.length();
    peekResult = await queueMock.peek();
    let peekLastResult = await queueMock.peekLast();

    expect(length).to.equal(2);
    expect(peekResult).to.equal(first);
    expect(peekLastResult).to.equal(second);

    console.log("add third element");
    await queueMock.enqueue(third);
    length = await queueMock.length();
    peekResult = await queueMock.peek();
    peekLastResult = await queueMock.peekLast();

    expect(length).to.equal(3);
    expect(peekResult).to.equal(first);
    expect(peekLastResult).to.equal(third);

    console.log("pop front element");
    let dequeueTx = await queueMock.dequeue();
    let receipt = await dequeueTx.wait();
    let front = receipt.events![0].args!.data as BigNumber;
    length = await queueMock.length();
    peekResult = await queueMock.peek();
    peekLastResult = await queueMock.peekLast();

    expect(front).to.equal(first);
    expect(length).to.equal(2);
    expect(peekResult).to.equal(second);
    expect(peekLastResult).to.equal(third);

    console.log("add fourth element");
    await queueMock.enqueue(fourth);
    length = await queueMock.length();
    peekResult = await queueMock.peek();
    peekLastResult = await queueMock.peekLast();

    expect(length).to.equal(3);
    expect(peekResult).to.equal(second);
    expect(peekLastResult).to.equal(fourth);

    console.log("pop front element");
    dequeueTx = await queueMock.dequeue();
    receipt = await dequeueTx.wait();
    front = receipt.events![0].args!.data as BigNumber;
    length = await queueMock.length();
    peekResult = await queueMock.peek();
    peekLastResult = await queueMock.peekLast();

    expect(front).to.equal(second);
    expect(length).to.equal(2);
    expect(peekResult).to.equal(third);
    expect(peekLastResult).to.equal(fourth);

    console.log("pop front element");
    dequeueTx = await queueMock.dequeue();
    receipt = await dequeueTx.wait();
    front = receipt.events![0].args!.data as BigNumber;
    length = await queueMock.length();
    peekResult = await queueMock.peek();
    peekLastResult = await queueMock.peekLast();

    expect(front).to.equal(third);
    expect(length).to.equal(1);
    expect(peekResult).to.equal(fourth);
    expect(peekLastResult).to.equal(fourth);

    console.log("pop final element, queue should be empty");
    dequeueTx = await queueMock.dequeue();
    receipt = await dequeueTx.wait();
    front = receipt.events![0].args!.data as BigNumber;
    isEmpty = await queueMock.isEmpty();
    length = await queueMock.length();
    const revertMessage = 'Queue is empty.';

    expect(front).to.equal(fourth);
    expect(length).to.equal(0);
    expect(isEmpty).to.equal(true);
    await expect(queueMock.peek()).to.revertedWith(revertMessage);
    await expect(queueMock.peekLast()).to.revertedWith(revertMessage);
  });
});
