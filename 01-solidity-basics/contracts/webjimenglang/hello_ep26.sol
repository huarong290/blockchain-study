// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 *  Solidity 第二十六节：低级 call 与 staticcall
 *
 *  - address.call(...)       : 可修改状态变量，或附带 ETH 发送 (写操作)
 *  - address.staticcall(...) : 只读操作，不允许修改任何链上状态 (读操作)
 *  - abi.encodeCall(...)     : 相比 abi.encodeWithSignature，提供了强类型检查，防止函数名或参数写错
 */

interface Proxy {
    function setName(string memory _name) external;

    function getName() external view returns (string memory);

    function getBalance() external view returns (uint);
}

contract User {
    string name;

    receive() external payable {}

    fallback() external payable {}

    // 状态变量赋值逻辑
    function setName(string memory _name) external {
        name = _name;
    }

    function getName() external view returns (string memory) {
        return name;
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}

contract LowLevelCallEp26 {
    address public addr;

    // 1. 部署并保存目标合约地址
    function makeUser() external returns (address) {
        addr = address(new User());
        return addr;
    }

    // 2. 使用 call 低级调用写入方法 (setName)
    function callSetName(string memory _name) external {
        require(addr != address(0), "User contract not initialized");

        (bool ok, ) = addr.call{value: 1 ether}(
            abi.encodeCall(/*functionPoint */ User.setName, (_name))
        );
        require(ok, "call setName() failed");
    }

    // 3. 使用 staticcall 低级调用只读方法 (getName) 并用 abi.decode 解码返回值
    function callGetName() external view returns (string memory) {
        require(addr != address(0), "User contract not initialized");

        (bool ok, bytes memory result) = addr.staticcall(
            abi.encodeCall(/*functionPoint */ User.getName, ())
        );
        require(ok, "call getName() failed"); // 修复：修正错误提示文本

        // 解码返回的 bytes 字节流
        return abi.decode(result, (string));
    }

    function callGetBalance() external view returns (uint) {
        require(addr != address(0), "User contract not initialized");

        (bool ok, bytes memory result) = addr.staticcall(
            abi.encodeCall(/*functionPoint */ User.getBalance, ())
        );
        require(ok, "call getBalance() failed");

        // 解码返回的 bytes 字节流
        return abi.decode(result, (uint));
    }

    function proxySetName(string memory _name) external {
        return Proxy(/*address*/ addr).setName(_name);
    }

    function roxyGetName() external view returns (string memory) {
        return Proxy(/*address*/ addr).getName();
    }

    function proxyGetBalance() external view returns (uint) {
        return Proxy(/*address*/ addr).getBalance();
    }
}
