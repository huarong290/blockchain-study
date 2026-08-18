// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 *  Solidity 第二十九节：Muti Call
 *
 *
 */
contract TestFirst {
    string public name;

    function setName(string memory _name) external {
        name = _name;
    }
}

contract TestSecond {
    uint public sex;

    function setSex(uint _sex) external {
        sex = _sex;
    }
}

contract MutiCallEp29 {
    event log(address indexed addr);

    function makeFirst() external {
        emit log(address(new TestFirst()));
    }

    function makeSecond() external {
        emit log(address(new TestSecond()));
    }

    // 生成函数选择器与打包参数
    function makeSign(
        string memory fn,
        uint arg
    ) external pure returns (bytes memory) {
        return abi.encodeWithSignature(fn, arg);
    }

    function makeSign(
        string memory fn,
        string memory arg
    ) external pure returns (bytes memory) {
        return abi.encodeWithSignature(fn, arg);
    }

    function multiRead(
        address[2] memory addr,
        bytes[2] memory _data
    ) external view returns (string memory name, uint sex) {
        (bool ok1, bytes memory _result1) = addr[0].staticcall(_data[0]);
        require(ok1, "muti[0] read fail");
        name = abi.decode(_result1, (string));
        (bool ok2, bytes memory _result2) = addr[1].staticcall(_data[1]);
        require(ok2, "muti[1] read fail");
        sex = abi.decode(_result2, (uint));
    }

    function multiWrite(
        address[2] memory addr,
        bytes[2] memory _data
    ) external view {
        (bool ok1, ) = addr[0].staticcall(_data[0]);
        require(ok1, "muti[0] read fail");

        (bool ok2, ) = addr[1].staticcall(_data[1]);
        require(ok2, "muti[1] read fail");
    }
}
