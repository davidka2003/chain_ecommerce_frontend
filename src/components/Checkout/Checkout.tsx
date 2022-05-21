import axios from "axios";
import { BigNumber } from "ethers";
import React, { useEffect, useMemo, useState } from "react";
import { useParams } from "react-router-dom";
import { GetCheckoutInfo } from "../../Api/checkout";
import { Purchase } from "../../ContractApi";
import { useContract } from "../../hooks/useContract";
import ConnectWalletButton from "../Other/ConnectWalletButton";

const Checkout = () => {
  const contract = useContract();
  const [orderInfo, setOrderInfo] = useState<{
    address: string;
    deliveryId: BigNumber;
    shopId: BigNumber;
    tokenIds: BigNumber[];
  }>();
  const params = useParams<{ id: string }>();
  const id = decodeURIComponent(params.id!);
  useEffect(() => {
    (async () => {
      const data = await GetCheckoutInfo(id);
      console.log(data);
      setOrderInfo({
        address: data.address,
        deliveryId: BigNumber.from(data.deliveryId),
        shopId: BigNumber.from(data.shopId),
        tokenIds: data.tokenIds.map((tokenId: string) =>
          BigNumber.from(tokenId)
        ),
      });
    })();
  }, []);
  return (
    <div>
      {/* Checkout id: {id}
      address: {orderInfo?.address} */}
      <br></br>
      <ConnectWalletButton className="sad"></ConnectWalletButton>
      {!!orderInfo && contract && (
        <button
          onClick={() => {
            Purchase(
              contract,
              orderInfo.shopId,
              orderInfo.deliveryId,
              orderInfo.tokenIds
            );
          }}
        >
          Purchase
        </button>
      )}
    </div>
  );
};

export default Checkout;
