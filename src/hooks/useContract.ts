import { ethers } from "ethers";
import { useContext, useEffect, useState } from "react";
import { ChainEcommerce } from "../../typechain";
import { WalletContext } from "./WalletProvider";

export const useContract = (): ChainEcommerce | undefined => {
  const context = useContext(WalletContext);
  if (context?.contract) {
    const { contract } = context;
    return contract;
  }
  return undefined;
};
