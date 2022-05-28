import React, { useEffect, useState } from "react";
import { isConnected } from "../../../hooks/isConnected";
import { useContract } from "../../../hooks/useContract";
import { useSigner } from "../../../hooks/useSigner";
import { useAppDispatch, useAppSelector } from "../../../store/store";
import { setAddress, setBalance } from "../../../store/walletReducer";

const CustomerCard = () => {
  return <div>CustomerCard</div>;
};

export default CustomerCard;
