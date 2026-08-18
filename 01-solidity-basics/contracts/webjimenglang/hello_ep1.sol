// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 * solidity第一节 类型
 *  solidity 是一种面向对象的高级语言，用于实现智能合约。智能合约是管理以太坊状态下账户行为的程序
 *  solidity 是一种指在针对以太坊虚拟EVM。它受到了C++，Python 和Javascript的影响
 *  solidity是静态类型的支持继承、库 和复杂的用户定义类型等特性
 *  使用solidity，您可以创建用于投票、众筹、盲目拍卖 和多重签名钱包等用途的合约
 *
 */
contract HelloEp1 {
    // int 类型
    int8 public _int8;
    int16 public _int16;
    int32 public _int32;
    int64 public _int64;
    int public key = -1;
    // uint类型
    uint public id = 1;
    uint8 public _uint8;
    uint16 public _uint16;
    uint32 public _uint32;
    uint64 public _uint64;
    uint128 public _uint128;
    // string 类型
    string public name = "hello";
    // 不二类型
    bool public isActive = false;
    // mapping 类型
    mapping(uint => bool) blocked;
    // 结构体
    struct User {
        string email;
    }
    // 枚举
    enum State {
        DEFAULT,
        FALLBACK
    }
    // 地址类型
    address public addr;
    // int类型的列表
    int[] public list;
}
