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
├── 01-solidity-basics/         # Solidity 核心语法、面向对象、设计模式
├── 02-foundry-hardhat/         # Foundry 工具链实战（Forge/Anvil/Cast、脚本部署、Gas 评估）
├── 03-erc-standards/           # 代币标准与扩展（ERC-20, ERC-721, ERC-1155, ERC-2612 Permit）
├── 04-evm-deep-dive/           # EVM 底层深入（Storage 存储布局、Yul 汇编、Delegatecall 与可升级合约）
├── 05-smart-contract-security/ # 安全审计与黑客攻防（Slither 扫描、Fuzzing 模糊测试、经典漏洞复现）
├── 06-dapp-frontend/           # 全栈 DApp 交互（Next.js + Wagmi + Viem + RainbowKit 钱包连接）
├── 07-defi-protocols/          # 主流 DeFi 协议复刻（Uniswap V2 AMM 算法、Aave 借贷机制、Staking 质押）
└── 08-chain-data-indexing/     # 链上数据索引（Event 监听、The Graph / Subgraph 搭建与查询）
├── 09-python-web3/        # Python Web3.py 脚本、链上数据分析与自动化工具
└── 10-java-integration/   # Spring Boot 通过 Web3j 与智能合约交互集成示例


blockchain-study/
├── .github/                     # GitHub Actions (CI/CD 自动化测试与合约安全扫描)
├── docker/                      # 本地基础设施环境 (Anvil/Hardhat Node, Postgres, Redis, IPFS)
│   └── docker-compose.yml
│
├── contracts/                     # 【合约层】智能合约核心与底层
│   ├── 01-solidity-basics/        # Solidity 核心语法、面向对象、设计模式
│   ├── 02-foundry-hardhat/        # Foundry 工具链实战（Forge/Anvil/Cast、脚本部署、Gas 评估）
│   ├── 03-erc-standards/          # 代币标准与扩展（ERC-20, ERC-721, ERC-1155, ERC-2612 Permit）
│   ├── 04-evm-deep-dive/          # EVM 底层深入（Storage 存储布局、Yul 汇编、Delegatecall 与可升级合约）
│   ├── 05-smart-contract-security/# 安全审计与黑客攻防（Slither 扫描、Fuzzing 模糊测试、经典漏洞复现）
│   └── 06-defi-protocols/         # 主流 DeFi 协议复刻（Uniswap V2 AMM 算法、Aave 借贷机制、Staking 质押）
│
├── apps/                          # 【应用层】前端与数据索引
│   ├── 07-dapp-frontend/          # 全栈 DApp 交互（Next.js + Wagmi + Viem + RainbowKit 钱包连接）
│   └── 08-chain-data-indexing/    # 链上数据索引（Event 监听、The Graph / Subgraph 搭建与查询）
│
├── services/                      # 【服务层】多语言后端与自动化
│   ├── 09-python-web3/            # Python Web3.py 脚本、链上数据分析与自动化工具
│   └── 10-java-integration/       # Spring Boot 通过 Web3j 与智能合约交互集成示例
│
├── shared/                        # 【共享层】跨项目共享资源
│   ├── abis/                      # 智能合约编译生成的 ABI 文件（供前后端调用）
│   └── addresses/                 # 部署在各测试网的合约地址配置文件
│   └── scripts/                 # 通用自动化运维或节点拉起脚本
├── .gitignore                     # Git 忽略配置文件
├── .env.example                   # 环境变量模版
└── README.md                      # 项目说明与路线图


blockchain-study/
├── .github/                     # GitHub Actions (CI/CD 自动化测试与合约安全扫描)
├── docker/                      # 本地基础设施环境 (Anvil/Hardhat Node, Postgres, Redis, IPFS)
│   └── docker-compose.yml
│
├── contracts/                   # 智能合约核心库 (建议采用 Foundry 单独管理依赖)
│   ├── 01-solidity-deep-dive/   # Solidity 核心语法与 EVM 底层机制 (Yul/Assembly)
│   ├── 02-erc-standards/        # 代币标准与升级合约 (ERC20, 721, 1155, ERC4337)
│   ├── 03-defi-protocols/       # DeFi 协议复刻 (AMM/Uniswap, Lending/Aave, Staking)
│   └── 04-security-vault/       # 常见漏洞复现与防范 (Reentrancy, Flashloan, Overflow)
│
├── apps/                        # 应用层 (前端与全栈 DApp)
│   ├── dapp-nextjs/             # Web3 前端应用 (Next.js + Wagmi + Viem + RainbowKit)
│   └── indexer-subgraph/        # 链上数据索引 (The Graph 或 Envoy/Custom Indexer)
│
├── services/                    # 后端与自动化服务层
│   ├── java-web3-backend/       # Spring Boot + Web3j (监听链上事件、交易构建、钱包打通)
│   └── python-data-analytics/   # Python + Web3.py (链上数据抓取、MEV分析、自动化机器人)
│
├── shared/                      # 跨项目共享资源
│   ├── abis/                    # 编译导出的合约 ABI 文件
│   ├── addresses/               # 各测试网/主网部署合约地址映射
│   └── scripts/                 # 通用自动化运维或节点拉起脚本
│
├── .env.example                 # 统一环境变量模版
├── foundry.toml                 # 全局或合约专用的 Foundry 配置文件
└── README.md