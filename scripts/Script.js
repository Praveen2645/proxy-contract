const {ethers,upgrades} = require("hardhat");


async function main() {

  //const Box = await ethers.getContractFactory("Box");

  /*const box = await upgrades.deployProxy(Box, [42], {
    initializer: "initialize",
  });*/

const stake = await ethers.getContractFactory("Staking");
console.log("Deploying staking contract...");
//const lock = await upgrades.deployProxy("0xf92827b75548789f90F80bf490Bf00b4DBaACFd1", /{ value: lockedAmount }/ 10000000000);
// const lock =await upgrades.deployProxy(pool, ["0xA8777b29b931cbD77d8d05D876D0441CcDCE7ebb"],{
//   initializer: "initialize",
//   gasLimit: 3000000,
// });
const contract = await upgrades.deployProxy(stake);

await contract.waitForDeployment();


//const proxy = await upgrades.deployProxy(pool, ["0xA8777b29b931cbD77d8d05D876D0441CcDCE7ebb"]);
//await proxy.deployed();

}
main();