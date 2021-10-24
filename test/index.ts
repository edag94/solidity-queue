import { expect } from "chai";
import { ethers } from "hardhat";

describe("QueueConsumer", () => {

  const contractInfo = {
    name: "QueueConsumer",
    address: ""
  }

  it("should initialize properly", async () => {
    const QueueConsumer = await ethers.getContractAt("Greeter");
    const queueConsumer = await QueueConsumer.deploy();
    await queueConsumer.deployed();

    const setGreetingTx = await greeter.setGreeting("Hola, mundo!");

    // wait until the transaction is mined
    await setGreetingTx.wait();

    expect(await greeter.greet()).to.equal("Hola, mundo!");
  });
});
