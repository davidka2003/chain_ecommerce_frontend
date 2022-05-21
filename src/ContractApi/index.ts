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
  shopId: BigNumber,
  deliveryId: BigNumber,
  itemIds: BigNumber[],
  sessionId?: string
) => {
  const delivery = await contract.getDelivery(deliveryId);
  // delivery.shift
  const shopIds = new Array(itemIds.length).fill(shopId);
  const items = await contract.getItemsBatch(shopIds, itemIds);
  console.log(items);
  const value = items
    .map((item) => item.price)
    .reduce((a, b) => {
      // const item = a;
      // a.price = a.price;
      return a.add(b);
    });
  console.log(value.toString());

  const tx = await contract.createOrder(
    shopId,
    deliveryId,
    itemIds,
    ["IL", "HF"],
    sessionId || "",
    {
      value, //: ethers.utils.parseEther("1.5"),
    }
  );
  console.log(tx.hash);
};
