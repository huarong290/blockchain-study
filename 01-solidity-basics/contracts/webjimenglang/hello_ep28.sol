// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 *  Solidity 第二十八节：签名验证 (ECDSA Signature Verification)
 *
 *  以太坊链下签名、链上验签的标准 4 步流程：
 *  - Step 1: 原始数据哈希 -> 将任意内容进行 keccak256 哈希，得到 32 字节的原始消息哈希 (Message Hash)。
 *  - Step 2: 链下私钥签名 -> 链下用户/服务端使用钱包私钥对 Step 1 的结果进行签名，得到 65 字节的签名数据 (Signature)。
 *  - Step 3: 结合以太坊前缀生成 ETH 签名哈希，并从签名数据中还原出签名者地址 (Recover Signer)。
 *  - Step 4: 签名校验 -> 比对推导出的签名者地址与预期地址是否一致 (Verify)。
 */
contract VerifySignEp28 {

    /**
     * @notice Step 1: 计算原始消息的 Keccak-256 哈希值
     * @param _msg 链下需要签名的原始字符串消息
     * @return 返回 32 字节的消息哈希值
     */
    function msgHash(string memory _msg) public pure returns (bytes32) {
        return keccak256(bytes(_msg));
    }

    /**
     * @notice Step 2 & 3 衔接：添加以太坊专属签名签名前缀，计算符合 EIP-191 标准的签名哈希
     * @dev 以太坊签名为了防止恶意数据伪造交易，强制在被签名的消息前加入前缀 "\x19Ethereum Signed Message:\n32"
     * @param _hash Step 1 生成的原始消息哈希
     * @return 返回带有以太坊前缀的最终签名哈希值 (Eth Signed Message Hash)
     */
    function signedHash(bytes32 _hash) public pure returns (bytes32) {
        return
            keccak256(
                abi.encodePacked("\x19Ethereum Signed Message:\n32", _hash)
            );
    }

    /**
     * @notice Step 3: 从签名数据和 ETH 签名哈希中还原出签名者的以太坊地址
     * @dev 65 字节的签名数据包含三部分：r (前 32 字节), s (中间 32 字节), v (最后 1 字节)
     * @param _ethHash 带有以太坊前缀的签名哈希值 (signedHash 的返回值)
     * @param _sign 链下签名得到的 65 字节签名数据 (Signature)
     * @return 返回推导出来的签名者钱包地址 (address)
     */
    function recooverSigner(bytes32 _ethHash, bytes calldata _sign) public pure returns (address) {
        // 确保签名长度必须为 65 字节 (32 + 32 + 1)
        require(_sign.length == 65, "Invalid signature length");

        // 使用 Solidity 0.8.5+ 支持的切片语法提取 r, s, v
        bytes32 r = bytes32(_sign[:32]);      // 前 32 字节 (0 ~ 31)
        bytes32 s = bytes32(_sign[32:64]);    // 中间 32 字节 (32 ~ 63)
        uint8 v = uint8(bytes1(_sign[64:]));  // 第 65 个字节 (索引 64)

        // 使用 EVM 原生内置函数 ecrecover 推导签名者地址
        // 如果签名非法，ecrecover 会返回零地址 address(0)
        return ecrecover(              , v, r, s);
    }

    /**
     * @notice Step 4: 完整验证签名流程
     * @param _msg 原始消息字符串
     * @param _sign 链下传入的 65 字节签名数据
     * @param signer 预期的目标签名者地址
     * @return 验证结果：如果还原出的地址与预期地址一致，返回 true，否则返回 false
     */
    function verify(string memory _msg, bytes calldata _sign, address signer) public pure returns (bool) {
        // 1. 计算原始消息哈希: msgHash(_msg)
        // 2. 加上以太坊前缀并哈希: signedHash(...)
        // 3. 还原签名者地址: recooverSigner(...)
        // 4. 判断恢复出的地址是否等于预期的 signer 且不为零地址
        address recovered = recooverSigner(signedHash(msgHash(_msg)), _sign);
        return recovered != address(0) && recovered == signer;
    }
}