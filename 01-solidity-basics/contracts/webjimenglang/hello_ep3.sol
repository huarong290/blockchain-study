// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 *  solidity第三节 流程控制
 *
 *
 */
contract HelloEp3 {
    /**
     * if else 条件判断
     * @param a  入参
     */
    function test1(uint a) public pure returns (uint) {
        if (a > 0 && a < 2) {
            return 1;
        } else if (a >= 2 && a < 3) {
            return 3;
        } else {
            return 0;
        }
    }
    /**
     * 三元运算符
     * @param a 入惨
     */
    function test2(uint a )public pure returns(uint){
        return a>=10 ? a:0;
    }
}
