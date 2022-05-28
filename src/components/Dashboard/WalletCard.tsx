import { ethers } from "ethers";
import React, { useEffect, useState } from "react";
import { getRoles } from "../../ContractApi";
import { RoleT } from "../../ContractApi/contractTypes";
import { isConnected } from "../../hooks/isConnected";
import { useContract } from "../../hooks/useContract";
import { useSigner } from "../../hooks/useSigner";
import { useAppDispatch, useAppSelector } from "../../store/store";
import {
  setAddress,
  setBalance,
  updateRoleInfo,
} from "../../store/walletReducer";
import CustomerCard from "./StructCards/CustomerCard";
import DeliveryCard from "./StructCards/DeliveryCard";
import ShopCard from "./StructCards/ShopCard";

const WalletCard = (props: { role: RoleT }) => {
  const connected = isConnected();
  const { balance, address, struct } = useAppSelector(
    (state) => state.walletReducer
  );
  const dispatch = useAppDispatch();
  const contract = useContract();
  const signer = useSigner();
  useEffect(() => {
    (async () => {
      if (connected && signer && contract) {
        dispatch(setBalance(await signer.getBalance()));
        dispatch(setAddress(await signer.getAddress()));
        dispatch(updateRoleInfo({ contract, role: props.role }));
      }
    })();
  }, [signer, connected, props.role]);

  return (
    (!!connected && !!struct.struct && (
      <>
        {props.role == "customer" && <CustomerCard />}
        {props.role == "delivery" && <DeliveryCard />}
        {props.role == "shop" && <ShopCard />}

        <span>struct: {props.role}</span>
        <div className="accountDisplay">
          <h3>Address: {address}</h3>
        </div>
        <div className="balanceDisplay">
          <h3>Wallet balance: {balance} eth</h3>
        </div>
        <div className="balanceDisplay">
          <h3>
            {props.role} balance:{" "}
            {ethers.utils.formatEther(struct.struct.balance)} eth
          </h3>
        </div>
        <div className="accountDisplay">
          <h3>Title: {struct.struct.title}</h3>
        </div>
        <div className="balanceDisplay">
          <h3>Metauri: {struct.struct.uri}</h3>
        </div>
      </>
    )) || <></>
  );
};

export default WalletCard;
