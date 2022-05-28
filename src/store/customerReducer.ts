import { createAsyncThunk, createSlice, PayloadAction } from "@reduxjs/toolkit";
import { BigNumber, Contract, ethers, utils } from "ethers";
import { OrderIExt } from ".";
import { CustomerI, ItemI, OrderI } from "../ContractApi/contractTypes";
import {
  cancelOrderCustomer,
  updateCustomer,
  updateOrderItems,
  updateOrders,
} from "../ContractApi/customerApi";
import { Ecommerce } from "../typechain";
import { StatusT } from "./store";
/** @dev add limit later  */
export const updateCustomerOrders = createAsyncThunk(
  "contract#getOrdersBatch",
  async ({ contract }: { contract: Ecommerce }) => {
    return await updateOrders(contract);
  }
);
// export const updateCustomerInfo = createAsyncThunk(
//   "contract#getCustomer",
//   async ({ contract }: { contract: Ecommerce }) => {
//     return await updateCustomer(contract);
//   }
// );
export const cancelOrder = createAsyncThunk(
  "contract#cancelOrder",
  async ({ contract, order }: { contract: Ecommerce; order: OrderI }) => {
    // console.log(comission);
    const comission = utils.parseEther("0.5");
    return await cancelOrderCustomer({
      contract,
      order,
      comission,
    });
  }
);
export const getOrderItems = createAsyncThunk(
  "contract#getItemsBatch",
  async ({ contract, order }: { contract: Ecommerce; order: OrderI }) => {
    return await updateOrderItems(contract, order);
  }
);
const initialState = {
  orders: <{ orders: OrderIExt[]; status: StatusT }>{
    orders: [],
    status: "pending",
  },
  customer: <{ customer: CustomerI | undefined; status: StatusT }>{
    customer: undefined,
    status: "pending",
  },
};
const slice = createSlice({
  name: "customer",
  initialState,
  reducers: {},

  extraReducers: (builder) => {
    /**
     * @dev updateCustomerOrders
     */
    builder.addCase(updateCustomerOrders.pending, (state) => {
      state.orders = { ...state.orders, status: "pending" };
    });
    builder.addCase(updateCustomerOrders.rejected, (state) => {
      state.orders = { orders: [], status: "failure" };
    });
    builder.addCase(updateCustomerOrders.fulfilled, (state, action) => {
      state.orders = { orders: action.payload, status: "success" };
    });
    // /**
    //  * @dev updateCustomerInfo
    //  */
    // builder.addCase(updateCustomerInfo.fulfilled, (state, action) => {
    //   state.customer = { customer: action.payload, status: "success" };
    // });
    // builder.addCase(updateCustomerInfo.pending, (state, action) => {
    //   state.customer = { ...state.customer, status: "pending" };
    // });
    // builder.addCase(updateCustomerInfo.rejected, (state, action) => {
    //   state.customer = {
    //     customer: undefined,
    //     status: "failure",
    //   };
    // });
    /**
     * @dev cancelOrders and updatePurchases
     */
    builder.addCase(cancelOrder.pending, (state) => {
      state.orders = { ...state.orders, status: "pending" };
    });
    builder.addCase(cancelOrder.rejected, (state, action) => {
      state.orders = { ...state.orders, status: "failure" };
    });
    builder.addCase(cancelOrder.fulfilled, (state, action) => {
      console.log(action.payload);
      state.orders = { orders: action.payload, status: "success" };
    });
  },
});

export default slice.reducer;
// export const { setOrders, setCustomer } = slice.actions;
