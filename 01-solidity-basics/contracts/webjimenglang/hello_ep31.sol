// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;
/**
 *  Solidity 第三十一节：create2部署合约
 *
 *
 */
/**
 * @title Student
 * @notice 被部署的目标测试合约
 */
contract Student {
    /**
     * @notice 获取学生名称示例函数
     * @return 返回字符串 "Student::getName()"
     */
    function getName() external pure returns (string memory) {
        return "Student::getName()";
    }

    /**
     * @notice 销毁/清空当前合约余额（注意：Cancun 升级后不再擦除代码）
     * @dev 使用 tx.origin 作为接收余额的地址
     */
    function kill() external {
        selfdestruct(payable(tx.origin));
    }
}

/**
 * @title Create2ByCreationCodeEp32
 * @notice Solidity 第三十一节：CREATE2 部署合约（原生语法与内联汇编 Assembly 实现）
 */
contract Create2ByCreationCodeEp32 {
    /// @notice 存储最近部署的 Student 合约地址
    address public student;

    /**
     * @notice 调用已部署 Student 合约的 getName 方法
     * @return 返回 Student 合约的名称字符串
     */
    function callStudentName() external view returns (string memory) {
        require(student != address(0), "Student not deployed");
        return Student(student).getName();
    }

    /**
     * @notice 触发 Student 合约自毁，并将本合约记录的 student 地址重置为零地址
     */
    function killStudent() external {
        require(student != address(0), "Student not deployed");
        Student(student).kill();
        student = address(0);
    }

    /**
     * @notice 获取 Student 合约的 creationCode（部署字节码/初始化字节码）
     * @return 返回 Student 合约的原始字节码 (bytes)
     */
    function getCreateCode() public pure returns (bytes memory) {
        return type(Student).creationCode;
    }

    /**
     * @notice 方式一：使用内联汇编 (Assembly) 手动调用 create2 指令部署 Student 合约
     * @param _salt 用于生成唯一地址的盐值字符串
     * @return tokenAddress 部署成功的 Student 合约地址
     */
    function create2Student(string memory _salt) external returns (address tokenAddress) {
        bytes memory createCode = getCreateCode();
        bytes32 _salt_hash = keccak256(abi.encodePacked(_salt));

        assembly {
            /**
             * create2(v, p, n, s)
             * - v: 附带发送的 ETH 数量 (wei) -> 0
             * - p: 内存中部署字节码开始的位置 -> add(createCode, 0x20) (跳过前 32 字节表示长度的头信息)
             * - n: 内存中部署字节码的总长度 -> mload(createCode)
             * - s: 32 字节的盐值哈希 -> _salt_hash
             */
            tokenAddress := create2(
                0,
                add(createCode, 0x20),
                mload(createCode),
                _salt_hash
            )

            // 校验：如果生成的合约代码大小为 0，说明部署失败，直接 Revert
            if iszero(extcodesize(tokenAddress)) {
                revert(0, 0)
            }

            // 将部署成功的地址写入 Solidity 状态变量 student 中
            sstore(student.slot, tokenAddress)
        }
    }

    /**
     * @notice 方式二：使用内联汇编 (Assembly) 传入自定义字节码部署任意合约（通用版）
     * @dev 修改函数名避免重载混淆，支持传入任意合约的 creationCode
     * @param _salt 用于生成唯一地址的盐值字符串
     * @param creationCode 目标合约的部署字节码
     * @return tokenAddress 部署成功的合约地址
     */
    function create2Contract(string memory _salt, bytes memory creationCode) external returns (address tokenAddress) {
        bytes32 _salt_hash = keccak256(abi.encodePacked(_salt));

        assembly {
            tokenAddress := create2(
                0,
                add(creationCode, 0x20),
                mload(creationCode),
                _salt_hash
            )

            if iszero(extcodesize(tokenAddress)) {
                revert(0, 0)
            }

            sstore(student.slot, tokenAddress)
        }
    }

    /**
     * @notice 方式三：使用 Solidity 原生推荐语法 (`new Contract{salt: ...}()`) 部署 CREATE2
     * @param _salt 盐值字符串
     * @return 部署成功的 Student 合约地址
     */
    function makeStudent(string memory _salt) external returns (address) {
        student = address(
            new Student{salt: keccak256(abi.encodePacked(_salt))}()
        );
        return student;
    }

    /**
     * @notice 链下/链上预计算 CREATE2 部署地址（无需消耗 Gas 部署即可预测）
     * @dev 计算公式：keccak256(0xff + deployerAddress + salt + keccak256(bytecode))[12:]
     * @param _salt 盐值字符串
     * @return 预测的合约部署目标地址
     */
    function getAddress(string memory _salt) external view returns (address) {
        // 1. 计算盐值的 keccak256 哈希
        bytes32 salt = keccak256(abi.encodePacked(_salt));

        // 2. 获取目标合约 init code 的 keccak256 哈希
        bytes32 bytecodeHash = keccak256(type(Student).creationCode);

        // 3. 根据 CREATE2 规则计算哈希值
        bytes32 hash = keccak256(
            abi.encodePacked(
                bytes1(0xff),  // 固定的 0xff 前缀
                address(this), // 部署工厂合约地址
                salt,          // 盐值哈希
                bytecodeHash   // 部署字节码哈希
            )
        );

        // 4. 截取 32 字节哈希的后 20 字节作为以太坊地址
        return address(uint160(uint256(hash)));
    }
}