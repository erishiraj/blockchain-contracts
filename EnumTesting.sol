// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract Testing {
    enum ActionChoices {
        GoLeft,
        GoRight,
        GoStraight,
        GoStill
    }
    ActionChoices choice;
    ActionChoices constant defaultChoice = ActionChoices.GoStraight;

    constructor() {}

    function setGoStraight() external {
        choice = ActionChoices.GoStraight;
    }

    function getDefaultChoice() external view returns (uint256) {
        return uint256(defaultChoice);
    }

    function getChoice() external view returns (ActionChoices) {
        return choice;
    }

    function getLargestValue() public pure returns (ActionChoices) {
        return type(ActionChoices).max;
    }

    function getSmallestValue() public pure returns (ActionChoices) {
        return type(ActionChoices).min;
    }

    function testingFn() external pure returns (string memory) {
        uint128 a = 1;
        // uint128 b = 2.5 + a + 0.5;
        string memory foobar = "foo" "\n" "bar";
        //bytes memory bts = "\n\"\'\\abc\def"
        string memory un = unicode"Hello 😃";
        string memory hexa = hex"0011223344556677";
        return hexa;
    }
}
