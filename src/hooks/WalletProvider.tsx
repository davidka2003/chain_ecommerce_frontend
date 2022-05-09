import { Contract, ethers } from "ethers";
import React, {
  createContext,
  useContext,
  useState,
  useEffect,
  Context,
} from "react";
import { ChainEcommerce__factory, ChainEcommerce } from "../typechain";
// import { ChainEcommerce } from "../../typechain";
// import { CHAIN_ID } from "../App";
import contractAddress from "../.env/contract-address.json";
import CHAIN_ECOMMERCE from "../artifacts/contracts/Chain_ecommerce.sol/Chain_ecommerce.json";
const CHAIN_ID = 31337;

interface WalletContextI {
  provider: ethers.providers.Web3Provider | undefined;
  signer: ethers.providers.JsonRpcSigner | undefined;
  contract: ChainEcommerce | undefined;
}
export const WalletContext = createContext<{
  provider: ethers.providers.Web3Provider | undefined;
  signer: ethers.providers.JsonRpcSigner | undefined;
  contract: ChainEcommerce | undefined;
  connected: boolean;
  setConnected: React.Dispatch<React.SetStateAction<boolean>> | undefined;
  // connected: boolean;
  // setConnected: React.Dispatch<React.SetStateAction<boolean>> | undefined;
}>({
  provider: undefined,
  signer: undefined,
  contract: undefined,
  connected: false,
  setConnected: undefined,
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

const getContract = (
  /* provider?: ethers.providers.Web3Provider */ signer?: ethers.providers.JsonRpcSigner
) => {
  return new ethers.Contract(
    contractAddress.address,
    // provider || getProvider()
    CHAIN_ECOMMERCE.abi,
    signer || getSigner()
  ) as ChainEcommerce;
};

const WalletProvider = ({ children }: { children: JSX.Element }) => {
  const [provider, setProvider] = useState<WalletContextI["provider"]>();
  const [signer, setSigner] = useState<WalletContextI["signer"]>();
  const [contract, setContract] = useState<WalletContextI["contract"]>();
  const [connected, setConnected] = useState(false);
  // console.log(connected);
  useEffect(() => {
    const init = async () => {
      /* inialize default state on connected */
      const provider = getProvider();
      const signer = getSigner(provider);
      setProvider(provider);
      setSigner(signer);
      setContract(getContract(signer));
      window.ethereum.on("accountsChanged", () => {
        // console.log(provider);
        setProvider(provider);
        const signer = getSigner(provider);
        setSigner(signer);
        setContract(getContract(signer));
        // console.log("accountsChanged");
      });
      provider.on("network", (newNetwork, oldNetwork) => {
        // console.log("network changed");
        oldNetwork && window.location.reload();
      });
      window.ethereum.on("chainChanged", () => window.location.reload());
    };
    connected && init();
  }, [connected]);

  return (
    <WalletContext.Provider
      value={{ provider, signer, contract, connected, setConnected }}
    >
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
