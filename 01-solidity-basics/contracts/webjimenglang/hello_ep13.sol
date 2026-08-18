// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 *  Solidity 第十三节：接口与继承
 *
 */

interface User {
    function work() external returns (bool);
}

contract ParentEp13 is User {
    bool isWork;

    function work() external override returns (bool) {
        isWork = true;
        return isWork;
    }

    function getWork() external view returns (bool) {
        return isWork;
    }

    function test() external pure returns (string memory) {
        return "parent";
    }
}

contract InterfaceAndExtendsSectionEp13 is ParentEp13 {
    function callParentTest() public view returns (string memory) {

        return string(bytes.concat("",bytes(this.test())));
    }
}
