import { ethers } from "ethers";
import { useContext, useEffect, useState } from "react";
import { Ecommerce } from "../typechain";

import { WalletContext } from "./WalletProvider";

export const useContract = () /* : Ecommerce | undefined */ => {
  const context = useContext(WalletContext);
  if (context.connected && context?.contract) {
    const { contract } = context;
    return contract;
  }
  return undefined;
};
