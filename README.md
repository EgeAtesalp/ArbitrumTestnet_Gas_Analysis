# Arbitrum Quickstart and Cost Analysis

Arbitrum is an L2 scaling solution for **Ethereum** developed by **Offchain Labs**. Using the **Optimistic Rollup** model, Arbitrum offers a variety of benefits, such as:

- **Minimum Cost**: Lower gas costs for many different transactions
- **Compatibility**: Fully compatible with EVM, no code modification needed 
- **Security**: Security is rooted in L1 and any one party can ensure the correct L2 results
- **Scalability**: By moving a big portion of contracts computation and storage off chain, much higher throughput is allowed in the chain



# Testnet Quickstart

Arbitum website https://developer.offchainlabs.com/docs/public_testnet provides a very well documented guide on how access their public testnet. Step by step instruction can be found below:

- In the Metamask browser interface, connect to the Arbitum Testnet using custom RPC network option with the following information:
 ![Metamask Configuration](/metamask.png)
- To be able to transact with the chain,some amount of ETH will be required. Faucets such as [https://faucet.rinkeby.io/](https://faucet.rinkeby.io/) can provide the neccessary ETH in the testnet to start experimenting.
- To send ETH or any other tokens to the L2 Testnet, visit [https://bridge.arbitrum.io](https://bridge.arbitrum.io/). and simply choose the preffered amount of token to transfer. This  transfer requires a minimal gas fee.
- Now you are able to experiment in the Arbitrum Testnet. Different transactions in the L2 can be observed and inspected using https://explorer.arbitrum.io/.

# Deploying your first Smart Contract in Arbitrum L2

Deploying a Smart Contract in the Abritrum Rinkeby Testnet is quite easy and intuitive. Since deployment requires some amount of ETH as fee, it is adviced to first have an account with some ETH in the L2 by following the steps above. For more information, check out https://developer.offchainlabs.com/docs/contract_deployment

- Create a smart contract project that you would like to deploy to the L2. For this guide, I have chosen to deploy a very simple HelloWorld contract, using Hardhat. The contract and the config files can be found in this repository. 
contracts/MyContract.sol
```
pragma  solidity 0.8.5;

contract  MyContract {
	string  public hello;

	constructor(){
		hello = "Hello World!";
	} 
	function  setHello(string  memory  _hello) public{
		hello = _hello;
	}
}
```
- Crucially, add the following lines to the hardhat.config.js file.
```
require("@nomiclabs/hardhat-waffle");

const fs = require('fs');
const mnemonic fs.readFileSync(".secret").toString().trim();

module.exports = {
  solidity: "0.8.5",
  networks: {
    arbitrum: {
      url: `https://rinkeby.arbitrum.io/rpc`,
      gasPrice: 0,
      accounts: {mnemonic: mnemonic},
   }
  },
};
```

- Create a .secret file in the repository containing the secret recovery phrases (private key can also be utilized) from your Metamask account. The secret recovery phrases can be accessed from Settings/Security & Privacy tab. (For security sake, the .secret file does not exist in the public repository.)
- Deploying also requires a specific script file. An example can be found below : 
scripts/sample-script.js 
```
const hre = require("hardhat");

async function main() {
  const MyContract = await hre.ethers.getContractFactory("MyContract");
  const my_contract = await MyContract.deploy();

  await my_contract.deployed();

  console.log("MyContract deployed to:", my_contract.address);
}
main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
```
- Your code is ready! To deploy and interact with the contract, enter the following lines from the repository.

```
npx hardhat run --network arbitrum scripts/sample script.js

npx hardhat console --network arbitrum
```
This first line will return  the account address in which the contract was deployed.
```
MyContract deployed to: 0x69E7eC5784d2c566F581acACf09567044FA14555
```
Following lines within the console allows you to interact with the smart contract. 
```
const MyContract = await ethers.getContractFactory("MyContract")
const my_contract = await MyContract.attach("0x69E7eC5784d2c566F581acACf09567044FA14555")
await my_contract.hello()
await my_contract.setHello("Hello again")
await my_contract.hello()
```
- If the deployment is successful, you should see a reply from the smart contract.

 ![Console](/console.png)

# Gas Analysis


# Related Documentations
