import React, { useContext, useEffect, useState } from "react";
import { isConnected } from "../../hooks/isConnected";
import { WalletContext } from "../../hooks/WalletProvider";

const ConnectWalletButton = ({ className }: { className: string }) => {
  const [connect, setConnect] = useState(false);
  const context = useContext(WalletContext);
  const connected = context.connected;
  useEffect(() => {
    const init = async () => {
      try {
        /* setstate connected true to walletprovider and add logic to trigger useffect with conditions and connected changes */
        const accs = await window.ethereum.request({
          method: "eth_requestAccounts",
        });
        if (accs.length) {
          console.log(accs);
          context.setConnected?.(true);
          setConnect(true);
          //   return context.connected;
        }
      } catch (error) {
        console.log(error);
        context.setConnected?.(false);
        setConnect(false);
        // return context.connected;
      }
    };
    connect && init();
  }, [connect]);
  return (
    <button
      className={className}
      disabled={connected}
      onClick={() => {
        setConnect(!connect);
      }}
    >
      {!connected ? "Connect wallet" : "Wallet connected"}
    </button>
  );
};

export default ConnectWalletButton;
