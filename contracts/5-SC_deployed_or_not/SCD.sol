// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ContractChecker {
    function isContract(address _addr) internal view returns (bool) 
    {
        uint256 size;
        assembly {  size := extcodesize(_addr) }
        return (size > 0);
    }
    function check(address _addr) public view returns (string memory) 
    {
        if (isContract(_addr)) 
        {
            return "Adress is a contract";
        } 
        else 
        {
             return "Adress is not a contract";
        }
    }
}