// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 *  solidity第五节 状态控制
 *
 *
 */
contract HelloEp5 {

    uint public id ;

    function setId(uint v) public returns(bool){
        id  = v ;
        return true;
    }
    function getId() public view returns(uint){

        return id ;
    }
}