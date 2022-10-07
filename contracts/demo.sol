// SPDX-License-Identifier: MIT

pragma solidity >0.4.0 <0.9.0;

contract Demo {
    uint256 number;

    function setNumber(uint256 _number) public {
        number = _number;
    }

    function getNum() public view returns (uint256) {
        return number;
    }
}
