// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

// The idea is to create one contract per ballot, providing a short name for each option.
// Then the creator of the contract
// who serves as chairperson will give the right to vote to each address individually.
// At the end of the voting time, winningProposal() will return the proposal with the largest number of votes.
// TO-DO List;
// 1. Chairperson:- who is responsible for give permision to give vote and contract deployer.
// 2. List of candidate
// 3.
contract Ballot {
    address public chairperson;

    struct Candidate {
        bytes32 name;
        uint256 voteCount;
    }
    struct Voter {
        uint256 weight;
        bool voted;
        address delegate;
        uint256 vote;
    }

    mapping(address => Voter) public voters;

    Candidate[] candidateList;

    modifier OnlyChairperson() {
        require(msg.sender == chairperson);
        _;
    }

    constructor(bytes32[] memory candidateNames) {
        chairperson = msg.sender;
        for (uint256 i = 0; i < candidateNames.length; i++) {
            candidateList.push(
                Candidate({name: candidateNames[i], voteCount: 0})
            );
        }
    }

    function giveRightToVote(address voterAddress) external OnlyChairperson {
        require(!voters[voterAddress].voted, "You already votted!");
        require(voters[voterAddress].weight == 0);
        voters[voterAddress].weight = 1;
    }

    function vote(uint256 candidateNo) external {
        Voter storage sender = voters[msg.sender];
        require(sender.weight != 0);
        require(!sender.voted, "You already voted!");
        sender.voted = true;
        sender.vote = candidateNo;

        candidateList[candidateNo].voteCount += sender.weight;
    }

    function winnerIndex() private view returns (bytes32 winnerName) {
        uint256 winnerIn = 0;
        for (uint256 i = 0; i < candidateList.length; i++) {
            if (candidateList[i].voteCount > winnerIn) {
                winnerIn = candidateList[i].voteCount;
                winnerName = candidateList[i].name;
            }
        }
        return winnerName;
    }
}
