
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;
/**
 * Solidity 中函数的形式
 * function <function name>([parameter types[, ...]]) {internal|external|public|private} [pure|view|payable] [virtual|override] [<modifiers>]
 * [returns (<return types>)]{ <function body> }
 * 
 * pure. pure 函数既不能读取也不能写入链上的状态变量
 * view  view函数能读取但也不能写入状态变量
 * 非 pure 或 view 的函数既可以读取也可以写入状态变量
 */
contract Solidity_002_FunctionTypes{
  uint256 public number  = 5;

   function add() external{
    number = number +1;
   }
  // pure: 纯纯牛马
    function addPure(uint256 number1) external pure returns (uint256 number2){
    number2 = number1 +1;
    }
    // view: 看客
    function addView() external view returns(uint256 number3){
    number3 = number +1;
    }

    // internal: 内部函数
    function minus() internal {
        number = number - 1;
    }

    // 合约内的函数可以调用内部函数
    function minusCall() external {
        minus();
    }
    // payable: 递钱，能给合约支付eth的函数
    function minusPayable() external payable returns(uint256 balance) {
        minus();    
        balance = address(this).balance;
    }
}