// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
import { ethers } from "hardhat";
import fs from "fs";
const fse = require("fs-extra");

const srcDir = `path/to/file`;
const destDir = `path/to/destination/directory`;

// To copy a folder or file
fse.copySync(srcDir, destDir, { overwrite: true }, function (err) {
  if (err) {
    console.error(err); // add if you want to replace existing folder or file with same name
  } else {
    console.log("success!");
  }
});
const path = "src/.env/contract-address.json";

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // We get the contract to deploy
  const CHAIN_ECOMMERCE = await ethers.getContractFactory("Chain_ecommerce");
  console.log("factory added");
  const chain_ecommerce = await CHAIN_ECOMMERCE.deploy();
  await chain_ecommerce.deployed();
  const address = JSON.stringify({
    address: chain_ecommerce.address,
  });
  fs.writeFileSync(path, address);
  fs.console.log("CHAINECOMMERCE deployed to:", chain_ecommerce.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
