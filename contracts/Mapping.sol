// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Mapping{

    //more like database
    //mapping(key => value) names;
    mapping (uint => string) public names;
    
    constructor() {
        names[1]= "zain";
        names[2]= "chadda";
        names[3]= "bal";
        names[4]= "dani";
    }

    //for structs
    //structs works like databases when mapping
    mapping (uint => Book) public books;
    struct Book{
        string title;
        string author;
    }
    
    function addBook(uint _id,string memory _title, string memory _author) public {
        books[_id] = Book(_title,_author);
    }


    //nested mapings
    mapping(address => mapping (uint => Book) )public myBooks;

    function addMyBook(uint _id,string memory _title, string memory _author) public {
       //-->msg.sender is global variable in solidity 
       // it holds the value who holds the smart contract on the blockchain
       // holds the etherium address
        myBooks[msg.sender][_id] = Book(_title,_author);
    }
}