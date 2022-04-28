import React, { useEffect, useState } from "react";
import { ethers } from "ethers";
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
import { useContract } from "../../hooks/useContact";
import { ConnectWallet } from "../../hooks/ConnectWallet";

const Dashboard = () => {
  const { balance, address, connected } = useAppSelector(
    (state) => state.walletReducer
  );
  const dispatch = useAppDispatch();

  const [errorMessage, setErrorMessage] = useState<string | null>(null);
  const contract = useContract();
  const signer = useSigner();
  useEffect(() => {
    (async () => {
      if (signer) {
        dispatch(setBalance(await signer.getBalance()));
        dispatch(setAddress(await signer.getAddress()));
        console.log("address: ", await signer?.getAddress());
        console.log(contract?.address);
        console.log(await contract?.getCustomer());
      }
      // console.log(contract?.address);
    })();
  }, [signer]);

  return (
    <>
      {/* <button onClick={() => console.log(state)}>debug state</button>
      {Object.entries(state).flat().join(",")} */}
      <div className={styles.dashboardBody}>
        <h1>Dashboard</h1>
        <div className={styles.dashboard}>
          <div className={styles.purchasesStatus}>
            <div className={styles.purchasesActive}>
              <p className={styles.purchasesStatusText}>
                Your active purchases
              </p>
              <div className={styles.mmStatus}>
                <div className={styles.puchasesActivePanels}>
                  <div className={styles.purchases}>
                    <div className={styles.purchasesIcons}>
                      <img src="../check.png" alt="" />
                      <div className={styles.descriptionIcons}>
                        <p>Shopify.com</p>
                      </div>
                      <div className={styles.descriptionControls}>
                        <button className={styles.CheckInfoBtn}>Info</button>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              {/* <div className="notConnectedError">
                                <img src={notConnected} alt="" />
                                <p>{purchasesActiveStatus}</p>
                            </div> */}
            </div>
            <div className={styles.purchasesCompleted}>
              <p className={styles.purchasesStatusText}>
                Your completed purchases
              </p>
              <div className={styles.mmStatus}>
                <div className={styles.puchasesCompletedPanels}>
                  <div className={styles.purchases}>
                    <div className={styles.purchasesIcons}>
                      <img src="../check.png" alt="" />
                      <div className={styles.descriptionIcons}>
                        <p>Aboba.com</p>
                      </div>
                      <div className={styles.descriptionControls}>
                        <button className={styles.CheckInfoBtnCompleted}>
                          Info
                        </button>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              {/* <div className="notConnectedError2">
                                <img src={notConnected} alt="" />
                                <p>{purchasesCompletedStatus}</p>
                            </div> */}
            </div>
          </div>

          <div className={styles.controlPanel}>
            <div className="walletCard">
              <button
                className={styles.connectButton}
                onClick={async () => {
                  const connected = await ConnectWallet();
                  dispatch(setConnected(connected));
                }}
                disabled={connected}
              >
                {!connected ? "Connect wallet" : "Wallet connected"}
              </button>
              {connected && (
                <>
                  <div className="accountDisplay">
                    <h3>Address: {address}</h3>
                  </div>
                  <div className="balanceDisplay">
                    <h3>Balance: {balance} eth</h3>
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