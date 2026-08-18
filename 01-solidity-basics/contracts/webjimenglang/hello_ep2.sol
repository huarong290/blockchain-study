// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 *  solidity第二节 函数类型
 *
 *
 */
contract HelloEp2 {
    function add(uint a, uint b) public pure returns (uint) {
        return a + b;
    }

    function sub(uint a, uint b) public pure returns (uint) {
        return a - b;
    }

    function mul(uint a, uint b) public pure returns (uint) {
        return a * b;
    }

    function div(uint a, uint b) public pure returns (uint) {
        return a / b;
    }

    function val(uint a, uint b,uint c ) public pure returns(uint,uint,uint){
        return (a,b,c);
    }

    function getName() public pure returns(string memory){
        return _getName();
    }
    function _getName() private pure returns(string memory){

        return "HelloEp2";
    }
}
