import { Contract, ethers } from "ethers";
import React, {
  createContext,
  useContext,
  useState,
  useEffect,
  Context,
} from "react";
// import { CHAIN_ID } from "../App";
import contractAddress from "../.env/contract-address.json";
import CHAIN_ECOMMERCE from "../artifacts/contracts/CHAIN_ECOMMERCE.sol/CHAIN_ECOMMERCE.json";
const CHAIN_ID = 31337;

interface WalletContextI {
  provider: ethers.providers.Web3Provider | undefined;
  signer: ethers.providers.JsonRpcSigner | undefined;
  contract: Contract | undefined;
}
export const WalletContext = createContext<{
  provider: ethers.providers.Web3Provider | undefined;
  signer: ethers.providers.JsonRpcSigner | undefined;
  contract: Contract | undefined;
  // connected: boolean;
  // setConnected: React.Dispatch<React.SetStateAction<boolean>> | undefined;
}>({
  provider: undefined,
  signer: undefined,
  contract: undefined,
  // connected: false,
  // setConnected: undefined,
});

const getProvider = () => {
  const { ethereum } = window;
  if (ethereum && ethereum.isMetaMask) {
    const provider = new ethers.providers.Web3Provider(
      /* @ts-ignore */
      window.ethereum,
      { chainId: CHAIN_ID, name: "localhost" }
    );
    return provider;
  }
  throw new Error("Metamask is not installed");
};
const getSigner = (provider?: ethers.providers.Web3Provider) =>
  (provider || getProvider()).getSigner();

const getContract = (signer?: ethers.providers.JsonRpcSigner) => {
  return new ethers.Contract(
    contractAddress.address,
    CHAIN_ECOMMERCE.abi,
    signer || getSigner()
  );
};

const WalletProvider = ({ children }: { children: JSX.Element }) => {
  const [provider, setProvider] = useState(getProvider());
  const [signer, setSigner] = useState(getSigner(provider));
  const [contract, setContract] = useState(getContract(signer));
  useEffect(() => {
    const init = async () => {
      // console.log("Wallet provider init");
      const provider = getProvider();
      window.ethereum.on("accountsChanged", () => {
        // console.log(provider);
        const signer = getSigner(provider);
        setSigner(signer);
        setContract(getContract(signer));
        // console.log("accountsChanged");
      });
      provider.on("network", (newNetwork, oldNetwork) => {
        // console.log("network changed");
        oldNetwork && window.location.reload();
      });
      /* @ts-ignore */
      window.ethereum.on("chainChanged", () => window.location.reload());
    };
    init();
  }, []);

  return (
    <WalletContext.Provider value={{ provider, signer, contract }}>
      {children}
    </WalletContext.Provider>
  );
};

export default WalletProvider;

declare global {
  interface Window {
    ethereum?: any;
  }
}
//   "any"
