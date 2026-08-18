// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 *  Solidity 第十一节：印射类型
 *
 */
contract MappingSectionEp11{
    mapping(uint=>address) users;
    // 嵌套映射：记录两个地址之间的好友状态
    mapping(address=>mapping(address=>uint8)) friends;

    function put(uint key,address value) public returns(address){
        users[key] =value;
        return value;
    }

    function get(uint key) public view returns(address){
        return users[key];
    }

    function remove(uint key)public returns(bool) {
        delete users[key];
        return true;
    }

    function addFriend(address addr) public returns(bool){
        friends[tx.origin][addr] = 2 ;// 0 deleted 1 pending 2 success
        friends[addr][tx.origin]= 1 ;
        return true;
    }

    function setFriend(address u,address addr) public returns (uint8){
        return friends[u][addr]=2;
    }
    function delFriend(address u,address addr)public{
        delete friends[u][addr];
    }

}