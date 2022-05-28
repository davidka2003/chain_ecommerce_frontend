import axios from "axios";
import { BigNumber } from "ethers";
import React, { useEffect, useMemo, useState } from "react";
import { useParams } from "react-router-dom";
import { checkoutInfoT } from "../../Api";
import { GetCheckoutInfo } from "../../Api/checkout";
import { Purchase } from "../../ContractApi";
import { useContract } from "../../hooks/useContract";
import ConnectWalletButton from "../Other/ConnectWalletButton";

const Checkout = () => {
  const contract = useContract();
  const [orderInfo, setOrderInfo] = useState<checkoutInfoT>();
  const params = useParams<{ id: string }>();
  const id = decodeURIComponent(params.id!);
  useEffect(() => {
    (async () => {
      const data = await GetCheckoutInfo(id);
      console.log(data);
      setOrderInfo({
        // address: data.address,
        destination: data.destination,
        hash: data.hash,
        shop_sid: data.shop_sid,
        deliveryId: data.deliveryId,
        shopId: data.shopId,
        tokenIds: /* ["4"] ||  */ data.tokenIds,
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
              orderInfo.tokenIds,
              orderInfo.destination,
              orderInfo.hash
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
