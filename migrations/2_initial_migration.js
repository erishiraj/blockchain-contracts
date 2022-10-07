const Demo = artifacts.require('demo');

module.exports = function (deployer) {
  deployer.deploy(Demo);
};
