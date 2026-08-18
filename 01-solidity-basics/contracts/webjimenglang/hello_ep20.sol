// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 *  Solidity 第二十节：事件（Events）
 *  
 *  作用：
 *  1. 用于通知链下客户端（如前端 Web3 应用）合约内部状态发生了改变。
 *  2. 作为一种低成本的数据存储方式（比直接存在 storage 状态变量里省很多 Gas）。
 */
contract EventSectionEp20 {

    /**
     * @dev 声明事件 created
     * @param sender 带有 indexed 参数，支持前端按地址快速检索过滤
     * @param args 业务数据（传入的值）
     * @param timeAt 触发事件时的时间戳
     */
    event created(address indexed sender, uint args, uint timeAt);

    /**
     * @notice 创建记录并抛出事件
     * @param v 传入的数值
     * @return 传入的原数值
     */
    function create(uint v) external returns (uint) {
        // 使用 emit 关键字触发事件，将数据写入区块链日志 (Logs)
        emit created(msg.sender, v, block.timestamp);
        
        return v;
    }
}