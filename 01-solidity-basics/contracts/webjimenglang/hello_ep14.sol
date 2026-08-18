// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 *  Solidity 第十四节：多态与抽象
 *
 */
interface User {
    function gowork() external pure returns (string memory);
}

abstract contract AbstractParentEp14 is User {
    function work() external pure virtual returns (uint);
}

contract ParentEp14 is AbstractParentEp14 {
    uint parentId;
    string parentName;

    // 给父类添加带参数的构造函数
    constructor(uint _pId, string memory _pName) {
        parentId = _pId;
        parentName = _pName;
    }

    function getParentId() public view returns (uint) {
        return parentId;
    }

    function getParentName() public view returns (string memory) {
        return parentName;
    }

    // 多态体现：定义虚函数 (virtual)，留给子类去重写
    function getRole() public view virtual returns (string memory) {
        return "Parent";
    }

    function work() external pure virtual override returns (uint) {
        return 5;
    }

    function gowork() external pure virtual returns (string memory) {
        return "go to work";
    }
}

contract PolyAndAbstractEp14 is ParentEp14 {
    uint childId;
    string childName;

    //子类的构造函数
    constructor(
        uint _childId,
        string memory _childName
    ) ParentEp14(1, "parent::name") {
        childId = _childId;
        childName = _childName;
    }

    function getChildId() public view returns (uint) {
        return childId;
    }

    function getChildName() public view returns (string memory) {
        return childName;
    }

    // 多态体现：重写父类的 getRole 函数 (override)
    function getRole() public view override returns (string memory) {
        return "Child";
    }

    
}
