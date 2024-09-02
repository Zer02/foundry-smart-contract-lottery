// Layout of the contract file:
// version
// imports
// errors
// interfaces, libraries, contract
// Inside Contract:
// Type declarations
// State variables
// Events
// Modifiers
// Functions
// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// internal & private view & pure functions

// external & public view & pure functions

// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

/**
 * @title A sample raffle contract
 * @author Zer02
 * @notice This contract is for creating a sample raffle
 * @dev Implements Chainlink VRFv2.5
 */

contract Raffle {
  /* Errors */
  error Raffle__SendMoreToEnterRaffle();

  uint256 private immutable i_entranceFee;
  uint256 private immutable i_interval;
  address payable[] private s_players;
  uint256 private s_lastTimeStamp;

  /* Events */ 
  event RaffleEntered(address indexed player);

  constructor(uint256 entranceFee, uint256 interval) {
    i_entranceFee = entranceFee;
    i_interval = interval;
    s_lastTimeStamp = block.timestamp;
  }

  function enterRaffle() external payable {
    if(msg.value < i_entranceFee) {
      revert Raffle__SendMoreToEnterRaffle();
    }
    s_players.push(payable(msg.sender));
    emit RaffleEntered(msg.sender);
  }

  function pickWinner() external {
    block.timestamp - s_lastTimeStamp > i_interval;
    if((block.timestamp - s_lastTimeStamp) < i_interval) {
      revert();
    }
  }

  /**
   * Getter Functions
   */

  function getEntranceFee() external view returns (uint256) {
    return i_entranceFee;
  }
}