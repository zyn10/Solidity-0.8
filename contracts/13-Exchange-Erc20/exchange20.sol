// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
}

contract DecentralizedExchange {
    address public admin;

    struct Token {
        bytes32 ticker;
        address tokenAddress;
    }

    mapping(bytes32 => Token) public tokens;
    bytes32[] public tokenList;

    mapping(address => mapping(bytes32 => uint256)) public balances;

    event Deposit(address indexed sender, bytes32 indexed ticker, uint256 amount, uint256 balance);
    event Withdraw(address indexed recipient, bytes32 indexed ticker, uint256 amount, uint256 balance);
    event Trade(
        address indexed sender,
        bytes32 indexed sourceTicker,
        uint256 sourceAmount,
        bytes32 indexed destinationTicker,
        uint256 destinationAmount
    );

    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function.");
        _;
    }

    function addToken(bytes32 ticker, address tokenAddress) public onlyAdmin {
        tokens[ticker] = Token(ticker, tokenAddress);
        tokenList.push(ticker);
    }

    function deposit(bytes32 ticker, uint256 amount) public {
        Token memory token = tokens[ticker];
        require(token.tokenAddress != address(0), "Invalid ticker.");
        require(IERC20(token.tokenAddress).transferFrom(msg.sender, address(this), amount), "Transfer failed.");
        balances[msg.sender][ticker] += amount;
        emit Deposit(msg.sender, ticker, amount, balances[msg.sender][ticker]);
    }

    function withdraw(bytes32 ticker, uint256 amount) public {
        Token memory token = tokens[ticker];
        require(token.tokenAddress != address(0), "Invalid ticker.");
        require(balances[msg.sender][ticker] >= amount, "Insufficient balance.");
        balances[msg.sender][ticker] -= amount;
        require(IERC20(token.tokenAddress).transfer(msg.sender, amount), "Transfer failed.");
        emit Withdraw(msg.sender, ticker, amount, balances[msg.sender][ticker]);
    }

    function trade(bytes32 sourceTicker, bytes32 destinationTicker, uint256 sourceAmount) public {
        Token memory sourceToken = tokens[sourceTicker];
        Token memory destinationToken = tokens[destinationTicker];
        require(sourceToken.tokenAddress != address(0) && destinationToken.tokenAddress != address(0), "Invalid ticker.");
        require(sourceAmount > 0, "Invalid source amount.");
        uint256 sourceBalance = balances[msg.sender][sourceTicker];
        require(sourceBalance >= sourceAmount, "Insufficient balance.");
        uint256 destinationAmount = getDestinationAmount(sourceAmount, sourceToken, destinationToken);
        require(destinationAmount > 0, "Invalid destination amount.");
        require(IERC20(sourceToken.tokenAddress).transferFrom(msg.sender, address(this), sourceAmount), "Transfer failed.");
        balances[msg.sender][sourceTicker] = sourceBalance - sourceAmount;
        balances[msg.sender][destinationTicker] += destinationAmount;
        emit Trade(msg.sender, sourceTicker, sourceAmount, destinationTicker, destinationAmount);
    }

// ...

    function getDestinationAmount(uint256 sourceAmount, Token memory sourceToken, Token memory destinationToken) private view returns (uint256) {
        uint256 sourceBalance = IERC20(sourceToken.tokenAddress).balanceOf(address(this));
        uint256 destinationBalance = IERC20(destinationToken.tokenAddress).balanceOf(address(this));
        return (sourceAmount * destinationBalance) / sourceBalance;
    }

    function getTokenList() public view returns (bytes32[] memory) {
        return tokenList;
    }

    function getTokenBalance(bytes32 ticker) public view returns (uint256) {
        return balances[msg.sender][ticker];
    }

    function changeAdmin(address newAdmin) public onlyAdmin {
        admin = newAdmin;
    }
}
