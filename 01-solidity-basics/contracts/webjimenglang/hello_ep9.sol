// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 *  Solidity 第九节：数组操作
 *
 */
contract ArraysSectionEp9 {
    uint[] public list;

    function pushItem(uint v) public returns (uint[] memory) {
        list.push(v);
        return list;
    }

    function len() public view returns (uint) {
        return list.length;
    }
    function findItem(uint item) public view returns (int) {
        for(uint i=0;i<list.length;i++){
            if(list[i]== item){
                return int(i);
            }
        }
        return -1; // 循环结束后再返回 -1
    }
    function replaceItem(uint a,uint b) public returns(uint[] memory){
        for(uint i=0;i<list.length;i++){
            if(list[i]== a){
                list[i] = b;
            }
        }
        return list;
    }



    // 修复：移除错误的 list.remove()，采用高效的“末尾元素覆盖法”
    function remove(uint k) public returns (uint[] memory) {
        require(k < list.length, "Index out of bounds");
        
        // 1. 用数组最后一个元素覆盖要删除的第 k 个元素
        list[k] = list[list.length - 1];
        
        // 2. 弹出末尾多余的元素
        list.pop();
        
        return list;
    }

}
