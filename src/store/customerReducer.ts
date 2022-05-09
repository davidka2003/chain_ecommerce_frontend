import { createAsyncThunk, createSlice, PayloadAction } from "@reduxjs/toolkit";
import { BigNumber, Contract, ethers } from "ethers";
import {
  cancelOrder,
  updateCustomer,
  updatePurchases,
} from "../ContractApi/customerApi";
import { ChainEcommerce } from "../typechain";
export type status = "success" | "pending" | "failure";
export interface OrderI {
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
}
export interface CustomerI {
  title: string;
  shops: BigNumber[];
  metaUri: string;
}

export const updateCustomerPurchases = createAsyncThunk(
  "contract#getCustomerPurchases",
  async ({ contract }: { contract: ChainEcommerce }) => {
    return await updatePurchases(contract);
  }
);
export const updateCustomerInfo = createAsyncThunk(
  "contract#getCustomer",
  async ({ contract }: { contract: ChainEcommerce }) => {
    return await updateCustomer(contract);
  }
);
export const cancelCustomerItems = createAsyncThunk(
  "contract#cancelItems",
  async ({
    contract,
    shopId,
    orderIds,
    comission,
  }: {
    contract: ChainEcommerce;
    orderIds: BigNumber[];
    shopId: BigNumber;
    comission: BigNumber;
  }) => {
    // console.log(comission);
    return await cancelOrder({
      contract,
      orderIds,
      shopId,
      comission,
    });
  }
);
const initialState = {
  orders: <{ orders: OrderI[]; status: status }>{
    orders: [],
    status: "pending",
  },
  customer: <{ customer: CustomerI; status: status }>{
    customer: { title: "Customer", shops: [], metaUri: "defaultMetaUri" },
    status: "pending",
  },
};
const slice = createSlice({
  name: "customer",
  initialState,
  reducers: {
    setOrders(state, action: PayloadAction<OrderI[]>) {
      /* delete non indexed */
      state.orders = { orders: action.payload, status: "success" };
    },
    setCustomer(state, action: PayloadAction<any>) {
      state.customer = action.payload;
    },
  },
  extraReducers: (builder) => {
    /**
     * @dev updateCustomerPurchases
     */
    builder.addCase(updateCustomerPurchases.pending, (state) => {
      state.orders = { ...state.orders, status: "pending" };
    });
    builder.addCase(updateCustomerPurchases.rejected, (state, action) => {
      state.orders = { orders: [], status: "failure" };
    });
    builder.addCase(updateCustomerPurchases.fulfilled, (state, action) => {
      state.orders = { orders: action.payload, status: "success" };
    });
    /**
     * @dev updateCustomerInfo
     */
    builder.addCase(updateCustomerInfo.fulfilled, (state, action) => {
      state.customer = { customer: action.payload, status: "success" };
    });
    builder.addCase(updateCustomerInfo.pending, (state, action) => {
      state.customer = { ...state.customer, status: "pending" };
    });
    builder.addCase(updateCustomerInfo.rejected, (state, action) => {
      state.customer = {
        customer: { title: "Customer", shops: [], metaUri: "defaultMetaUri" },
        status: "failure",
      };
    });
    /**
     * @dev cancelOrders and updatePurchases
     */
    builder.addCase(cancelCustomerItems.pending, (state) => {
      state.orders = { ...state.orders, status: "pending" };
    });
    builder.addCase(cancelCustomerItems.rejected, (state, action) => {
      state.orders = { ...state.orders, status: "failure" };
    });
    builder.addCase(cancelCustomerItems.fulfilled, (state, action) => {
      console.log(action.payload);
      state.orders = { orders: action.payload, status: "success" };
    });
  },
});

export default slice.reducer;
export const { setOrders, setCustomer } = slice.actions;
