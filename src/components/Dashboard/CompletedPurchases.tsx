import { BigNumber } from "ethers";
import React, { useEffect, useMemo, useState } from "react";
import { OrderI } from "../../store/customerReducer";
import { ItemCard } from "./ItemCard";

const CompletedPurchases = ({ ordersProps }: { ordersProps: OrderI[] }) => {
  const orders = useMemo(() => {
    return ordersProps;
  }, [ordersProps]);
  // console.log(orders);
  return (
    <div>
      CompletedPurchases
      {orders.map(
        (order, index) =>
          ((order.isMinted && order.isCanceled) || order.isDelivered) && (
            <ItemCard key={index} {...order} />
          )
      )}
    </div>
  );
};

export default CompletedPurchases;
