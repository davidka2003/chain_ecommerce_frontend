import { BigNumber } from "ethers";
import React, { useEffect, useMemo, useState } from "react";
import { OrderI } from "../../store/customerReducer";
import { ItemCard } from "./ItemCard";

const ActivePurchases = ({ ordersProps }: { ordersProps: OrderI[] }) => {
  const orders = useMemo(() => {
    return ordersProps;
  }, [ordersProps]);
  return (
    <div>
      ActivePurchases
      {orders.map(
        (order, index) =>
          order.isMinted &&
          !order.isCanceled &&
          order.isAvailable &&
          !order.isDelivered && <ItemCard key={index} {...order} />
      )}
    </div>
  );
};

export default ActivePurchases;
