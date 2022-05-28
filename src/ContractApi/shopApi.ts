import { Ecommerce } from "../typechain/Ecommerce";

export const updateShop = async (contract: Ecommerce) => {
  return await contract.getShop(0);
};
