// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BalanceChecker {
    function getBalance(address _address) public view returns (uint256) {
        uint256 balanceInWei = address(_address).balance;
        uint256 balanceInEth = balanceInWei / 1 ether; // convert from wei to ether
        return balanceInEth;
    }
}
