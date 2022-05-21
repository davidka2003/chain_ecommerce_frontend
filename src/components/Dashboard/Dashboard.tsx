import React, { useEffect, useState } from "react";
import { BigNumber, ethers } from "ethers";
import "./Dashboard.module.scss";
import styles from "./Dashboard.module.scss";
import notConnected from "../Assets/img/notFound.png";
import { useAppDispatch, useAppSelector } from "../../store/store";
import {
  setAddress,
  setBalance,
  setConnected,
} from "../../store/walletReducer";
import { useSigner } from "../../hooks/useSigner";
import { useContract } from "../../hooks/useContract";
import { ItemCard } from "../Other/ItemCard";
import Purchases from "./Orders/Orders";
import { updateCustomerInfo } from "../../store/customerReducer";
import { isConnected } from "../../hooks/isConnected";
import ConnectWalletButton from "../Other/ConnectWalletButton";

const Dashboard = () => {
  const connected = isConnected();
  const { balance, address } = useAppSelector((state) => state.walletReducer);
  const { customer } = useAppSelector((state) => state.customerReducer);
  const dispatch = useAppDispatch();

  const [errorMessage, setErrorMessage] = useState<string | null>(null);
  const contract = useContract();
  const signer = useSigner();
  useEffect(() => {
    (async () => {
      if (connected && signer && contract) {
        dispatch(setBalance(await signer.getBalance()));
        dispatch(setAddress(await signer.getAddress()));
        dispatch(updateCustomerInfo({ contract }));
      }
    })();
  }, [signer, connected]);

  return (
    <>
      <div className={styles.dashboardBody}>
        <h1>Dashboard</h1>
        <div className={styles.dashboard}>
          <Purchases />
          <div className={styles.controlPanel}>
            <div className="walletCard">
              <ConnectWalletButton className={styles.connectButton} />
              {connected && customer.customer && (
                <>
                  <div className="accountDisplay">
                    <h3>Address: {address}</h3>
                  </div>
                  <div className="balanceDisplay">
                    <h3>Balance: {balance} eth</h3>
                  </div>
                  <div className="accountDisplay">
                    <h3>Title: {customer.customer.title}</h3>
                  </div>
                  <div className="balanceDisplay">
                    <h3>Metauri: {customer.customer.uri}</h3>
                  </div>
                </>
              )}

              {errorMessage}
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

export default Dashboard;
