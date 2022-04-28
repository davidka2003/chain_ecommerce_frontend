import { createSlice, PayloadAction } from "@reduxjs/toolkit";
import { Contract, ethers } from "ethers";
const initialState = {
  address: <string>"",
  balance: "0",
  connected: false,
};
const slice = createSlice({
  name: "wallet",
  initialState,
  reducers: {
    setBalance(state, action: PayloadAction<ethers.BigNumberish>) {
      state.balance = ethers.utils.formatEther(action.payload);
    },
    setAddress(state, action: PayloadAction<string>) {
      state.address = action.payload;
    },
    setConnected(state, action: PayloadAction<boolean>) {
      state.connected = action.payload;
    },
  },
});

export default slice.reducer;
export const { setBalance, setAddress, setConnected } = slice.actions;
