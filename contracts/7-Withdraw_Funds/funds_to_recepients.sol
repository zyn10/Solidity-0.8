// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Withdrawable {
    address payable public owner;
        constructor() payable {
        require(msg.value >= 0.1 ether, "Contract requires at least 0.1 ether to be deployed.");
        // Constructor can receive funds at deployment time
        owner = payable(msg.sender);
    }
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
    function withdraw(address payable recipient, uint256 amount) public onlyOwner {
        require(address(this).balance >= amount, "Not enough funds in the contract");
        require(recipient != address(0), "Invalid recipient address");
        recipient.transfer(amount);
    }    
    
    modifier onlyOwner {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }
    
}
