// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    struct Candidate {
        string name;
        uint voteCount;
    }

    mapping(uint => Candidate) public candidates;
    mapping(address => bool) public hasVoted;
    address public owner;
    uint public candidateCount;

    constructor() {
        owner = msg.sender; // Set contract deployer as the owner
    }

    // ✅ Function to add candidates (only owner can call)
    function addCandidate(string memory _name) public {
        require(msg.sender == owner, "Only owner can add candidates");
        candidates[candidateCount] = Candidate(_name, 0);
        candidateCount++;
    }

    // ✅ Function to vote for a candidate
    function vote(uint _candidateId) public {
        require(!hasVoted[msg.sender], "You have already voted");
        require(_candidateId < candidateCount, "Invalid candidate");

        candidates[_candidateId].voteCount++;
        hasVoted[msg.sender] = true;
    }

    // ✅ Function to get the winner candidate
    function getWinner() public view returns (string memory winnerName, uint winnerVotes) {
        uint maxVotes = 0;
        uint winningCandidate = 0;

        for (uint i = 0; i < candidateCount; i++) {
            if (candidates[i].voteCount > maxVotes) {
                maxVotes = candidates[i].voteCount;
                winningCandidate = i;
            }
        }

        return (candidates[winningCandidate].name, maxVotes);
    }

    // ✅ Fallback function (optional: prevents receive-related errors)
    fallback() external payable {}

    receive() external payable {}
}

