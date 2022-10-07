var Web3HttpProvider = require('web3-providers-http');
var Web3WsProvider = require('web3-providers-ws');
var Web3 = require('web3');
var http = require('http');

var options = {
  keepAlive: true,
  withCredential: false,
  timeout: 20000,
  headers: [
    {
      name: 'Access-Control-Allow-Origin',
      value: '*',
    },
  ],
  agent: http.Agent(),
  baseUrl: '',
};

var provider = new Web3HttpProvider('http://localhost:8545', options);

// ====
// Http
// ====

var options = {
  timeout: 30000,
  headers: {
    authorization: 'Basic username:password',
  },
  clientConfig: {
    maxReceivedFrameSize: 100000000,
    maxReceivedMessageSize: 100000000,
    keepalive: true,
    keepaliveInterval: 60000,
  },

  // Enable auto reconnection
  reconnect: {
    auto: true,
    delay: 5000,
    maxAttempts: 5,
    onTimeout: false,
  },
};

var ws = new Web3WsProvider('ws://localhost:8546', options);

const initialFn = () => {
  const web3 = new Web3('http://localhost:8545');
  web3.setProvider('http://localhost:8545');
  const contract = new web3.eth.Contract('abi', 'address');
};
