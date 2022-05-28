import { configureStore, combineReducers } from "@reduxjs/toolkit";
import walletReducer from "./walletReducer";
import { TypedUseSelectorHook, useDispatch, useSelector } from "react-redux";
import customerReducer from "./customerReducer";
import deliveryReducer from "./deliveryReducer";

const rootReducer = combineReducers({
  walletReducer,
  customerReducer,
  deliveryReducer,
});
export const store = configureStore({
  reducer: rootReducer,
  // devTools: true,
  middleware: (getDefaultMiddleware) =>
    getDefaultMiddleware({ serializableCheck: false }),
});

// Infer the `RootState` and `AppDispatch` types from the store itself
export type RootState = ReturnType<typeof store.getState>;
// Inferred type: {posts: PostsState, comments: CommentsState, users: UsersState}
export type AppDispatch = typeof store.dispatch;
export type StatusT = "success" | "pending" | "failure";
// Use throughout your app instead of plain `useDispatch` and `useSelector`
export const useAppDispatch = () => useDispatch<AppDispatch>();
export const useAppSelector: TypedUseSelectorHook<RootState> = useSelector;
