// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CrowdSale {
    address public owner;
    uint public tokenPrice;
    uint public tokensSold;
    uint public tokenSupply;
    mapping(address => uint) public balanceOf;

    event Sold(address buyer, uint amount);

    constructor(uint _tokenPrice, uint _tokenSupply) {
        owner = msg.sender;
        tokenPrice = _tokenPrice;
        tokenSupply = _tokenSupply;
    }

    function buyTokens(uint _numberOfTokens) public payable {
        require(msg.value == _numberOfTokens * tokenPrice);
        require(tokensSold + _numberOfTokens <= tokenSupply);

        balanceOf[msg.sender] += _numberOfTokens;
        tokensSold += _numberOfTokens;

        emit Sold(msg.sender, _numberOfTokens);
    }

   function endSale() public {
    require(msg.sender == owner);
    address payable ownerPayable = payable(owner);
    ownerPayable.transfer(address(this).balance);
}


}
