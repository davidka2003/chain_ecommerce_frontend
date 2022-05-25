import axios from "axios";
import { checkoutInfoT } from "..";
const instance = axios.create({ baseURL: "http://localhost:3002/checkout" });
export const GetCheckoutInfo = async (sessionId: string) => {
  return (
    await instance.post("/getinfo", {
      sessionId,
    })
  ).data as checkoutInfoT;
};
