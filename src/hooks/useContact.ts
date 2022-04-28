import { ethers } from "ethers";
import { useContext, useEffect, useState } from "react";
import { WalletContext } from "./WalletProvider";

export const useContract = (): ethers.Contract | undefined => {
  const context = useContext(WalletContext);
  if (context?.contract) {
    const { contract } = context;
    return contract;
  }
  return undefined;
};
