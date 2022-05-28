import { BigNumber } from "ethers";
import { Ecommerce } from "../typechain";
import { ItemI, OrderI } from "./contractTypes";
/// optimize it later
export const updateOrdersDelivery = async (contract: Ecommerce) => {
  const delivery = await contract.getDelivery(BigNumber.from(0));
  const orders = await contract.getOrdersBatch(
    delivery.id,
    Array.from(Array(delivery.orderId.toNumber() - 1).keys()).map((id) =>
      BigNumber.from(id++)
    )
  );
  return await Promise.all(orders);
};
export const updateOrderItems = async (contract: Ecommerce, order: OrderI) => {
  return (await contract.getItemsBatch(order.shopId, order.itemIds)) as ItemI[];
};
export const updateDelivery = async (contract: Ecommerce) => {
  return await contract.getDelivery(0);
};
export const cancelOrderDelivery = async ({
  contract,
  order,
  comission,
}: {
  contract: Ecommerce;
  order: OrderI;
  comission: BigNumber;
}) => {
  console.log(comission, order.deliveryId.toString());
  await contract.cancelOrder(BigNumber.from(0), order.id, { value: comission });
  // return [];
  await new Promise((resolve) => setTimeout(resolve, 5000));
  return await updateOrdersDelivery(contract);
};
