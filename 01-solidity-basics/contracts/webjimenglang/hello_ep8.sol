// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 *  Solidity 第八节：全局变量与单位
 *
 *  以太单位 (Ether Units)
 *  1 wei = 1
 *  1 gwei = 1e9 // 10**9 wei
 *  1 ether = 1e18 // 10**18 wei
 *
 *  时间单位 (Time Units)
 *  1 seconds / 1 second = 1
 *  1 minutes / 1 minute = 60 seconds
 *  1 hours / 1 hour = 3600 seconds
 *  1 days / 1 day = 86400 seconds
 *  1 weeks / 1 week = 604800 seconds
 *  (注：1 years 已在 0.5.0 被废弃)
 *
 *  区块与交易信息 (Block & Transaction Properties)
 *  block.number (uint) - 当前区块号
 *  block.timestamp (uint) - 当前区块时间戳
 *  block.chainid (uint) - 当前链 ID
 *  block.gaslimit (uint) - 当前区块 Gas 上限
 *  block.prevrandao (uint) - 随机数 (替代了旧版的 block.difficulty)
 *  block.coinbase (address) - 当前区块矿工/验证者地址
 *
 *  msg.data (bytes) - 完整的调用数据 (calldata)
 *  msg.sender (address) - 当前函数调用的发起者地址
 *  msg.sig (bytes4) - 调用数据的前 4 字节 (函数选择器)
 *  msg.value (uint) - 随交易发送的以太币数量 (wei)
 *
 *  tx.gasprice (uint) - 交易的 Gas 价格
 *  tx.origin (address) - 交易的原始发起者 (不推荐用于权限校验)
 */
contract GlobalVarsEp8 {
    function testBlock()
        public
        view
        returns (
            uint256 number,
            uint256 timestamp,
            uint256 chainid,
            uint256 gaslimit,
            uint256 prevrandao,
            address coinbase
        )
    {
        return (
            block.number,
            block.timestamp,
            block.chainid,
            block.gaslimit,
            block.prevrandao, // 替代 block.difficulty
            block.coinbase
        );
    }

    /**
     * 测试 msg 全局变量
     * 注意：涉及 msg.value 时函数需要标记为 payable，否则调用时无法附带主币
     */
    function testMsg()
        public
        payable
        returns (
            address sender,
            bytes4 sig,
            uint256 value,
            bytes memory data
        )
    {
        return (
            msg.sender,
            msg.sig,
            msg.value,
            msg.data
        );
    }

    /**
     * 测试 tx 全局变量
     */
    function testTx()
        public
        view
        returns (
            uint256 gasprice,
            address origin
        )
    {
        return (
            tx.gasprice,
            tx.origin
        );
    }
}
