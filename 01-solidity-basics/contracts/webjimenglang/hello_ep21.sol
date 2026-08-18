// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 *  Solidity 第二十一节：回退函数 (Fallback Function)
 * 
 *  作用与场景：
 *  1. 当调用的函数不存在于当前合约中时，作为保底逻辑触发。
 *  2. 配合 receive() 用来接收以太币（如果加了 payable 修饰符）。
 *  3. 常用于“代理模式（Proxy Pattern/可升级合约）”，将无法识别的调用通过 fallback 转发给实现合约。
 */
contract FallbackSectionEp21 {

    // 定义一个日志事件，记录调用的函数名以及带入的原始数据 msg.data
    event log(string name, bytes data);

    /**
     * @dev 回退函数 fallback
     * 触发条件：
     * - 外部调用了当前合约中不存在的方法/函数名。
     * - 外部向合约发送了交易，且带有了 msg.data（无法匹配任何已定义的函数）。
     */
    fallback() external {
        // 触发日志事件，输出 "fallback" 标记和接收到的原始调用数据 (msg.data)
        emit log("fallback", msg.data);
    }
} 