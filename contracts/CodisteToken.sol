pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract CodisteToken is ERC20 {
    constructor(uint256 _totalSupp) ERC20("Codeste Coin", "CDST") {
        _mint(msg.sender, _totalSupp);
        admin = msg.sender;
    }

    address admin;

    function transfer(address recipient, uint256 amount)
        public
        override
        returns (bool)
    {
        address liquidityPoolAddress =
            0xba5Ba9f68540bdd53444A23C6633f225cdA8329e;
        address burnAccountAddress = 0xd01aE4320d60Af396B307f9864Ab3ba37d396239;

        uint256 liquidityTax = (100 * amount * 4) / 10000;
        _transfer(msg.sender, liquidityPoolAddress, liquidityTax);
        uint256 burnTax = (100 * amount * 2) / 10000;
        _transfer(msg.sender, burnAccountAddress, burnTax);
        uint256 adminTax = (100 * amount * 1) / 10000;
        _transfer(msg.sender, admin, adminTax);
        uint256 remainingAmountAfterTax = (100 * amount * 93) / 10000;
        _transfer(msg.sender, recipient, remainingAmountAfterTax);

        return true;
    }
}
