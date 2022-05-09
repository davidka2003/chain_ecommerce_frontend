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

  let shops = await contract.getShops();
  // console.log
  console.log("line 16", shops);
  // return;
  if (!shops.length) {
    await contract.addShop("myShop", "metaUri", signer.address);
    console.log(await contract.getShops());
  } else console.log("Shop already exist");
  if (!(await contract.getShopItems(1)).length) {
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
  const item1 = (await contract.getShopItems(1))[0];
  const item2 = (await contract.getShopItems(1))[1];
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
  shops = await contract.getShops();
  await contract.addDeliveryMethodToShops([shops[0]]);
  // return;
  // const delivery = await contract.getDelivery(1);
  // console.log(delivery);
  const value = item1.price.add(ethers.utils.parseEther("0.7"));
  if (!(await contract.getCustomers()).length) {
    await contract.mintItems(
      shops[0],
      [item1.tokenId],
      1 /* delivery.deliveryId */,
      "sessionId",
      { value }
    );
    await contract.mintItems(
      shops[0],
      [item2.tokenId],
      1 /* delivery.deliveryId */,
      "sessionId",
      { value: item2.price.add(ethers.utils.parseEther("0.7")) }
    );
  }
  const customers = await contract.getCustomers();
  console.log("Ammount of customers:", customers.length);

  // console.log(customers[0], shops[0]);
  // return;
  console.log(await contract.getCustomerPurchases(customers[0], shops[0]));
  // return;
  // console.log(item1.shopId);
  // console.log(item2.shopId);
  // console.log(await contract.getItems())
  // console.log(await contract.getItem(0))
  // await
};
init();
