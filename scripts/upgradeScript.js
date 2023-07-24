const {ethers,upgrades} = require("hardhat");

const PROXY = "0xa245eaabca5caf8faac43eae3ffc519a7cb38929" //upgradable proxy add

async function main() {

    const stakingV2 = await ethers.getContractFactory("StakingV2");
    await upgrades.upgradeProxy(PROXY, stakingV2);

}
main();