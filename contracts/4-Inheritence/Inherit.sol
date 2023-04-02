// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Ownable {
    address owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "must be owner");
        _;
    }

    constructor()  {
        owner = msg.sender;
    }
}
contract SecretVault {

    string secret;

    constructor(string memory _secret)  {
        secret = _secret;
    }

    function getSecret() public view returns (string memory) {
        return secret;
    }
}
//----> secret vault
//----> factory is a smart contract that creates other smart contracts

contract Inheritence_Contract is Ownable {
    address newSecretVault;
    constructor(string memory _secret)  {
        SecretVault localVariable = new SecretVault(_secret);
        newSecretVault = address(localVariable);
        super; //---> this will call parent constructor here
    }
    function getSecret() public view onlyOwner returns (string memory) {
        return SecretVault(newSecretVault).getSecret();
        //calling another smart contract with in other smart contract

    }
}
