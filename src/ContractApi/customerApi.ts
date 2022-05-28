import { BigNumber } from "ethers";
import { Ecommerce } from "../typechain";
import { ItemI, OrderI } from "./contractTypes";
/// optimize it later
export const updateOrders = async (contract: Ecommerce) => {
  const customer = await contract.getCustomer(0);
  const orderIds = customer.orders;
  const orders = [] as Promise<{ order: OrderI; items: ItemI[] }>[];
  for (const order of orderIds) {
    orders.push(
      (async () => {
        const ord = (await contract.getOrdersBatch(order[0], [order[1]]))[0];
        const items = await updateOrderItems(contract, ord);
        return {
          order: ord,
          items,
        };
      })()
    );
  }
  return await Promise.all(orders);
};
export const updateOrderItems = async (contract: Ecommerce, order: OrderI) => {
  return (await contract.getItemsBatch(order.shopId, order.itemIds)) as ItemI[];
};
export const updateCustomer = async (contract: Ecommerce) => {
  return await contract.getCustomer(0);
};
export const cancelOrderCustomer = async ({
  contract,
  order,
  comission,
}: {
  contract: Ecommerce;
  order: OrderI;
  comission: BigNumber;
}) => {
  console.log(comission, order.deliveryId.toString());
  await contract.cancelOrder(order.deliveryId, order.id, { value: comission });
  // return [];
  await new Promise((resolve) => setTimeout(resolve, 5000));
  return await updateOrders(contract);
};
