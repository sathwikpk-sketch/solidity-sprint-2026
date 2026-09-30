import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

export default buildModule("SWKTokenModule", (m) => {
  const initialSupply = m.getParameter("initialSupply", 1000);
  const token = m.contract("SWKToken", [initialSupply]);
  return { token };
});
