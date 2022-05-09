import { ethers } from "hardhat";
import { ChainEcommerce__factory } from "../typechain";
import contractAddress from "../src/.env/contract-address.json";
import CHAIN_ECOMMERCE from "../src/artifacts/contracts/Chain_ecommerce.sol/Chain_ecommerce.json";

// const address = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";
const init = async function () {
  const [signer] = await ethers.getSigners();
  const contract = ChainEcommerce__factory.connect(
    contractAddress.address,
    signer
  );
  // const contract = new ethers.Contract(
  //   /* "CHAINECOMMERCE" ||  */ contractAddress.address,
  //   CHAIN_ECOMMERCE.abi,
  //   signer
  // );
  const shops = await contract.getShops();
  // console.log
  console.log(shops.length);
  if (!shops.length) {
    await contract.addShop("myShop", "metaUri", signer.address);
  } else console.log("Shop already exist");
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
  console.log("Ammount of customers:", customers.length);
  const deliveries = await contract.getDeliveries();
  if (!deliveries.length) {
    await contract.addDelivery(
      "deliveryTitle",
      "deliveryMetaUri",
      signer.address,
      ethers.utils.parseEther("0.7")
    );
  }
  // console.log(shops);
  // return;
  await contract.addDeliveryMethodToShops([shops[0]]);
  // return;
  const delivery = await contract.getDelivery(0);
  console.log(delivery);
  const value = item.price.add(ethers.utils.parseEther("0.7"));
  if (!customers.length) {
    await contract.mintItems(
      shops[0],
      [item.tokenId],
      0 /* delivery.deliveryId */,
      "sessionId",
      { value }
    );
  }
  console.log(customers[0], shops[0]);
  // return;
  console.log(await contract.getCustomerPurchases(customers[0], shops[0]));
  // return;
  console.log(item.shopId);
  // console.log(await contract.getItems())
  // console.log(await contract.getItem(0))
  // await
};
init();
