// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 *  Solidity 第三十三节：ERC20合约
 *
 *
 */
/**
 * @title IERC20Metadata
 * @dev ERC-20 代币的元数据扩展接口 (ERC20 选配标准)
 * @notice 继承自 IERC20，补充了代币的可读元数据（如名称、符号与小数点精度）
 */
interface IERC20Metadata {
    /**
     * @notice 获取代币的可读完整名称
     * @return 例如: "Tether USD", "Wrapped Ether"
     */
    function name() external view returns (string memory);

    /**
     * @notice 获取代币的交易代码/缩写符号
     * @return 例如: "USDT", "WETH"
     */
    function symbol() external view returns (string memory);

    /**
     * @notice 获取代币展示的小数位数（精度）
     * @dev 大多数代币使用 18（与以太坊 wei 精度对齐）；USDT/USDC 等常用 6 位精度
     * @return 精度数值（例如 18 表示 1 个代币对应 10^18 个最小单位）
     */
    function decimals() external view returns (uint8);

    /**
     * @notice 获取当前代币的总供应量
     * @return 代币总发售量（含精度位）
     */
    function totalSupply() external view returns (uint256);

    /**
     * @notice 查询指定账户的代币余额
     * @param account 要查询的钱包或合约地址
     * @return 该地址持有的代币数量
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @notice 将代币从调用者账户直接转移给目标地址
     * @dev 成功执行后必须抛出 {Transfer} 事件
     * @param recipient 接收代币的目标地址
     * @param amount 转移的代币数量
     * @return success 操作是否成功
     */
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);

    /**
     * @notice 查询所有者 (owner) 授权给被授权人 (spender) 可支配的剩余代币额度
     * @param owner 拥有代币的资产所有者地址
     * @param spender 被授权使用代币的第三方地址（如 DEX 路由合约）
     * @return 剩余允许消费的代币数量
     */
    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);

    /**
     * @notice 授权第三方地址 (spender) 可以从调用者账户中支取的最大代币额度
     * @dev 成功执行后必须抛出 {Approval} 事件
     * @param spender 被授权的第三方地址
     * @param amount 允许授权消费的最大数量
     * @return success 操作是否成功
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @notice 使用被授权的额度，将代币从发送方 (sender) 账户扣除并转移给接收方 (recipient)
     * @dev 调用者必须拥有来自 sender 足够的 allowance 额度，且成功后会扣减对应的额度
     * @param sender 代币划扣扣款的源头地址
     * @param recipient 接收代币的目标地址
     * @param amount 划扣并转移的代币数量
     * @return success 操作是否成功
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev 当代币发生转移时触发（包括 mint 铸造和 burn 销毁操作）
     * @param from 代币发送方地址（如果是铸币 mint 则为 zero address）
     * @param to 代币接收方地址（如果是销毁 burn 则为 zero address）
     * @param value 转移的代币数量
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev 当成功调用 {approve} 更新授权额度时触发
     * @param owner 资产所有者地址
     * @param spender 被授权方地址
     * @param value 最终更新的允许消费额度
     */
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
    
}

contract TimeLockEp33 {
    event Locked(
        address indexed tokenAddr,
        address indexed tokenOwner,
        uint amount,
        uint expireAt
    );
    event withdrawed(
        address indexed tokenAddr,
        address indexed tokenOwner,
        uint amount,
        uint expireAt
    );
    mapping(address => mapping(address => uint[2])) lockAttr;

    function lock(address tokenAddr, uint amount, uint expireAt) external {
        require(
            expireAt >= block.timestamp &&
                expireAt >= lockAttr[tokenAddr][msg.sender][1],
            "Expire is invalid"
        );
        bool ok = IERC20Metadata(tokenAddr).transferFrom(
            msg.sender,
            address(this),
            amount
        );
        require(ok, "TransferFrom fail");
        lockAttr[tokenAddr][msg.sender][0] += amount;
        lockAttr[tokenAddr][msg.sender][1] = expireAt >
            lockAttr[tokenAddr][msg.sender][1]
            ? expireAt
            : lockAttr[tokenAddr][msg.sender][1];

        emit Locked(tokenAddr, msg.sender, amount, expireAt);
    }

    function getExpire(
        address tokenAddr,
        address tokenOwner
    ) external view returns (uint) {
        return
            lockAttr[tokenAddr][tokenOwner][1] > block.timestamp
                ? lockAttr[tokenAddr][tokenOwner][1]
                : 0;
    }

    function getAmount(
        address tokenAddr,
        address tokenOwner
    ) external view returns (uint) {
        return lockAttr[tokenAddr][tokenOwner][0];
    }

    function withdraw(address tokenAddr) external {
        require(lockAttr[tokenAddr][msg.sender][0]>0,"out of token");
        require(lockAttr[tokenAddr][msg.sender][1]<= block.timestamp,"Not Expire");
        uint amount = lockAttr[tokenAddr][msg.sender][0];
        IERC20Metadata(tokenAddr).transfer(msg.sender,lockAttr[tokenAddr][msg.sender][0]);
        lockAttr[tokenAddr][msg.sender][0] = 0;
         emit withdrawed(tokenAddr, msg.sender, amount, block.timestamp);
    }

    function getTime() external view returns(uint){
        return block.timestamp +120;
    }
}
