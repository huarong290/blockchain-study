// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 *  Solidity 第二十四节：哈希运算 (Keccak-256)
 * 
 *  应用场景：
 *  1. 为数据生成唯一的密码学标识（如链上身份 ID、签名哈希）。
 *  2. 比较两个字符串/动态数组是否相等。
 *  3. 防篡改校验（Merkle Tree 默克尔树验证）。
 */
contract HashSectionEp24 {

    /**
     * @dev 将多个不同类型的变量打包并计算其 Keccak-256 哈希值
     * @param a 数字参数
     * @param b 字符串参数
     * @return 返回 32 字节的定长哈希哈希值 (bytes32)
     */
    function test(uint a, string memory b) public pure returns (bytes32) {
        // abi.encodePacked 将变量紧凑打包为 bytes，再交由 keccak256 计算
        return keccak256(abi.encodePacked(a, b));
    }

    /**
     * @dev 比较两个字符串内容是否完全相同
     * @notice Solidity 原生不支持 string 的 == 运算符，需转换为哈希值进行比较
     */
    function compare(string memory a, string memory b) public pure returns (bool) {
        return keccak256(bytes(a)) == keccak256(bytes(b));
    }
}