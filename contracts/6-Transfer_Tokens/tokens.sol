// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract TokenTransfer {
    address public token;
    
    constructor(address _tokenAddress) {
        token = _tokenAddress;
    }

    function transfer(address _from, address _to, uint256 _amount) public payable returns (bool) {
        require(_from != address(0), "Invalid sender address");
        require(_to != address(0), "Invalid recipient address");
        require(_amount > 0, "Invalid transfer amount");
        
        (bool success, bytes memory data) = token.call(
            abi.encodeWithSignature("transferFrom(address,address,uint256)", _from, _to, _amount)
        );

        require(success, "Token transfer failed");

        return true;
    }
        function getBalance(address _account) public view returns (uint256) {
        (bool success, bytes memory data) = token.staticcall(
            abi.encodeWithSignature("balanceOf(address)", _account)
        );
        
        require(success, "Balance check failed");
        
        uint256 balance = abi.decode(data, (uint256));
        
        return balance;
    }
}