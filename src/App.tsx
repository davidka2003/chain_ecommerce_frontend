import React, { useEffect } from "react";
import logo from "./logo.svg";
import "./App.scss";
import { Route, Routes } from "react-router-dom";
import Header from "./components/Header/Header";
import Description from "./components/Description/Description";
import NotFoundPage from "./components/NotFoundPage/NotFoundPage";
import Dashboard from "./components/Dashboard/Dashboard";
import WalletProvider from "./hooks/WalletProvider";
// import { useWeb3Context } from "web3-react";
// https://www.npmjs.com/package/web3-react
function App() {
  return (
    <>
      <Header />
      <Routes>
        <Route path="/" element={<Description />}></Route>
        <Route
          path="/dashboard"
          element={
            <WalletProvider>
              <Dashboard />
            </WalletProvider>
          }
        ></Route>
        <Route path="*" element={<NotFoundPage />}></Route>
      </Routes>
    </>
  );
}

export default App;
