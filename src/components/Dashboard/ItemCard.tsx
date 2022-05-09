import { BigNumber, utils } from "ethers";
import React, { useEffect, useMemo, useState } from "react";
import { useContract } from "../../hooks/useContract";
import { cancelCustomerItems } from "../../store/customerReducer";
import { useAppDispatch } from "../../store/store";

export const ItemCard = ({
  deliveryId,
  deliveryPrice,
  exist,
  isAvailable,
  isCanceled,
  isDelivered,
  isMinted,
  metaUri,
  ownerId,
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
  ownerId: BigNumber;
  price: BigNumber;
  shopId: BigNumber;
  tokenId: BigNumber;
}) => {
  const dispatch = useAppDispatch();
  const [FIXED_COMISSION, setFIXED_COMISSION] = useState(utils.parseEther("0"));
  useEffect(() => {
    const init = async () => {
      contract && setFIXED_COMISSION(await contract.FIXED_COMISSION());
    };
    init();
  }, []);

  // const FIXED_COMISSION = useMemo(contract?.FIXED_COMISSION
  const contract = useContract();
  const [additionalInfo, setAdditionalInfo] = useState(false);
  const availableToCancel =
    !isDelivered && !isCanceled && isMinted && isAvailable && exist;
  // const owner = useMemo( ()=>{
  //   return Promise.resolve("")
  // },[])
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
            <h1>OwnerId: {ownerId.toString()}</h1>
            <h1>Item price: {utils.formatEther(price)} MATIC</h1>
            <h1>Delivery cost: {utils.formatEther(deliveryPrice)} MATIC</h1>
          </div>
        )}
        {contract && availableToCancel && (
          <button
            onClick={() => {
              console.log(shopId, [tokenId]);
              !FIXED_COMISSION.isZero() &&
                dispatch(
                  cancelCustomerItems({
                    contract,
                    orderIds: [tokenId],
                    shopId,
                    comission: FIXED_COMISSION,
                  })
                );
            }}
          >
            Cancel order {utils.formatEther(FIXED_COMISSION)} eth
          </button>
        )}
      </div>
    )) || <></>
  );
};
