require("@nomicfoundation/hardhat-toolbox");
require('@openzeppelin/hardhat-upgrades');

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.19",
};
require("@nomicfoundation/hardhat-toolbox");
require('@openzeppelin/hardhat-upgrades');
require("@nomicfoundation/hardhat-verify");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: { compilers: [{ version: "0.8.18", },{ version: "0.8.19", }, { version: "0.6.0", }, { version: "0.7.0", settings: {}, }], },
  networks: {
    sepolia: {
      url :`https://eth-sepolia.g.alchemy.com/v2/HrBxV26BnmjYvLp07LSC5yCNBKGp2dmM`,
      accounts: ["e2209f39c21175dd84dbb96cef5021981fd542599d7804c36d304d974308e627"],
    },
  },
  etherscan : {
    apiKey: "WEHA6UZFQK5ENYHP1FXJXR6BJT72NZBDHD",
  }

};