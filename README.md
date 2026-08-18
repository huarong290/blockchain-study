# 🚀 Web3 & Blockchain Study Notes

> 个人 Web3 / 区块链技术学习与实践代码库。涵盖 Solidity 智能合约、开发工具链（Foundry/Hardhat）、DeFi 协议分析、全栈 DApp 开发及其他辅助语言（Java / Python）集成。

---

## 🛠️ 技术栈与工具箱

- **Smart Contracts**: Solidity | Vyper
- **Frameworks**: Foundry (Primary) | Hardhat
- **Frontend & Web3**: Next.js | TypeScript | Viem / Wagmi | Ethers.js
- **Languages**: Python (Web3.py / Data Analysis) | Java (Spring Boot Integration)
- **Networks**: Anvil (Local) | Sepolia / Base Sepolia (Testnet)

---

## 📂 仓库目录结构

```text

blockchain-study/
├── .github/                      # GitHub Actions (CI/CD 自动化测试与 Slither 安全扫描)
├── docker/                       # 本地基础设施环境 (Anvil 节点, Postgres, Redis, IPFS)
│   └── docker-compose.yml
│
├── contracts/                    # 【合约层】智能合约核心与底层 (Foundry 单独管理依赖)
│   ├── 01-solidity-syntax/       # 基础语法、自定义 Error、tstore 暂存存储
│   ├── 02-foundry-toolchain/     # Forge/Anvil/Cast、脚本部署、Gas 评估与单测
│   ├── 03-erc-standards/         # 代币标准与扩展 (ERC-20, ERC-721, ERC-1155, ERC-2612 Permit, ERC-4337)
│   ├── 04-evm-deep-dive/         # EVM 存储布局、Yul 汇编、Delegatecall 与可升级合约 (Proxy / UUPS)
│   ├── 05-contract-security/     # 安全审计与攻防 (Slither 扫描、Fuzzing 测试、闪电贷/预言机攻击复现)
│   └── 06-defi-protocols/        # DeFi 协议复刻 (Uniswap V2/V4 AMM 机制、Aave 借贷、Staking 质押)
│
├── apps/                         # 【应用层】前端与数据索引
│   ├── dapp-nextjs/              # Web3 前端应用 (Next.js + Wagmi + Viem + RainbowKit 钱包连接)
│   └── indexer-subgraph/         # 链上数据索引 (The Graph / Subgraph 搭建与 GraphQL 查询)
│
├── services/                     # 【服务层】多语言后端与自动化
│   ├── java-web3-backend/        # Spring Boot + Web3j (监听链上事件、交易构建、钱包打通)
│   └── python-data-analytics/    # Python + Web3.py (链上数据抓取、MEV 分析、自动化脚本/Bot)
│
├── shared/                       # 【共享层】跨项目共享资源
│   ├── abis/                     # 智能合约编译生成的 ABI 文件 (供前后端直接调用)
│   └── addresses/                # 部署在各测试网/主网的合约地址映射文件
│
├── .gitignore                    # Git 忽略配置文件
├── .env.example                  # 环境变量模版
├── foundry.toml                  # 全局 Foundry 配置文件
└── README.md                     # 项目说明与学习路线图


【第一阶段：Solidity 语言基础与现代语法】
聚焦于编写安全、高效的智能合约的基础能力。
01_HelloWeb3
02_值类型与自定义值类型(UDVT)
03_函数类型与可见性
04_流程控制与循环控制
05_状态变量与存储位置(Storage, Memory, Calldata)
06_断言与错误 Handling (Require, Assert, Custom Errors)
07_函数修改器(Modifier)
08_全局变量与哈希运算(Keccak256)
09_数组、多维数组与结构体
10_映射类型(Mapping)
11_枚举(Enum)与常量(Constant/Immutable)
12_接口(Interface)与继承(Inheritance)
13_多态、抽象合约与工厂合约
14_类型库(Library)与 SafeMath 演进
15_支付、存款与事件(Events)
16_回退函数(Receive/Fallback)
17_ABI 编码与解码(abi.encode / abi.decode)
18_低级调用(Call / Delegatecall)
19_签名验证(ECDSA / EIP-712)
20_暂存存储(Transient Storage / tstore) 与低 Gas 重入锁
第二阶段：进阶设计模式与标准合约
掌握 Web3 行业主流代币标准与可升级架构。
21_Create2 确定性部署与 Minimal Proxy
22_MultiCall 批量调用模式
23_ERC-20 代币标准与 ERC-2612 Permit 无 Gas 授权
24_ERC-721 NFT 标准与元数据处理
25_ERC-1155 多代币标准
26_OpenZeppelin 核心组件库应用
27_多重签名钱包(Multi-Sig Wallet)实战
28_可升级合约架构(Proxy / UUPS / ERC-1967)
29_ERC-4337 账户抽象(Account Abstraction)概念与实战
【第三阶段：现代工具链与测试工程】
抛弃控制台手点，转向工业级的自动化开发与安全扫描链路。

30_Foundry 工具链入门(Forge, Cast, Anvil)
31_Foundry 单元测试与 Cheatcodes 详解
32_Foundry 高级测试：Fuzzing(模糊测试) & 属性/不变性测试
33_Hardhat 本地开发与测试脚本
34_Hardhat & Forge 自动化部署与 Etherscan 合约验证
35_Slither & Aderyn 静态代码安全扫描工具

第四阶段：DeFi 核心协议复刻与黑客攻防】
深入金融协议底层数学模型，并在靶场中进行实战攻防演练。
36_DeFi 质押(Staking)与收益分配算法
37_Uniswap V2 AMM 算法与数学模型实现
38_Uniswap V4 钩子(Hooks)机制浅析
39_Aave 闪电贷(Flash Loan)机制与借贷池逻辑
40_经典攻击漏洞复现：重入攻击、预言机操纵、闪电贷攻击

第五阶段：全栈 DApp、数据索引与后端集成】
打通链上与链下，构建真正的生产级应用架构。利用成熟的 Spring Boot 体系处理复杂的业务状态映射，并通过 Python 脚本完成链上数据的高效清洗。

41_Web3.js / Viem 智能合约前端交互
42_The Graph / Subgraph 链上事件索引搭建与 GraphQL 查询
43_Python Web3.py 链上数据抓取与自动化脚本
44_Spring Boot + Web3j 监控链上事件与后端钱包集成
45_DApp 端到端全栈实战(Next.js + Wagmi + RainbowKit + 合约)