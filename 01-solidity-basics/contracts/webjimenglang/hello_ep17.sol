// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 *  Solidity 第十七节：可见性
 *  public
 *  private
 *  external
 *  internal
 */
contract ParentEp17{
     uint private parentId = 1;
    string internal parentName="partent::name";

    function getParentId() public view returns(uint){
        return parentId;
    }
}

contract VisiableSectionEp17 is ParentEp17{
    uint public id =2;
    string private name="child::name";
}