// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;
/**
 * 本章我们介绍了 Solidity 中值类型，包括布尔型、整型、地址、定长字节数组和枚举
 */
contract Solidity_001_valueType{
    // 一.布尔类型
    // 布尔值
     bool public _bool = true;
    // 布尔运算
    bool public _bool1 = !_bool; // 取非
    bool public _bool2 = _bool && _bool1; // 与
    bool public _bool3 = _bool || _bool1; // 或
    bool public _bool4 = _bool == _bool1; // 相等
    bool public _bool5 = _bool != _bool1; // 不相等

    // 二.整型
    int public _int = -1; // 整数，包括负数
    uint public _uint = 1; // 无符号整数
    uint256 public _number = 20220330; // 256位无符号整数

    // 整数运算
    uint256 public _number1 = _number + 1; // +，-，*，/
    uint256 public _number2 = 2**2; // 指数
    uint256 public _number3 = 7 % 2; // 取余数
    bool public _numberbool = _number2 > _number3; // 比大小
    // 三、地址类型
    // 普通地址（address）: 存储一个 20 字节的值（以太坊地址的大小）
    address public _address1 = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;
    //payable address: 比普通地址多了 transfer 和 send 两个成员方法，用于接收转账
    address payable public _address2 = payable(_address1); // payable address，可以转账、查余额
    // 地址类型的成员
    uint256 public balance = _address2.balance; // balance of address

    //四、字节数组
    // 固定长度的字节数组
    bytes32 public _byte32 = "MiniSolidity"; 
    bytes1 public _byte = _byte32[0];

    //五、枚举 enum 它主要用于为 uint 分配名称，使程序易于阅读和维护
    // 用enum将uint 0， 1， 2表示为Buy, Hold, Sell
    enum ActionSet { Buy, Hold, Sell }
    // 创建enum变量 action
    ActionSet action = ActionSet.Buy;

    // enum可以和uint显式的转换
    function enumToUint() external view returns(uint){
        return uint(action);
    }

    // 六、结构体
    struct User{
        //
          bool  _bool2 ;
    }
}