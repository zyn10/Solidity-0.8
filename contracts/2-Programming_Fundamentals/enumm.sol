//particular number integer ko name assign krtay hain jab ham
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract enammmm {

    enum user{allowed,not_allowed,wait}
    user public u1= user.wait;

    function owner() public{
        if(u1==user.wait){
            u1=user.allowed;
        }
    }
}




