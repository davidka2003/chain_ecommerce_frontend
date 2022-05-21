import { expect } from "chai";
import { ethers } from "hardhat";
const address = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";
describe("Greeter", function () {
  it("Should return the new greeting once it's changed", async function () {
    const Contract = await ethers.getContractFactory("Chain_ecommerce");
    const contract = await Contract.deploy();
    await contract.deployed();
    await contract.addShop("myShop", "metaUri", address);
    // await
  });
});
