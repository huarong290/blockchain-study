// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 *  Solidity 第三十节：多维数组
 *
 *
 */
contract MutiArrayEp30 {
    function normalArray() external pure returns (uint[][] memory) {
        uint[][] memory ids = new uint[][](3);
        for (uint i; i < ids.length; i++) {
            ids[i] = new uint[](2);
            ids[i][0] = 100 + i;
            ids[i][1] = 200 + i;
        }
        return ids;
    }
    function fixedArray() external pure returns(uint[2][3] memory v){
        for(uint i ;i<v.length;i++){
            v[i][0] = i;
            v[i][1] = 200 + i;
        }
    }
}
