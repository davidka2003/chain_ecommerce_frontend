import { createAsyncThunk, createSlice, PayloadAction } from "@reduxjs/toolkit";
import { BigNumber, Contract, ethers } from "ethers";
import { string } from "hardhat/internal/core/params/argumentTypes";
import {
  CustomerI,
  DeliveryI,
  RoleT,
  ShopI,
} from "../ContractApi/contractTypes";
import { updateCustomer } from "../ContractApi/customerApi";
import { updateDelivery } from "../ContractApi/deliveryApi";
import { updateShop } from "../ContractApi/shopApi";
import { Ecommerce } from "../typechain/Ecommerce";
import { StatusT } from "./store";

export const updateRoleInfo = createAsyncThunk(
  "contract#getRoleInfo",
  async ({ contract, role }: { contract: Ecommerce; role: RoleT }) => {
    switch (role) {
      // case "shop":
      case "customer":
        return await updateCustomer(contract);
      case "delivery":
        return await updateDelivery(contract);
      case "shop":
        return await updateShop(contract);
    }
  }
);

const initialState = {
  address: "",
  balance: "0",
  struct: <
    { struct: (DeliveryI | CustomerI | ShopI) | undefined; status: StatusT }
  >{
    struct: undefined,
    status: "pending",
  },
};
const slice = createSlice({
  name: "wallet",
  initialState,
  reducers: {
    setBalance(state: typeof initialState, action: PayloadAction<BigNumber>) {
      state.balance = ethers.utils.formatEther(action.payload);
    },
    setAddress(state: typeof initialState, action: PayloadAction<string>) {
      state.address = action.payload;
    },
  },
  extraReducers(builder) {
    builder.addCase(updateRoleInfo.fulfilled, (state, action) => {
      state.struct = { struct: action.payload, status: "success" };
    }),
      builder.addCase(updateRoleInfo.pending, (state, action) => {
        state.struct = { ...state.struct, status: "pending" };
      }),
      builder.addCase(updateRoleInfo.rejected, (state, action) => {
        state.struct = { struct: undefined, status: "failure" };
      });
  },
});

export default slice.reducer;
export const { setBalance, setAddress } = slice.actions;
