// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//some one books hotel rooms pay with eether and open the room
contract HotelRoom{

    // Ether pyments
    // Visibility
    // Events
 

    address payable public owner;    //------> payable is the modifier which can receive the crypto currency in it
    enum Statuses {Vacant,Occupied} //------> enum data structure inside solidity vacant =0, ovvupied = 1
    Statuses public currentStatus;
    
    // ============ Events ================
    // Helps us to push notifications if someone booked a room 
    // Helps us to track the history
    event Occupy(address _occupant, uint _value);
    //---> who occupied , how much price he/she paid


    
    constructor (){
        owner = payable(msg.sender); //-----> who is calling this function
        currentStatus = Statuses.Vacant;
    }

    modifier onlyWhileVacant{
        //-------> Room Khali hay k occupied ?
        require (currentStatus == Statuses.Vacant,"Currently Occupied");
        //-------> Built in function helps us to terminates the current working function if answer is false 
        //-------> Agr pahlay say book hay agay walay lines execute nahi hongay
        //-------> Print Message Currently occupied

        _;//---> returns function ------>kese or function k sath ma use kr sktay hain

    }

    modifier onlyHaveEnoughMoney(uint _amount){
        //-------> sab say phlay paisay check kray ga k hay bhi k nahi?
        require(msg.value >= _amount,"Not enough ether provided");
        //-------> Built in function helps us to terminates the current working function if answer is false 
        //-------> Agr pahlay say book hay agay walay lines execute nahi hongay
        //-------> Print Message paisay hani

        _;
    }

    function book() public payable onlyHaveEnoughMoney(2 ether) onlyWhileVacant{

      

      

        

        //-----> sab sa phlay owenr ko pay kro
        // owner.transfer(msg.value); // --> 1st method to accept money
        //-----> 2nd Method
        (bool sent, bytes memory data) = owner.call{value: msg.value}("Koi b msg dal do yahan");
        require(true);


        currentStatus = Statuses.Occupied;
        emit Occupy(msg.sender,msg.value);


    }
    
}