const Web3 = require('web3');
const solc = require('solc');
const fs = require('fs');

let web3 = new Web3(new Web3.providers.HttpProvider('HTTP://127.0.0.1:7545'));

let fileContent = fs.readFileSync('demo.sol').toString();

var input = {
  language: 'Solidity',
  sources: {
    'demo.sol': {
      content: fileContent,
    },
  },
  settings: {
    outputSelection: {
      '*': {
        '*': ['*'],
      },
    },
  },
};

var output = JSON.parse(solc.compile(JSON.stringify(input)));
// console.log(output);
ABI = output.contracts['demo.sol']['Demo'].abi;
bytecode = output.contracts['demo.sol']['Demo'].evm.bytecode.object;

// console.log('abi: ', ABI);
// console.log('bytecode: ', bytecode);

contract = new web3.eth.Contract(ABI);
let selectedAccount;
web3.eth.getAccounts().then((account) => {
  //console.log(account);
  selectedAccount = account[0];
  console.log('defaultAccount', selectedAccount);
  contract
    .deploy({ data: bytecode })
    .send({ from: selectedAccount, gas: 500000 })
    .on('receipt', (receipt) => {
      console.log('Contract address: ', receipt);
    })
    .then((demoContract) => {
      demoContract.methods.x().call((error, data) => {
        console.log('Initial values: ', data);
      });
    });
});
