require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */

const ALCHEMY_API_KEY = "t4DjVHNgj2_77ydUejLmnHd9ZwVd3Ot9";
const GOERLI_PRIVATE_KEY = "22f996fb6d18bbd18905ef3989e79133bc6314be794d8f45bc94157d3658fbf7";
module.exports = {
  solidity: {
    version: "0.8.19",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      },
      viaIR: true,
    }
  },
  networks: {
    goerli:{
      url:`https://eth-goerli.g.alchemy.com/v2/${ALCHEMY_API_KEY}`,
      accounts:[`${GOERLI_PRIVATE_KEY}`],
    }
  }
};
