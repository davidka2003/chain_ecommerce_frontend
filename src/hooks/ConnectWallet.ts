import { ethers } from "ethers";
import { useContext, useEffect, useState } from "react";
import { WalletContext } from "./WalletProvider";

export const ConnectWallet = async (): Promise<boolean> => {
  try {
    const accs = await window.ethereum.request({
      method: "eth_requestAccounts",
    });
    if (accs.length) {
      console.log(accs);
      return true;
    }
  } catch (error) {
    console.log(error);
    return false;
  }

  return false;
};
