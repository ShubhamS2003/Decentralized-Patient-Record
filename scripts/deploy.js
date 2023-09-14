const hre = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log(`Deploying contract with address: ${deployer.address}`);

  const Files = await hre.ethers.getContractFactory("Files"); // Replace with your contract name
  const files = await Files.deploy();

  await files.waitForDeployment();

  console.log("Contract deployed to:", files.target);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
