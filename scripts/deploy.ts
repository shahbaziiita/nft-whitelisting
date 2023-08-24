import { task } from "hardhat/config";

task("deploy").setAction(async function (_, { ethers, run }) {
  console.log("Start deploying");
  try {
    const NftWhitelistContractFactory = await ethers.getContractFactory(
      "NftWhitelistContract"
    );
    const NftWhitelistContract =
      await NftWhitelistContractFactory.deploy();
    await NftWhitelistContract.deployed();
    console.log(
      "NftWhitelistContract deployed to address:",
      NftWhitelistContract.address
    );
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
});