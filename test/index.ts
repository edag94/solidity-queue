import { expect } from "chai";
import { ethers } from "hardhat";
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

    expect(queueStorage.first).to.equal(1);
    expect(queueStorage.last).to.equal(0);
  });
});
