import { expect } from "chai";
import { ethers } from "hardhat";
import contractAddress from "../src/.env/contract-address.json";
import CHAIN_ECOMMERCE from "../src/artifacts/contracts/CHAIN_ECOMMERCE.sol/CHAIN_ECOMMERCE.json";

// const address = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";
const init = async function () {
  const [signer] = await ethers.getSigners();
  const contract = new ethers.Contract(
    contractAddress.address,
    CHAIN_ECOMMERCE.abi,
    signer
  );
  const shops = await contract.getShops();
  // console.log
  console.log(shops.length);
  if (!shops.length) {
    await contract.addShop("myShop", "metaUri", signer.address);
  }
  console.log("Shop already exist");
  if (!(await contract.getShopItems(0)).length) {
    await contract.addItems(
      ["metaUri_item1", "metaUri_item2", "metaUri_item3"],
      [
        ethers.utils.parseEther("0.6"),
        ethers.utils.parseEther("0.7"),
        ethers.utils.parseEther("0.8"),
      ]
    );
  }
  console.log(await contract.getShops());
  const item = (await contract.getShopItems(0))[0];
  const customers = await contract.getCustomers();
  if (!customers.length) {
    // await contract.
    await contract.mintItems(
      shops[0],
      [item.tokenId],
      item.deliveryId,
      "sessionId",
      { value: item.price }
    );
  }
  console.log(await contract.getCustomerId(customers[0], shops[0]));
  console.log(item.shopId);
  // console.log(await contract.getItems())
  // console.log(await contract.getItem(0))
  // await
};
init();
