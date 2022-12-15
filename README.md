
## Quick start
cd hardhat-boilerplate
npm install
```
We can run the frontend with:


cd frontend
npm install
npm start
```

Open [http://localhost:3000/](http://localhost:3000/) to see your Dapp. You will
need to have [Metamask](https://metamask.io) installed and listening to
`Goerli network`.

The smart contracts are already deployed to the goerli network and the address are located in the contract-addresses file in the contracts subfolder of the frontend.
The smart contract supports deposits in both usdc as well as eth. 
NOTE: I have used a standard erc20 contract in the place of usdc to demonstrate the usage. In order to get the correct price, we can include a chainlink oracle to get the price of eth to usd.
The frontend has only been coded to support eth deposits.