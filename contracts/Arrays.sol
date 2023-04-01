// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Arrays{
    // sorted groupings  
    uint[] public uintArray = [1,2,3];
    string [] public stringArray = ["apple", "banana", "carrot"];
    string [] public values;//---> Empty Value
//2D array
uint[][] public array2D =[[1,2,3],[4,5,6]];

    function addValue(string memory _value) public{
        values.push(_value);//--> adds the value at the last of the array
    }

    //return the length of the array
    function valueCount() public view returns (uint){
        return values.length;
    }
}