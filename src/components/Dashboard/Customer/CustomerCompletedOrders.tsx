import { useMemo } from "react";
import { OrderIExt } from "../../../store";
import { ItemCard } from "../../Other/ItemCard";

const CompletedPurchases = ({ ordersProps }: { ordersProps: OrderIExt[] }) => {
  const orders = useMemo(() => ordersProps, [ordersProps]);
  return (
    <div>
      CompletedPurchases
      {orders.map(
        ({ order, items }, index) =>
          order.isDelivered && (
            <div key={index}>
              <div>Order: {order.id.toString()}</div>
              {items.map((item, index) => (
                <ItemCard key={index} item={item} />
              ))}
            </div>
          )
      )}
    </div>
  );
};

export default CompletedPurchases;
