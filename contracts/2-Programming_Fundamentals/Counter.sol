// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Counter{

    uint public count=0;  //state variable --->stores inside blockchain
                // no minus sign uint main


    //How to use constructor
    // constructor() public{
    //     count =0;
    // }



    // //this function is free
    // function getCount() public view returns (uint) {
    //     return count;
    // }
    //This function has no need when we put public to our variable 


    //this function needs gas
    function addCount() public{
        count += 1;
    }
}
