// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Bank {
    uint8 public baseFee = 50;

    mapping(address => uint256) public userBalance;

    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);
    event GameDebit(address indexed game, address indexed user, uint256 amount);
    event GameCredit(address indexed game, address indexed user, uint256 amount);
    event GameRegistered(address indexed game, bool allowed);

    function deposit() external payable{
        require(msg.value > 0, 'Zero deposit');
        userBalance[msg.sender] += msg.value;

        emit Deposited(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) external{
        require(amount > 0, 'Zero withdraw');
        require(userBalance[msg.sender] >= amount, 'Insufficient balance');
         userBalance[msg.sender] -= amount;
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, 'Transfer fail!');

        emit Withdrawn(msg.sender, amount);
    }

    function balanceOf(address player) external view returns(uint256){
        return userBalance[player];
    }

    function transferToGame(address game, uint256 value) external{

    }

    function transferFromGame(address game, address player, uint256 value) external{

    }
}
