import { BigNumber, utils } from "ethers";
import React, { useEffect, useMemo, useState } from "react";
import { ItemI } from "../../ContractApi/contractTypes";
import { useContract } from "../../hooks/useContract";
import { cancelOrder } from "../../store/customerReducer";
import { useAppDispatch } from "../../store/store";

export const ItemCard = ({ item }: { item: ItemI }) => {
  const [additionalInfo, setAdditionalInfo] = useState(false);
  return (
    <div>
      <img src={item.uri}></img>
      <h1>TokenId: {item.id.toString()}</h1>
      <h1>Item price: {utils.formatEther(item.price)} MATIC</h1>
      <button onClick={() => setAdditionalInfo(!additionalInfo)}>
        {additionalInfo ? "hide info" : "show more..."}
      </button>
      {additionalInfo && (
        <div>
          <h1>OwnerId: {item.owner.toString()}</h1>
          <h1>Item price: {utils.formatEther(item.price)} MATIC</h1>
          <h1>Shop: {item.shopId.toString()}</h1>
        </div>
      )}
    </div>
  );
};
