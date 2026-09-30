import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

// RPC URL is a public endpoint so it's fine to hardcode.
// Private key is passed in as an env var at deploy time, never committed.
const SEPOLIA_RPC_URL = "https://ethereum-sepolia-rpc.publicnode.com";
const PRIVATE_KEY = process.env.PRIVATE_KEY || "";

const config: HardhatUserConfig = {
  solidity: "0.8.20",
  networks: {
    sepolia: {
      url: SEPOLIA_RPC_URL,
      accounts: PRIVATE_KEY ? [PRIVATE_KEY] : [],
    },
  },
};

export default config;
