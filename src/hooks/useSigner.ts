import { ethers } from "ethers";
import { useContext, useEffect, useState } from "react";
import { WalletContext } from "./WalletProvider";

export const useSigner =
  () /* : ethers.providers.JsonRpcSigner | undefined */ => {
    const context = useContext(WalletContext);
    if (context.connected && context?.signer) {
      const { signer } = context;
      // console.log("signer changed");
      return signer;
    }
    return undefined;
  };
