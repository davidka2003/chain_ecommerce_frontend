import { BigNumber, ethers } from "ethers";
import { Ecommerce } from "../typechain";

export const getRoles = async (contract: Ecommerce) => {
  const shopId = await contract
    .getShop(0)
    .then((shop) => shop.id)
    .catch(() => BigNumber.from(0));
  const customerId = await contract
    .getCustomer(0)
    .then((customer) => customer.id)
    .catch(() => BigNumber.from(0));
  const deliveryId = await contract
    .getDelivery(0)
    .then((delivery) => delivery.id)
    .catch(() => BigNumber.from(0));
  return {
    isShop: !!shopId.gt(0),
    isCustomer: !!customerId.gt(0),
    isDelivery: !!deliveryId.gt(0),
  };
};
export const Purchase = async (
  contract: Ecommerce,
  shopId: string,
  deliveryId: string,
  itemIds: string[],
  destination: [string, string],
  sessionId: string
) => {
  const delivery = await contract.getDelivery(BigNumber.from(deliveryId));
  const shop = await contract.getShop(BigNumber.from(shopId));
  const items = await contract.getItemsBatch(BigNumber.from(shopId), itemIds);
  console.log(items);
  const itemsPrice = items
    .map((item) => item.price)
    .reduce((a, b) => {
      // const item = a;
      // a.price = a.price;
      return a.add(b);
    }, BigNumber.from(0));
  const deliveryPrice = (
    await contract.getDestinationBatch(delivery.id, [destination])
  )[0].price;
  // console.log(value.toString());

  const tx = await contract.createOrder(
    shop.id,
    delivery.id,
    itemIds.map((id) => BigNumber.from(id)),
    destination,
    sessionId,
    {
      value: itemsPrice.add(deliveryPrice), //: ethers.utils.parseEther("1.5"),
    }
  );
  console.log(tx.hash);
};
