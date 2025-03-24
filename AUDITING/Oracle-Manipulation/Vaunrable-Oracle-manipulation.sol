
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IPriceFeed {
    function getPrice() external view returns (uint256);
}

contract OracleVulnerable {
    IPriceFeed public priceFeed;
    mapping(address => uint256) public balances;
    
    constructor(address _priceFeed) {
        priceFeed = IPriceFeed(_priceFeed);
    }
    
    function swapTokens(uint256 amount) public {
        uint256 currentPrice = priceFeed.getPrice();
        uint256 tokensToReceive = amount * currentPrice;
        balances[msg.sender] += tokensToReceive;
    }
}
