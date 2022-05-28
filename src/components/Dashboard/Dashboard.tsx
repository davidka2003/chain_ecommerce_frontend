import React, { ChangeEvent, useEffect, useMemo, useState } from "react";
import { BigNumber, ethers } from "ethers";
import "./Dashboard.module.scss";
import styles from "./Dashboard.module.scss";
import notConnected from "../Assets/img/notFound.png";
import { useAppDispatch, useAppSelector } from "../../store/store";
import { useSigner } from "../../hooks/useSigner";
import { useContract } from "../../hooks/useContract";
import Purchases from "./Customer/CustomerOrders";
import { isConnected } from "../../hooks/isConnected";
import ConnectWalletButton from "../Other/ConnectWalletButton";
import CustomerCard from "./StructCards/CustomerCard";
import { getRoles } from "../../ContractApi";
import DeliveryCard from "./StructCards/DeliveryCard";
import ShopCard from "./StructCards/ShopCard";
import { RoleT } from "../../ContractApi/contractTypes";
import WalletCard from "./WalletCard";

const Dashboard = () => {
  const [errorMessage, setErrorMessage] = useState<string | null>(null);
  const contract = useContract();
  const connected = isConnected();
  const [roles, setRoles] = useState<RoleT[]>([]);
  const [currentRole, setCurrentRole] = useState<typeof roles[0] | undefined>(
    undefined
  );
  useEffect(() => {
    const init = async () => {
      if (contract) {
        const roles = await getRoles(contract);
        setRoles(roles);
        setCurrentRole(roles[0]);
      }
    };
    connected && contract && init();
  }, [connected, contract]);
  return (
    <>
      {connected && roles.length > 1 && (
        <select
          onChange={({ target }) => {
            setCurrentRole(target.value as typeof roles[0]);
          }}
          defaultValue={currentRole}
        >
          {roles.map((role, index) => (
            <option key={index} value={role}>
              {role}
            </option>
          ))}
        </select>
      )}
      <div className={styles.dashboardBody}>
        <h1>Dashboard</h1>
        <div className={styles.dashboard}>
          {/** @dev replace to customerCard  */}
          <Purchases />
          <div className={styles.controlPanel}>
            <div className="walletCard">
              {/**@dev add create user later if roles.length == 0 */}
              <ConnectWalletButton className={styles.connectButton} />
              {currentRole && <WalletCard role={currentRole} />}
              {/* {currentRole == "customer" && <CustomerCard />}
              {currentRole == "delivery" && <DeliveryCard />}
              {currentRole == "shop" && <ShopCard />} */}
              {errorMessage}
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

export default Dashboard;
