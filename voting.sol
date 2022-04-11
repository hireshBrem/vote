// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Vote {

    uint256 public redVotes;
    Voter[] public redVoters;
    //Maps addresses to whether or not you have voted
    mapping(address=>bool) public addressToVoted;
    //Maps address to who your vote is on
    mapping(address=>string) public addressToVote;

    uint256 public blueVotes;
    Voter[] public blueVoters;

    struct Voter {
        string name;
        uint256 age;
        address addr;
    }
    //Modifier requires you to be eligible to vote (not voted before)
    modifier eligibleToVote{
        require(addressToVoted[msg.sender] == false, "Invalid, already voted!");
        _;
    }

    event Voted(
        address addr,
        string name,
        uint256 age,
        string vote
    );

    function VOTE_RED(string memory _name, uint256 _age) public eligibleToVote {
        require(_age > 16, "Invalid, not of age to vote!");
        redVotes++;
        redVoters.push(Voter(_name, _age, msg.sender));
        addressToVoted[msg.sender] = true;
        addressToVote[msg.sender] = "red";
        emit Voted(msg.sender, _name, _age, "red");
    }
    
    function VOTE_BLUE(string memory _name, uint256 _age) public eligibleToVote {
        require(_age > 16, "Invalid, not of age to vote!");
        blueVotes++;
        blueVoters.push(Voter(_name, _age, msg.sender));
        addressToVoted[msg.sender] = true;
        addressToVote[msg.sender] = "blue";
        emit Voted(msg.sender, _name, _age, "blue");
    }
}
