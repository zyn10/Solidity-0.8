// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingSystem {
    mapping(address => bool) hasVoted;
    uint256 public yesVotes;
    uint256 public noVotes;

    function vote(bool _vote) public {
        require(!hasVoted[msg.sender], "You have already voted.");
        if (_vote) {
            yesVotes++;
        } else {
            noVotes++;
        }
        hasVoted[msg.sender] = true;
    }
}



