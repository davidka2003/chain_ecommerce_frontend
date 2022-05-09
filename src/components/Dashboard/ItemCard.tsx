import { BigNumber, utils } from "ethers";
import React, { useState } from "react";

export const ItemCard = ({
  deliveryId,
  deliveryPrice,
  exist,
  isAvailable,
  isCanceled,
  isDelivered,
  isMinted,
  metaUri,
  owner,
  price,
  shopId,
  tokenId,
}: {
  deliveryId: BigNumber;
  deliveryPrice: BigNumber;
  exist: boolean;
  isAvailable: boolean;
  isCanceled: boolean;
  isDelivered: boolean;
  isMinted: boolean;
  metaUri: string;
  owner: string;
  price: BigNumber;
  shopId: BigNumber;
  tokenId: BigNumber;
}) => {
  const [additionalInfo, setAdditionalInfo] = useState(false);
  return (
    (exist && (
      <div>
        <img src={metaUri}></img>
        <h1>TokenId: {tokenId.toString()}</h1>
        <h1>
          Order price: {utils.formatEther(price.add(deliveryPrice))} MATIC
        </h1>
        <button onClick={() => setAdditionalInfo(!additionalInfo)}>
          {additionalInfo ? "hide info" : "show more..."}
        </button>
        {additionalInfo && (
          <div>
            <h1>Owner: {owner}</h1>
            <h1>Item price: {utils.formatEther(price)} MATIC</h1>
            <h1>Delivery cost: {utils.formatEther(deliveryPrice)} MATIC</h1>
          </div>
        )}
      </div>
    )) || <></>
  );
};
