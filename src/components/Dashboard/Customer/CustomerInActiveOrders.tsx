import { useMemo } from "react";
import { OrderIExt } from "../../../store";
import { ItemCard } from "../../Other/ItemCard";

const InactiveOrders = ({ ordersProps }: { ordersProps: OrderIExt[] }) => {
  const orders = useMemo(() => ordersProps, [ordersProps]);
  return (
    <div>
      Inactive purchases
      {orders.map(
        ({ order, items }, index) =>
          order.isCanceled && (
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

export default InactiveOrders;
