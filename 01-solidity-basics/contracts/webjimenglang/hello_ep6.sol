// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 *  solidity第六节 断言与错误处理
 *
 *
 */
contract HelloEp6 {
    error OnlyLessTen(uint v);
    function test1(uint a) public pure returns (uint) {
        assert(a <= 10);
        return a;
    }

    function test2(uint b) public pure returns (uint) {
        if (b > 10) revert("only less than 10");
        return b;
    }

    function test3(uint c) public pure returns (uint) {
        require(c <= 10, "only less than 10");
        return c;
    }
    function test4(uint d) public pure returns (uint) {
        if(d>10) revert OnlyLessTen(d);
        return d;
    }
}
