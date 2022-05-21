// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
import { ethers } from "hardhat";
import fs from "fs";
import fse from "fs-extra";
import Path from "path";

const srcDir = Path.join(__dirname, `../typechain`);
const destDir = Path.join(__dirname, `../src/typechain`);

// To copy a folder or file
const path = "src/.env/contract-address.json";

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // We get the contract to deploy
  const CHAIN_ECOMMERCE = await ethers.getContractFactory("Ecommerce");
  console.log("factory added");
  const chain_ecommerce = await CHAIN_ECOMMERCE.deploy({ gasLimit: 30000000 });
  await chain_ecommerce.deployed();
  const address = JSON.stringify({
    address: chain_ecommerce.address,
  });
  fs.writeFileSync(path, address);
  console.log("CHAINECOMMERCE deployed to:", chain_ecommerce.address);
  fse.copySync(srcDir, destDir, { overwrite: true });
  console.log("typechain coppied");
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
