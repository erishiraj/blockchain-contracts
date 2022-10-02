// SPDX-License-Identifier: MIT
pragma solidity >=0.4.16 <0.9.0;

contract C {
    uint256 private data;
    uint256 internal internalData;

    function f(uint256 a) private pure returns (uint256 b) {
        return a + 1;
    }

    function setData(uint256 a) external {
        data = a;
    }

    function getData() public view returns (uint256 s) {
        return data;
    }

    function compute(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    function callingInsideFn() public {
        this.setData(1);
        this.getData();
        f(1);
        compute(1, 2);
    }
}

contract D {
    function readData() public {
        C c = new C();
        // uint local = c.f();
        c.setData(10);
        c.getData();
        // c.compute(1,3);
    }
}

contract E is C {
    function g() public {
        C c = new C();
        //f();
        c.setData(2);
        c.getData();
        compute(1, 2);
        internalData;
    }
}
