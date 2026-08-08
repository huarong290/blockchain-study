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
.
├── 01-solidity-basics/    # Solidity 核心语法、设计模式与安全漏洞（重入、溢出等）
├── 02-foundry-hardhat/    # 合约编译、测试、脚本部署工具链配置与练习
├── 03-erc-standards/      # ERC-20, ERC-721 (NFT), ERC-1155 等标准代币实现与扩展
├── 04-dapp-frontend/      # 前端与智能合约交互实战（Next.js + Viem/Wagmi）
├── 05-defi-protocols/     # 主流 DeFi 协议分析与复刻（Uniswap, Aave, Staking 等）
├── 06-python-web3/        # Python Web3.py 脚本、链上数据分析与自动化工具
└── 07-java-integration/   # Spring Boot 通过 Web3j 与智能合约交互集成示例


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