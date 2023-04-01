// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LoopsAndConditions{

    uint[] public nums = [1,2,3,4,5,6,7,8,9,10];
    address public owner;
    constructor(){
        owner= msg.sender;
    }

    function isEven(uint _nums) public view returns (bool){
        if(_nums % 2 == 0){
            return true;
        }else{
            return false;
        }
    }

    function countEvenNums() public view returns(uint){
        uint count=0;

        for (uint i = 0; i<nums.length;i++){
            if(isEven(nums[i])){
                count++;
            }
        }
        return count;
    }


    //one liner to check if else
    function isOwner() public view returns (bool){
        return (msg.sender == owner);
    }
    

}