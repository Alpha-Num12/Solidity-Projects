// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Calculator {
    function add(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;
    }

    function subtract(uint256 a, uint256 b) public pure returns (uint256) {
        require(b <= a, "Result cannot be negative");
        return a - b;
    }

    function multiply(uint256 a, uint256 b) public pure returns (uint256) {
        return a * b;
    }

    function divide(uint256 a, uint256 b) public pure returns (uint256) {
        require(b > 0, "Cannot divide by zero");
        return a / b;
    }

    function power(uint256 base, uint256 exponent) public pure returns (uint256) {
        return base ** exponent;
    }

    function modulus(uint256 a, uint256 b) public pure returns (uint256) {
        require(b > 0, "Cannot divide by zero");
        return a % b;
    }

    function squareRoot(uint256 x) public pure returns (uint256) {
        uint256 z = (x + 1) / 2;
        uint256 y = x;
        while (z < y) {
            y = z;
            z = (x / z + z) / 2;
        }
        return y;
    }
}

