pragma solidity ^0.4.17;

contract Lottery{

    address public manager;
    address[] public players;

    function Lottery() public {
        manager = msg.sender;
    }

    function enter() public payable {
        require(msg.value > 0.01 ether);
        players.push(msg.sender);
    }

    function random() private view  returns (uint256) {
        return uint256(sha3(block.difficulty,now,players));
    }

    function pickWinner() restricted public {
        require(msg.sender == manager);
        uint256 index = random() % players.length;
        //this refers to the current contract
        players[index].transfer(this.balance); // 0x1083289473920437289438473473984 send money from contract
        players = new address[](0); // reset the lottery we want to create an dynamic array of initial size of 0 length of array is 0
    }

    function getPlayers() public view returns (address[]){
        return players;
    }

    modifier restricted() { // only manager can call
        require(msg.sender==manager);
        _; // early validation logic
    }


}

