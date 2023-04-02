// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract MyContract{
    //uint ---> no minus value

    //State Variables(8-256bits)
    //stores inside blockchain
    uint public myUint = 1; 
    uint256 public myUint256  = 1;  //exact same to upper 
    uint8 public myUint8  = 2; //smaller uints


    //int ---> can be minus value
    int public myInt=0; 
    int256 public myInt256  = 1;  //exact same to upper 
    int8 public myInt8  =2; //smaller uints

    // string
    string public myString  = "Hello, world!";
    bytes32 public myBytes32 = "Hello, world!";//--> treats like an array and have flexibility to access indexes normal string dont have this flexibility
    
    //Adress
    address public myAddress =0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    //Custom Data types
    struct MyStruct{
        uint myUint256;
        string myString;
    }
    MyStruct public obj = MyStruct(100,"Hello g");


    //Local Variables
    function getValue() public pure returns(uint){
        uint value =1;
        return value;
    }
}