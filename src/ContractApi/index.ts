import { BigNumber } from "ethers";
import { ChainEcommerce } from "../typechain";

export const getRoles = async (contract: ChainEcommerce) => {
  const shopId = await contract.getShopId().catch(() => BigNumber.from(0));
  const customerId = await contract
    .getCustomerId()
    .catch(() => BigNumber.from(0));
  const deliveryId = await contract
    .getDeliveryId()
    .catch(() => BigNumber.from(0));
  return {
    isShop: !!shopId.gt(0),
    isCustomer: !!customerId.gt(0),
    isDelivery: !!deliveryId.gt(0),
  };
};
