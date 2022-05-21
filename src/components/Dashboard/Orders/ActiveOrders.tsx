import { useMemo } from "react";
import { useContract } from "../../../hooks/useContract";
import { OrderIExt } from "../../../store";
import { cancelOrder } from "../../../store/customerReducer";
import { useAppDispatch } from "../../../store/store";
import { ItemCard } from "../../Other/ItemCard";

const ActiveOrders = ({
  ordersProps: orderProps,
}: {
  ordersProps: OrderIExt[];
}) => {
  const orders = useMemo(() => orderProps, [orderProps]);
  const dispatch = useAppDispatch();
  const contract = useContract();
  return (
    <div>
      ActivePurchases
      {orders.map(
        ({ order, items }, index) =>
          !order.isDelivered &&
          !order.isCanceled && (
            <div key={index}>
              <div>Order: {order.id.toString()}</div>
              {items.map((item, index) => (
                <ItemCard key={index} item={item} />
              ))}
              <button
                disabled={!contract}
                onClick={() => {
                  contract && dispatch(cancelOrder({ contract, order }));
                }}
              >
                Cancel order
              </button>
            </div>
          )
      )}
    </div>
  );
};

export default ActiveOrders;
