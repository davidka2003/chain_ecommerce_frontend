import { ethers } from "hardhat";
import { Ecommerce__factory } from "../typechain";
import contractAddress from "../src/.env/contract-address.json";
import CHAIN_ECOMMERCE from "../src/artifacts/contracts/Chain_ecommerce.sol/Chain_ecommerce.json";
import { BigNumber } from "ethers";
import { Ecommerce } from "../src/typechain";

// const address = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";
const init = async function () {
  const [signer] = await ethers.getSigners();
  const contract = Ecommerce__factory.connect(contractAddress.address, signer);
  // return;
  const getDeliveryPrice = async (
    deliveryId: BigNumber,
    destination: [string, string]
  ) => {
    const price = (
      await contract.getDestinationBatch(deliveryId, [destination])
    )[0].price;
    // console.log(price.toString());
    return price;
  };
  const getItemsPrice = async (shopId: BigNumber, itemIds: BigNumber[]) => {
    const price = (await contract.getItemsBatch(shopId, itemIds))
      .map((item) => item.price)
      .reduce((prev, current) => {
        return prev.add(current);
      }, BigNumber.from(0));
    // console.log(price.toString());
    return price;
  };
  ///creating customer
  let tx = await contract.editCustomer(
    "My_customer",
    "My_metauri",
    ethers.constants.AddressZero
  );
  await tx.wait();
  ///creating shop
  tx = await contract.editShop(
    "My_shop",
    "My_metauri",
    await signer.getAddress(),
    true
  );
  await tx.wait();
  ///creating delivery
  tx = await contract.editDelivery(
    "My_delivery",
    "My_metauri",
    await signer.getAddress(),
    true
  );
  await tx.wait();
  ///creating items
  tx = await contract.editItemBatch(
    [0, 0, 0, 0].map((id) => BigNumber.from(id)),
    ["0.6", "0.7", "0.9", "1"].map((price) => ethers.utils.parseEther(price)),
    ["Uri1", "Uri2", "Uri3", "Uri4"],
    [true, true, true, true]
  );
  // console.log(await contract.getShop(0));
  // return;

  await tx.wait();
  ///adding destination
  tx = await contract.editDestinationBatch(
    ["IL", "RU"],
    ["HF", "SPB"],
    ["0.5", "1"].map((price) => ethers.utils.parseEther(price))
  );
  await tx.wait();
  ///connecting shop to delivery
  tx = await contract.editConnectedShopBatch(
    [1].map((shopId) => BigNumber.from(shopId)),
    [true]
  );
  await tx.wait();
  ///creating 2 orders
  tx = await contract.createOrder(
    1,
    1,
    [1],
    ["IL", "HF"],
    JSON.stringify({ data: "data" }),
    { value: ethers.utils.parseEther((0.6 + 0.5).toString()) }
  ); ///NA error ecommerce 119
  await tx.wait();
  tx = await contract.createOrder(
    1,
    1,
    [2],
    ["RU", "SPB"],
    JSON.stringify({ data: "data" }),
    {
      value: (
        await getDeliveryPrice(BigNumber.from(1), ["RU", "SPB"])
      )
        // .add(ethers.utils.parseEther("0.5"))
        .add(
          await getItemsPrice(
            BigNumber.from(1),
            [2].map((a) => BigNumber.from(a))
          )
        ),
    }
  ); ///NA error ecommerce 119
  await tx.wait();
  // console.log(await contract.getOrdersBatch(1, [2]));
  // return;
  // console.log(await contract.getDelivery(1));
  ///cancel order
  const order = (await contract.getOrdersBatch(1, [1]))[0];
  console.log("Canceling order:", order.id, order.deliveryId);
  tx = await contract.cancelOrder(order.deliveryId, order.id, {
    value: ethers.utils.parseEther("0.5"),
  });
  await tx.wait();
  // console.log(await contract.getCustomer(0));
};
init();
