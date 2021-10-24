import { expect } from "chai";
import { ethers, web3 } from "hardhat";
import { QueueMock } from "../typechain";

describe("QueueMock", () => {
  const contractInfo = {
    name: "QueueMock"
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
    const queueStorage = await queueMock.queue();
    const isEmpty = await queueMock.isEmpty();
    const length = await queueMock.length();

    expect(queueStorage.first).to.equal(1);
    expect(queueStorage.last).to.equal(0);
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
    let queueStorage = await queueMock.queue();
    let isEmpty = await queueMock.isEmpty();
    let length = await queueMock.length();
    let peekResult = await queueMock.peek();

    expect(queueStorage.first).to.equal(1);
    expect(queueStorage.last).to.equal(1);
    expect(isEmpty).to.equal(false);
    expect(length).to.equal(1);
    expect(peekResult).to.equal(first);
    
    console.log("add second element");
    await queueMock.enqueue(second);
    queueStorage = await queueMock.queue();
    length = await queueMock.length();
    peekResult = await queueMock.peek();
    let peekLastResult = await queueMock.peekLast();

    expect(queueStorage.first).to.equal(1);
    expect(queueStorage.last).to.equal(2);
    expect(length).to.equal(2);
    expect(peekResult).to.equal(first);
    expect(peekLastResult).to.equal(second);

    console.log("add third element");
    await queueMock.enqueue(third);
    queueStorage = await queueMock.queue();
    length = await queueMock.length();
    peekResult = await queueMock.peek();
    peekLastResult = await queueMock.peekLast();

    expect(queueStorage.first).to.equal(1);
    expect(queueStorage.last).to.equal(3);
    expect(length).to.equal(3);
    expect(peekResult).to.equal(first);
    expect(peekLastResult).to.equal(third);

    console.log("pop front element");
    await queueMock.dequeue();
    queueStorage = await queueMock.queue();
    length = await queueMock.length();
    peekResult = await queueMock.peek();
    peekLastResult = await queueMock.peekLast();

    expect(queueStorage.first).to.equal(2);
    expect(queueStorage.last).to.equal(3);
    expect(length).to.equal(2);
    expect(peekResult).to.equal(second);
    expect(peekLastResult).to.equal(third);

    console.log("add fourth element");
    await queueMock.enqueue(fourth);
    queueStorage = await queueMock.queue();
    length = await queueMock.length();
    peekResult = await queueMock.peek();
    peekLastResult = await queueMock.peekLast();

    expect(queueStorage.first).to.equal(2);
    expect(queueStorage.last).to.equal(4);
    expect(length).to.equal(3);
    expect(peekResult).to.equal(second);
    expect(peekLastResult).to.equal(fourth);

    console.log("pop front element");
    await queueMock.dequeue();
    queueStorage = await queueMock.queue();
    length = await queueMock.length();
    peekResult = await queueMock.peek();
    peekLastResult = await queueMock.peekLast();

    expect(queueStorage.first).to.equal(3);
    expect(queueStorage.last).to.equal(4);
    expect(length).to.equal(2);
    expect(peekResult).to.equal(third);
    expect(peekLastResult).to.equal(fourth);

    console.log("pop front element");
    await queueMock.dequeue();
    queueStorage = await queueMock.queue();
    length = await queueMock.length();
    peekResult = await queueMock.peek();
    peekLastResult = await queueMock.peekLast();

    expect(queueStorage.first).to.equal(4);
    expect(queueStorage.last).to.equal(4);
    expect(length).to.equal(1);
    expect(peekResult).to.equal(fourth);
    expect(peekLastResult).to.equal(fourth);

    console.log("pop final element, queue should be empty");
    await queueMock.dequeue();
    queueStorage = await queueMock.queue();
    isEmpty = await queueMock.isEmpty();
    length = await queueMock.length();
    const revertMessage = 'Queue is empty.';

    expect(queueStorage.first).to.equal(5);
    expect(queueStorage.last).to.equal(4);
    expect(length).to.equal(0);
    expect(isEmpty).to.equal(true);
    await expect(queueMock.peek()).to.revertedWith(revertMessage);
    await expect(queueMock.peekLast()).to.revertedWith(revertMessage);
  });
});
