// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 *  solidity第七节 函数修改器
 *
 *
 */
contract HelloEp7 {
    bool isLocked;
    address owner;
    modifier OnlyLessThanTen(uint a) {
        require(a <= 10, "only less than 10");
        _;
    }

    modifier checkedLocked() {
        require(!isLocked, "locked");
        isLocked = true;
        _;
        isLocked = false;
    }

    modifier isOwner(){
        require(msg.sender == owner,"Permission denied");
        _;
    }
    function test1(uint a) public pure OnlyLessThanTen(a) returns (uint) {
        return a;
    }

    function test2(uint b) public checkedLocked() returns (uint) {
        return b;
    }
}
