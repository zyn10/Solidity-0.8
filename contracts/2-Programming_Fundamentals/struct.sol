// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//we create our own data type using fundamental data types
//contract k andar bhi bna sktay hain contract k bahar bhi
//bahar bnanay ka faida ha k multiple contracts ma access krsktay hain

struct Student
{
    uint roll;
    string name;
}

contract School{
    Student  public obj_s;
    constructor(uint _roll, string memory _name){
        obj_s.roll=_roll;
        obj_s.name=_name;
    }

   
    function change (uint _roll, string memory _name) public
    {
        Student memory new_student = Student({
        roll:_roll,
        name:_name
    });
    obj_s=new_student;
    } 
    
}