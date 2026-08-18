// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 * @title SignerArray
 * @dev 针对 Signer 数组的查找扩展工具库
 */
library SignerArray {
    /**
     * @notice 在 Signer 数组中查找指定地址
     * @param _signer 签名者数组
     * @param addr 目标查找地址
     * @return 存在返回数组索引，不存在返回 -1
     */
    function find(Signer[] storage _signer, address addr) internal view returns (int256) {
        for (uint256 n = 0; n < _signer.length; n++) {
            if (_signer[n].account == addr) {
                return int256(n);
            }
        }
        return -1;
    }
}

/**
 * @title MultSignEp34
 * @notice 多重签名钱包（支持提交、批准、拒绝与自动执行）
 */
contract MultSignEp34 {
    using SignerArray for Signer[];

    /// @notice 签名状态枚举
    enum State {
        Pending,  // 待处理
        Approved, // 已通过并执行
        Rejected  // 已拒绝
    }

    /// @notice 签名者记录结构体
    struct Signer {
        address account;  // 签名者地址
        State state;      // 签名态度 (Approved / Rejected)
        uint256 signedAt; // 签名时间戳
    }

    /// @notice 交易明细结构体
    struct Transaction {
        uint256 id;           // 交易编号
        string title;         // 交易标题/备注
        address to;           // 目标接收地址
        uint256 value;        // 转账 ETH 数量 (wei)
        bytes data;           // 调用数据
        State state;          // 交易整体状态
        uint256[3] timeAt;    // 时间节点记录：[0]=approvedAt, [1]=rejectedAt, [2]=createdAt
    }

    // --- 事件定义 ---
    event Commited(uint256 indexed txId, address indexed creator, string title, uint256 timeAt);
    event Approved(uint256 indexed txId, address indexed signer, uint256 timeAt);
    event Rejected(uint256 indexed txId, address indexed signer, uint256 timeAt);
    event ExecutionFailed(uint256 indexed txId);

    // --- 状态变量 ---
    address[] public owner;                           // 所有签名人列表
    mapping(address => bool) public isOwner;         // 签名人快速查找 Mapping (节省 Gas)
    Transaction[] public transactions;               // 历史交易数组
    mapping(uint256 => Signer[]) public transationSigner; // 交易 ID => 签名人记录数组
    uint256 public txId;                             // 当前交易递增 ID

    receive() external payable {}
    fallback() external payable {}

    /**
     * @notice 初始化多签钱包
     * @param _owner 多签持有者地址数组
     */
    constructor(address[] memory _owner) {
        require(_owner.length > 0, "Owners required");
        for (uint256 i = 0; i < _owner.length; i++) {
            address ownerAddr = _owner[i];
            require(ownerAddr != address(0), "Invalid owner");
            require(!isOwner[ownerAddr], "Owner not unique");

            isOwner[ownerAddr] = true;
            owner.push(ownerAddr);
        }
    }

    /// @notice 仅限多签持有者调用的修饰器 (O(1) 复杂度)
    modifier onlyOwner() {
        require(isOwner[msg.sender], "Permission denied");
        _;
    }

    /// @notice 交易操作前置校验修饰器
    modifier checkBefore(uint256 _txId) {
        require(_txId > 0 && _txId <= txId, "Trx does not exist");
        require(transactions[_txId - 1].state == State.Pending, "Trx is already finished");
        require(transationSigner[_txId].find(msg.sender) == -1, "Trx already signed by user");
        _;
    }

    /**
     * @notice 提交一项新的多签交易提案
     * @param title 交易简要描述
     * @param to 目标合约/接收地址
     * @param value 附加的 ETH 数量
     * @param data 调用目标合约的 Calldata
     */
    function commit(
        string memory title,
        address to,
        uint256 value,
        bytes calldata data
    ) external onlyOwner {
        txId++;
        
        Transaction storage trx = transactions.push();
        trx.id = txId;
        trx.title = title;
        trx.to = to;
        trx.value = value;
        trx.data = data;
        trx.state = State.Pending;
        trx.timeAt[2] = block.timestamp;

        // 提交者自动赋予第一个 Approved 签名
        transationSigner[txId].push(
            Signer({
                account: msg.sender,
                state: State.Approved,
                signedAt: block.timestamp
            })
        );

        emit Commited(txId, msg.sender, title, block.timestamp);

        // 如果只有 1 个 Owner，直接触发执行
        if (transationSigner[txId].length == owner.length) {
            _executeTransaction(txId);
        }
    }

    /**
     * @notice 批准指定 ID 的多签交易
     * @param _txId 交易 ID
     */
    function approved(uint256 _txId) external onlyOwner checkBefore(_txId) {
        transationSigner[_txId].push(
            Signer({
                account: msg.sender,
                state: State.Approved,
                signedAt: block.timestamp
            })
        );

        emit Approved(_txId, msg.sender, block.timestamp);

        // 当所有人都同意时，触发执行 (修正 storage 引用)
        if (transationSigner[_txId].length == owner.length) {
            _executeTransaction(_txId);
        }
    }

    /**
     * @notice 拒绝指定 ID 的多签交易
     * @param _txId 交易 ID
     */
    function rejected(uint256 _txId) external onlyOwner checkBefore(_txId) {
        // 修正为 storage 引用
        Transaction storage trx = transactions[_txId - 1];
        trx.state = State.Rejected;
        trx.timeAt[1] = block.timestamp;

        transationSigner[_txId].push(
            Signer({
                account: msg.sender,
                state: State.Rejected,
                signedAt: block.timestamp
            })
        );

        emit Rejected(_txId, msg.sender, block.timestamp);
    }

    /**
     * @dev 内部函数：真正执行底层外部调用
     * @param _txId 交易 ID
     */
    function _executeTransaction(uint256 _txId) internal {
        Transaction storage trx = transactions[_txId - 1];
        trx.state = State.Approved;
        trx.timeAt[0] = block.timestamp;

        (bool success, ) = trx.to.call{value: trx.value}(trx.data);
        require(success, "Execution failed");
    }

    /**
     * @notice 按状态分页获取交易列表（已修复匹配计数 Bug）
     * @param targetState 目标查询状态
     * @param pageNum 页码 (从 1 开始)
     * @param pageSize 每页记录条数
     * @return 返回符合条件的交易数组
     */
    function getTransationList(
        State targetState,
        uint256 pageNum,
        uint256 pageSize
    ) external view returns (Transaction[] memory) {
        require(pageNum > 0 && pageSize > 0, "Invalid page params");

        // 1. 先统计满足条件的总数量
        uint256 matchCount = 0;
        for (uint256 i = 0; i < transactions.length; i++) {
            if (transactions[i].state == targetState) {
                matchCount++;
            }
        }

        // 2. 计算分页偏移量
        uint256 startOffset = (pageNum - 1) * pageSize;
        if (startOffset >= matchCount) {
            return new Transaction[](0);
        }

        // 3. 计算实际应返回的数组长度
        uint256 returnSize = matchCount - startOffset;
        if (returnSize > pageSize) {
            returnSize = pageSize;
        }

        Transaction[] memory result = new Transaction[](returnSize);

        // 4. 正确填充分页数据
        uint256 currentMatch = 0;
        uint256 resultIndex = 0;

        for (uint256 n = 0; n < transactions.length && resultIndex < returnSize; n++) {
            if (transactions[n].state == targetState) {
                if (currentMatch >= startOffset) {
                    result[resultIndex] = transactions[n];
                    resultIndex++;
                }
                currentMatch++;
            }
        }

        return result;
    }
}