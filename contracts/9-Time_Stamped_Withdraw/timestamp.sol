// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TimeLapse {
    address payable public owner;
    uint public releaseTime;
    
    constructor(uint year, uint month, uint day, uint hour, uint minute, uint second) payable {
        require(msg.value >= 0.1 ether, "Contract requires at least 0.1 ether to be deployed.");
        // Constructor can receive funds at deployment time
        owner = payable(msg.sender);
        releaseTime = toTimestamp(year, month, day, hour, minute, second);
    }
    
    function toTimestamp(uint year, uint month, uint day, uint hour, uint minute, uint second) public pure returns (uint timestamp) {
        // Calculate the Unix timestamp for the given date and time
        require(year >= 1970, "Year must be 1970 or later");
        require(month >= 1 && month <= 12, "Month must be between 1 and 12");
        require(day >= 1 && day <= 31, "Day must be between 1 and 31");
        require(hour >= 0 && hour <= 23, "Hour must be between 0 and 23");
        require(minute >= 0 && minute <= 59, "Minute must be between 0 and 59");
        require(second >= 0 && second <= 59, "Second must be between 0 and 59");
        timestamp = uint(keccak256(abi.encodePacked(year, month, day, hour, minute, second)));
    }
    
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
    
    function withdraw(address payable recipient, uint256 amount) public onlyOwner {
        require(block.timestamp >= releaseTime, "Withdrawals not yet allowed");
        require(address(this).balance >= amount, "Not enough funds in the contract");
        require(recipient != address(0), "Invalid recipient address");
        recipient.transfer(amount);
    }
    
    modifier onlyOwner {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }
    
}
