import { createAsyncThunk, createSlice, PayloadAction } from "@reduxjs/toolkit";
import { BigNumber, Contract, ethers, utils } from "ethers";
import { OrderIExt } from ".";
import {
  CustomerI,
  DeliveryI,
  ItemI,
  OrderI,
} from "../ContractApi/contractTypes";
import {
  updateDelivery,
  updateOrdersDelivery,
} from "../ContractApi/deliveryApi";
import { Ecommerce } from "../typechain";
export type status = "success" | "pending" | "failure";
/** @dev add limit later  */
export const updateDeliveryOrders = createAsyncThunk(
  "contract#getOrdersBatchDelivery",
  async ({ contract }: { contract: Ecommerce }) => {
    return await updateOrdersDelivery(contract);
  }
);
export const updateDeliveryInfo = createAsyncThunk(
  "contract#getDelivery",
  async ({ contract }: { contract: Ecommerce }) => {
    return await updateDelivery(contract);
  }
);
// export const cancelDeliveryOrder = createAsyncThunk(
//   "contract#cancelOrderDelivery",
//   async ({ contract, order }: { contract: Ecommerce; order: OrderI }) => {
//     // console.log(comission);
//     const comission = utils.parseEther("0.5");
//     return await cancelOrderCustomer({
//       contract,
//       order,
//       comission,
//     });
//   }
// );
// export const getDeliveryOrderItems = createAsyncThunk(
//   "contract#getItemsBatch",
//   async ({ contract, order }: { contract: Ecommerce; order: OrderI }) => {
//     return await updateOrderItems(contract, order);
//   }
// );
const initialState = {
  /* OrderIExt */
  orders: <{ orders: OrderI[]; status: status }>{
    orders: [],
    status: "pending",
  },
  customer: <{ delivery: DeliveryI | undefined; status: status }>{
    delivery: undefined,
    status: "pending",
  },
};
const slice = createSlice({
  name: "delivery",
  initialState,
  reducers: {},

  extraReducers: (builder) => {
    /**
     * @dev updateCustomerOrders
     */
    builder.addCase(updateDeliveryOrders.pending, (state) => {
      state.orders = { ...state.orders, status: "pending" };
    });
    builder.addCase(updateDeliveryOrders.rejected, (state) => {
      state.orders = { orders: [], status: "failure" };
    });
    builder.addCase(updateDeliveryOrders.fulfilled, (state, action) => {
      state.orders = { orders: action.payload, status: "success" };
    });
    /**
     * @dev updateCustomerInfo
     */
    builder.addCase(updateDeliveryInfo.fulfilled, (state, action) => {
      state.customer = { delivery: action.payload, status: "success" };
    });
    builder.addCase(updateDeliveryInfo.pending, (state, action) => {
      state.customer = { ...state.customer, status: "pending" };
    });
    builder.addCase(updateDeliveryInfo.rejected, (state, action) => {
      state.customer = {
        delivery: undefined,
        status: "failure",
      };
    });
    /**
     * @dev cancelOrders and updatePurchases
     */
    // builder.addCase(cancelDeliveryOrder.pending, (state) => {
    //   state.orders = { ...state.orders, status: "pending" };
    // });
    // builder.addCase(cancelDeliveryOrder.rejected, (state, action) => {
    //   state.orders = { ...state.orders, status: "failure" };
    // });
    // builder.addCase(cancelDeliveryOrder.fulfilled, (state, action) => {
    //   console.log(action.payload);
    //   state.orders = { orders: action.payload, status: "success" };
    // });
  },
});

export default slice.reducer;
// export const { setOrders, setCustomer } = slice.actions;
