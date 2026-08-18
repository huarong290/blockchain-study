// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;
/**
 * Solidity 第二十三节：数据位置
 * 
 *  strorage
 *  memory
 *  calldata
 */
contract DataLocaltionSectionEp23{
    string name = "location";

    function mock(string memory v,uint[] calldata arr )   external view returns(string memory,string memory,uint[] calldata){



        string  storage _name = name;
        return (_name,v,arr[1:3]); // 1-2
    }
}