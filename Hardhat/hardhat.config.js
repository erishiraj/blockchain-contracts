/** @type import('hardhat/config').HardhatUserConfig */
require('@nomiclabs/hardhat-waffle');

const ALCHEMY_API_KEY = '0iOSvsOKQyzY9crKwj_T64pDmyp71wYM';
const ROPSTEN_PRIVATE_KEY =
  '4138cd80c342c42778974eaf277df03a0fba650a34dd95068faa3e0f3f48f30b';
module.exports = {
  solidity: '0.8.17',
  networks: {
    ropsten: {
      url: `https://eth-goerli.g.alchemy.com/v2/0iOSvsOKQyzY9crKwj_T64pDmyp71wYM`,
      accounts: [`${ROPSTEN_PRIVATE_KEY}`],
    },
  },
};
