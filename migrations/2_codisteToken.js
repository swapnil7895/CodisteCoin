const CodisteToken = artifacts.require("CodisteToken");

module.exports = function (deployer) {
    deployer.deploy(CodisteToken, '5000000000000000000000000');
};
