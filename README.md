# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a script that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.js
```
# installation
librariess needed for upgradable proxy contract

commands:
```
npm init
npm install --save-dev hardhat
npm install --save-dev "hardhat@^2.17.0" "@nomicfoundation/hardhat-toolbox@^3.0.0"
npx install @openzeppelin/contracts
npm install @openzeppelin/contracts-upgradeable

```
# staking contract changements
```
convert libraries into ipgradable
remove state variables
remove constructor instead use initializer function

```