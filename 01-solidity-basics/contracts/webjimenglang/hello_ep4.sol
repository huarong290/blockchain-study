// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 *  solidity第四节 循环控制
 *
 *
 */
contract HelloEp4 {
    event Dump(uint n );
    /**
     * for 循环
     * @param a  入参
     */
    function test1(uint a) public  returns (uint) {
        for(uint i;i<a ;i++){
            emit Dump(i);
        }
        return a;
    }
    /**
     * while 循环
     * @param b 入惨
     */
    function test2(uint b )public  returns(uint){
        uint i;
        while(i < b){
            emit Dump(i);
            i++; // 关键修复：增加 i++ 防止死循环
        }
        return b;
    }
}
