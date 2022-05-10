import { BigNumber } from "ethers";
import React, { useEffect, useState } from "react";
import { getRoles } from "../../ContractApi";
import { useContract } from "../../hooks/useContract";
import { useProvider } from "../../hooks/useProvider";
import { useSigner } from "../../hooks/useSigner";
import { OrderI, updateCustomerPurchases } from "../../store/customerReducer";
import { useAppDispatch, useAppSelector } from "../../store/store";
import ActivePurchases from "./ActivePurchases";
import CompletedPurchases from "./CompletedPurchases";
import styles from "./Dashboard.module.scss";
import { ItemCard } from "./ItemCard";
const Purchases = () => {
  const { orders } = useAppSelector((state) => state.customerReducer);
  const dispatch = useAppDispatch();
  const contract = useContract();
  const signer = useSigner();
  useEffect(() => {
    if (contract) {
      dispatch(updateCustomerPurchases({ contract }));
      getRoles(contract).then(console.log);
    }
  }, [signer]);
  // console.log("Purchases re-render", orders);
  return (
    <div className={styles.purchasesStatus}>
      <ActivePurchases ordersProps={orders.orders} />
      <div>Fetch: {orders.status}</div>
      <CompletedPurchases ordersProps={orders.orders} />
      <div>Fetch: {orders.status}</div>
      <div className={styles.purchasesActive}>
        <p className={styles.purchasesStatusText}>Your active purchases</p>
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
        <p className={styles.purchasesStatusText}>Your completed purchases</p>
        <div className={styles.mmStatus}>
          <div className={styles.puchasesCompletedPanels}>
            <div className={styles.purchases}>
              <div className={styles.purchasesIcons}>
                <img src="../check.png" alt="" />
                <div className={styles.descriptionIcons}>
                  <p>Aboba.com</p>
                </div>
                <div className={styles.descriptionControls}>
                  <button className={styles.CheckInfoBtnCompleted}>Info</button>
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
  );
};

export default Purchases;
