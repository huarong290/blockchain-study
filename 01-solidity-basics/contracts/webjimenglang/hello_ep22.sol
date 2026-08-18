// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 *  Solidity 第二十二节：自毁函数 (Self-destruct)
 * 
 *  注意：
 *  自以太坊 Cancun 升级 (EIP-6780) 后，除非合约是在部署的同一笔交易中销毁，
 *  否则 selfdestruct 仅会清空并转移余额，不再删除链上合约代码。
 */
contract SelfDestructSectionEp21 {

    /**
     * @dev 接收函数，允许当前合约接收以太币 (ETH)
     */
    receive() external payable {}

    /**
     * @notice 触发自毁/清空余额
     * @dev 将合约内的所有 ETH 强制清空并发送给调用者 (msg.sender)
     */
    function kill() external {
        // selfdestruct 需要传入一个 payable 类型的地址作为收款目标
        selfdestruct(payable(msg.sender));
    }

    /**
     * @dev 验证合约是否还存活的测试函数
     */
    function hello() public pure returns (string memory) {
        return "hello";
    }
}