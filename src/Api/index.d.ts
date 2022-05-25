export type checkoutInfoT = {
  shop_sid: string;
  shopId: string;
  checkout_hash: string;
  // address: string;add it later
  tokenIds: string[];
  deliveryId: string;
  destination: [string, string];
};
