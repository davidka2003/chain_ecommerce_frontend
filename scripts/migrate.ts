// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
import { ethers } from "hardhat";
import fs from "fs";
import fse from "fs-extra";
import Path from "path";
import { address } from "../src/.env/contract-address.json";
// import "../../chain_ecommerce_backend/typechain"

const srcDir = Path.join(__dirname, `../typechain`);
const destDir = Path.join(__dirname, `../../chain_ecommerce_backend/typechain`);

// To copy a folder or file
const path = Path.join(__dirname, "../src/.env");
const pathToAddrBackend = Path.join(
  __dirname,
  `../../chain_ecommerce_backend/src/.env`
);

async function main() {
  //   fs.writeFileSync(
  //     pathToAddrBackend,
  //     JSON.stringify({
  //       address,
  //     })
  //   );
  fse.copySync(path, pathToAddrBackend);
  console.log("address migrated");
  fse.copySync(srcDir, destDir, { overwrite: true });
  console.log("typechain migrated");
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
