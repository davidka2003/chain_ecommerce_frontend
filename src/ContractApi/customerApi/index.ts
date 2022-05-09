import { BigNumber } from "ethers";
import { OrderI } from "../../store/customerReducer";
import { ChainEcommerce } from "../../typechain";

export const updatePurchases = async (contract: ChainEcommerce) => {
  const orders = <Promise<OrderI[]>[]>[];
  const customerId = await contract.getCustomerId();
  console.log(await contract.signer.getAddress());
  console.log(customerId);
  const customer = await contract.getCustomer(customerId);
  const shops = customer.shops;
  for (const shop of shops) {
    orders.push(contract.getCustomerPurchases(customerId, shop));
  }
  console.log((await Promise.all(orders)).flat());
  // console.log(await contract.getCustomerPurchases(1, 1));
  // console.log(orders);
  return (await Promise.all(orders)).flat();
};
export const updateCustomer = async (contract: ChainEcommerce) => {
  const customerId = await contract.getCustomerId();
  const customer = await contract.getCustomer(customerId);
  return customer;
};
export const cancelOrder = async ({
  contract,
  shopId,
  orderIds,
  comission,
}: {
  contract: ChainEcommerce;
  orderIds: BigNumber[];
  shopId: BigNumber;
  comission: BigNumber;
}) => {
  console.log(comission);
  await contract.cancelItems(shopId, orderIds, { value: comission });
  // return [];
  process.env.ROPSTEN_URL =
    "http://127.0.0.1:8545" &&
    (await new Promise((resolve) => setTimeout(resolve, 5000)));
  return await updatePurchases(contract);
};
