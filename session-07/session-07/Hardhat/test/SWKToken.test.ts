import { expect } from "chai";
import { ethers } from "hardhat";

describe("SWKToken", function () {
  async function deploy() {
    const [owner, addr1] = await ethers.getSigners();
    const Token = await ethers.getContractFactory("SWKToken");
    const token = await Token.deploy(1000);
    return { token, owner, addr1 };
  }

  it("should transfer tokens between accounts", async function () {
    const { token, owner, addr1 } = await deploy();
    await token.transfer(addr1.address, ethers.parseUnits("100", 18));
    expect(await token.balanceOf(addr1.address)).to.equal(
      ethers.parseUnits("100", 18)
    );
  });

  it("should revert transfer if balance is insufficient", async function () {
    const { token, addr1 } = await deploy();
    await expect(
      token.connect(addr1).transfer(addr1.address, ethers.parseUnits("100", 18))
    ).to.be.revertedWithCustomError(token, "ERC20InsufficientBalance");
  });

  it("should revert mint if caller is not owner", async function () {
    const { token, addr1 } = await deploy();
    await expect(
      token.connect(addr1).mint(addr1.address, 100)
    ).to.be.revertedWithCustomError(token, "OwnableUnauthorizedAccount");
  });

  it("should allow owner to mint tokens", async function () {
    const { token, owner, addr1 } = await deploy();
    await token.mint(addr1.address, 100);
    expect(await token.balanceOf(addr1.address)).to.equal(
      ethers.parseUnits("100", 18)
    );
  });
});
