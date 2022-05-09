import { ethers } from "ethers";
import { useContext, useEffect, useState } from "react";
import { WalletContext } from "./WalletProvider";

export const isConnected = (): boolean => {
  const context = useContext(WalletContext);
  return context.connected;
};
