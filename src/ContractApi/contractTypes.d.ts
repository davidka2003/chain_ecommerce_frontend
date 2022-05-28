import { BigNumber } from "ethers";
import { Ecommerce } from "../typechain";
export type OrderI = Awaited<ReturnType<Ecommerce["getOrdersBatch"]>>[0];
export type ShopI = Awaited<ReturnType<Ecommerce["getShop"]>>;
export type DeliveryI = Awaited<ReturnType<Ecommerce["getDelivery"]>>;
export type CustomerI = Awaited<ReturnType<Ecommerce["getCustomer"]>>;
export type ItemI = Awaited<ReturnType<Ecommerce["getItemsBatch"]>>[0];
export type RoleT = "shop" | "delivery" | "customer";
