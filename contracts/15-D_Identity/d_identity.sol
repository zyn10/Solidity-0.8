// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//------> Decentralized Identity
contract DID
{
    //------> Struct ID
    struct Id
    {
        uint cnic;
        string user_name;
        string user_email;
        bool verified;//----> already verified or not
        bool exists;//------> Memeber Present in Database or not
        address owner;//----->address of the person calling the contract
    }


    //-----> State Variables
    mapping (uint => Id) public identities;
    uint public peopleCount;

    event IdCreated(uint indexed cnic_, address indexed owner, string Name, string Email);
    event IdVerfied(uint indexed cnic_);

    function createIdentity ( string memory name_ ,string memory email_ ) public returns (uint)
    { 
        require(bytes(name_).length > 0,"Name is required");
        require(bytes(email_).length > 0,"Email is required");
        
        uint  newId = peopleCount++;
        identities[newId] = Id(newId,name_, email_, false,true,msg.sender);
        
        emit IdCreated(newId,msg.sender,name_,email_);
        return newId;
    }
    
    function verifyIdentity (uint input) public
    { 
        require(identities[input].exists,"Identity doesnot Exists");
        require(identities[input].verified,"Already Verified");
        require(identities[input].owner == msg.sender,"You dont own the identity");

        identities[input].verified = true;
        emit IdVerfied(input);

    }
     function getIdentity (uint input) public view returns (string memory,string memory,bool )
    { 
        require(identities[input].exists,"Identity doesnot Exists");

        return (identities[input].user_name, identities[input].user_email, identities[input].verified);

    }


}