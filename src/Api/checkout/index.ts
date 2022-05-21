import axios from "axios";
const instance = axios.create({ baseURL: "http://localhost:3002/checkout" });
export const GetCheckoutInfo = async (sessionId: string) => {
  return (
    await instance.post("/getinfo", {
      sessionId,
    })
  ).data as {
    address: string;
    deliveryId: string;
    shopId: string;
    tokenIds: string[];
  };
};
