import { ethers } from "ethers";
import { useContext, useEffect, useState } from "react";
import { WalletContext } from "./WalletProvider";

export const useProvider = (): ethers.providers.Web3Provider | undefined => {
  const context = useContext(WalletContext);
  if (context.connected && context?.provider) {
    const { provider } = context;
    return provider;
  }
  return undefined;
};
