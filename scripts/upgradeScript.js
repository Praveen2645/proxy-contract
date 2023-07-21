const {ethers,upgrades} = require("hardhat");

const PROXY = "0xC3fFD938aAB0188c37543BF81f6dF9bA3916DE49" //upgradable proxy add

async function main() {

    const stakingV2 = await ethers.getContractFactory("StakingContractV2");
    await upgrades.upgradeProxy(PROXY, stakingV2);

}
main();