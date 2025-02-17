const ERC20Token = artifacts.require("./ERC20Token.sol");
const SupplyChain = artifacts.require("./SupplyChain.sol");
const HelloWorld = artifacts.require("./HelloWorld.sol");

module.exports = function(deployer) {
    deployer.deploy(HelloWorld);
    deployer.deploy(ERC20Token, 'Token test', '$', 18, 10020);
    deployer.deploy(SupplyChain);
}
