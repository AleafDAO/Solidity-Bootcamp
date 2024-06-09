  <h1>UJS Solidity 校园激励计划</h1>
  "Solidity校园激励计划"旨在鼓励江苏大学学生学习和掌握Solidity编程语言，从而为进入区块链开发领域奠定坚实基础，开启一个充满可能性和机遇的世界。


  

  完成课程学习并通关课后阶段任务将获得**丰厚奖励**


## 课程目录

<ul>
<li><a href='#blockchain-introduction'>Blockchain Introduction / 区块链介绍</a></li>
<li><a href='#solidity'>Solidity / 编程语言</a></li>
<li><a href='#dev-tools-and-ecosystem'>Tools / 工具</a></li>


## 一.Blockchain Introduction

> 区块链是什么？ 区块链解决什么问题？ Web2 与 Web3 有什么不同？ Web2 开发者的机会？ Wallet 是什么？ Layers 是什么？

#### [本课视频](https://openbuild.xyz/learn/courses/95/2824)

#### 参考资料

* [关于区块链的基础问题]([关于区块链的基础问题 | 登链社区 | 区块链技术社区 (learnblockchain.cn)](https://learnblockchain.cn/article/389))

## 二.Solidity

> Solidity Basic Syntax, Tools, How to Deploy, etc

### 1. Solidity Basic Syntax

#### [本课视频](https://openbuild.xyz/learn/courses/95/2825)

- Solidity 智能合约简介
- Solidity 核心语法

#### 参考资料

1. [Solidity 智能合约开发 - 基础](https://www.pseudoyu.com/zh/2022/05/25/learn_solidity_from_scratch_basic/)
2. [learn-solidity](https://github.com/pseudoyu/learn-solidity/)
3. [Demo Code](https://github.com/pseudoyu/social-dApp-demo-contracts)
4. [foundry-starter-kit](https://github.com/pseudoyu/foundry-starter-kit)
5. [Evangelion Theme](https://marketplace.visualstudio.com/items?itemName=RuDevIO.evangelion-theme)
6. https://openbuild.xyz/learn/courses/95

### 2. Remix IDE

#### [本课视频](https://openbuild.xyz/learn/courses/95/2826)

- Remix 使用
- 智能合约生命周期

#### 参考资料

- [Remix - Ethereum IDE](https://remix.ethereum.org/)
- [openzeppelin-contracts](https://github.com/OpenZeppelin/openzeppelin-contracts) - [ERC20.sol](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol)
### 3. ERC Contracts 

#### [本课视频](https://openbuild.xyz/learn/courses/95/2834)

- ERC/EIP 介绍
- ERC20/ERC712/ERC1155 概念讲解

### 4. Foundry 

> 使用 Foundry 构建一个 ERC20 Exchange

#### [本课视频](https://openbuild.xyz/learn/courses/95/2835)

#### 参考资料

* [Learn Smart Contract with Foundry](https://openbuild.xyz/learn/courses/83)
* [Foundry 中文文档](https://learnblockchain.cn/docs/foundry/i18n/zh)

### 5.DeFi基础知识

#### 参考资料

* [DeFi基础知识]([DeFi 基础知识：去中心化金融及其运作方式 | 登链社区 | 区块链技术社区 (learnblockchain.cn)](https://learnblockchain.cn/article/8032))

### 6.Uniswap V2 的功能和简单使用

#### 参考资料

* [uniswap developers](https://uniswap.org/developers)
* [Uniswap详解](https://www.rareskills.io/uniswap-v2-book)

## 三.Tools

### 1. EVM Contract Bytecode and Data Analysis On Chain

#### [本课视频](https://openbuild.xyz/learn/challenges/95/2831)

### 2. Oracle

#### Exercise

大家可以试试几个 Demo:

[Functions Lens Eventbrite](https://github.com/smartcontractkit/functions-lens-eventbrite)
> 通过Functions连接Lens和eventbrite，根据用户在链上的行为发布一些活动的优惠券

[Functions: The Graph and Uniswap](https://github.com/smartcontractkit/functions-the-graph-uniswap)
> 通过Functions获取ETH价格然后触发uniswap交易

[CCIP Cross Chain NFT](https://github.com/smartcontractkit/ccip-cross-chain-nft)
> CCIP跨链NFT



## 通关任务🏅️


### 阶段一  💰50元
1. 使用remix在sepolia测试网上部署一个ERC20合约，要求：初始发行量为2100万，只有管理员可以销毁自己的Token，合约代码需要在etherscan上开源
2. 使用remix在sepolia测试网上部署一个ERC721合约，要求：使用ipfs存储图片，在opensea上可见，并且设置一个student属性为UJS Blockchain。
3. 编写一个Market合约，要求：使用自己发行的ERC20合约来买卖发行的NFT，NFT持有者可以上架NFT，并且设置价格（多少个token可以购买NFT）,其它地址可以通过购买函数，转入对应数量的token，得到对应的NFT。

### 阶段二  💰70元
1. 熟悉使用Foundry开发框架，部署阶段一的Market合约并对其功能点编写测试。
2. 熟悉uniswapV2，并使用Foundry框架部署，编写添加流动性、Swap、移除流动性功能的测试。

### 阶段三  💰70元
1. 完成 [ChainlinkLearningPath](https://github.com/QingyangKong/ChainlinkLearningPath)中全部的三个任务。

### Demoday优秀项目  💰800-1200元

  本次活动会根据参加人数设置2个左右的Demoday优秀项目奖励，参加成员可以与其他成员自由组队，提交Demoday项目，（每支队伍人数控制在1-4人）。

### 额外任务

提交一篇高质量文章or 积极参与社区贡献 + 为AleafDAO Organization提交pr

（完成三个阶段以及额外任务可获得Aleaf DAO面试机会，成为UJS Blockchain核心成员，优先匹配更多资源。）



>在任务完成后，提交到[github仓库](https://github.com/AleafDAO/Solidity-Bootcamp)对应文件夹下



## 推荐材料

### 1. 人文基础 🌟🌟🌟🌟🌟

比特币之前的事情：理解组成比特币的核心技术的发展，理解比特币的前前后后，能更好的理解中本聪创造比特币的核心产物。

- [比特币前传（一）70 年代公钥传奇](https://foresightnews.pro/article/detail/13987)
- [比特币前传（二）：去中心化的起源](https://foresightnews.pro/article/detail/14114)
- [比特币前传（三）：90 年代的加密战争](https://foresightnews.pro/article/detail/14545)
- [比特币前传（四）：跨越半个世纪的思想与蓝图](https://foresightnews.pro/article/detail/14783)
- [以太坊简史：因暴雪削弱术士而诞生的千亿美元巨兽](https://foresightnews.pro/article/detail/13531)：以太坊近十年的发展很难用一篇文章概括，但是可以大致浏览每一个阶段的重大突破与变化。了解 VB 创造 ETH 的时候主要想解决什么问题
- [加密思潮编年史，从 25 年前说起](https://foresightnews.pro/article/detail/961)：快速了解加密思潮在不同时期的变化，了解到如何一步步从 BTC 走向 DAPP

### 2. 技术基础 🌟🌟🌟🌟🌟

- [比特币白皮书](https://github.com/xiaolai/bitcoin-whitepaper-chinese-translation)
- [比特币白皮书精读详解](https://mp.weixin.qq.com/s/eYCbAD_tPG9PmuFE1LvCWA)：比特币白皮书精读版是对比特币白皮书更详细的解读，有助于更好的理解白皮书中的内容。比特币的技术原理搞的越清楚越好。
- [以太坊白皮书](https://ethereum.org/en/whitepaper/)：ethereum官方文档
- **比特币白皮书精读版**：白皮书精讲系列是看懂白皮书很好的参考资料，可以更深入的了解白皮书中的细节。这是 ETH1.0 的架构，后面再看 ETH 2.0 的架构。也是搞得越清楚越好，后续的区块链整体上都没有脱离这个架构，既 Chain-VM-共识-Daap
  - [Part1：比特币及现有密码学货币概念介绍](https://zhuanlan.zhihu.com/p/37747240)
  - [Part2：以太坊设计机制](https://zhuanlan.zhihu.com/p/38002875)
  - [Part3：以太坊的应用](https://zhuanlan.zhihu.com/p/38003169)
- [一个以太坊交易的完整周期](https://www.notonlyowner.com/learn/what-happens-when-you-send-one-dai)：这篇文章对具体的每一个环节都有很详细的记录，跟 Daap 的开发结合非常紧密，最好能完整过一遍，然后自己尝试画一个详细的流程图。包括前端怎么跟钱包交互，钱包怎么跟 RPC 交互，节点之间怎么通信，EVM 怎么处理交易，Gas，最后存储等。
- [**Foundry 开发框架**](https://decert.me/tutorial/solidity/tools/foundry/)

### 3. PDFs

- [《精通以太坊：开发智能合约和去中心化应用》](https://github.com/inoutcode/ethereum_book)：机械工业出版社，O'REILLY系列丛书。
- [《精通区块链编程：加密货币原理、方法和应用开发》](https://github.com/tianmingyun/MasterBitcoin2CN/blob/master/SUMMARY.md)：机械工业出版社，O'REILLY系列丛书。
- [《Mastering Bitcoin》](https://github.com/bitcoinbook/bitcoinbook)：《精通区块链编程：加密货币原理、方法和应用开发》的英文原版

### 4. 官方文档

- [ethereum docs](https://ethereum.org/en/developers/docs/)
- [web3.js](https://web3js.readthedocs.io/en/v1.10.0/)
- [geth](https://geth.ethereum.org/)
- [solidity](https://soliditylang.org/)
- [the graph](https://thegraph.com/zh/)
- [Meter](https://meter.io/)：DeFi基础设施
- [OpenZeppelin](https://docs.openzeppelin.com/contracts/5.x/)
- [hardhat](https://hardhat.org/hardhat-runner/docs/getting-started)

### 5. 学习网站

- [DeCert.me](https://decert.me/)
- [Solidity By Example](https://solidity-by-example.org/)
- [Uniswap详解](https://www.rareskills.io/uniswap-v2-book)
- [learnweb3](https://learnweb3.io/)
- [freecodecamp](https://www.freecodecamp.org/news/tag/solidity/)
- [useweb3](https://www.useweb3.xyz/courses)

### 6. 相关资源

- [Remix](https://remix.ethereum.org/)：solidity在线IDE
- [[测试网] sepolia](https://sepolia.dev/)
- [[测试网] goerli](https://goerli.net/)
- [[游戏] 迷恋猫](https://www.cryptokitties.co)：一款知名的web3游戏。
- [[交易所] OpenSea](https://opensea.io/)
- [[交易所] UNISWAP](https://uniswap.org/)
- [[DAO] Botto](https://www.botto.com/community)
- [chainlist](https://chainlist.org/)：EVM网络列表
- [infura](https://www.infura.io/zh)
- [nodiesDLB](https://www.nodies.app/)
- [alchemy](https://www.alchemy.com/)
- [etherscan](https://etherscan.io/)
- [Ethernaut](https://ethernaut.openzeppelin.com/) :合约安全的小挑战。(卡关 推荐D-Squard YT频道)

### 7. 大佬博客

- [郭宇](https://guoyu.mirror.xyz/)：前bytedance前端工程师
- [Preethi Kasireddy](https://www.preethikasireddy.com/)：TruStory CEO
- [pseudoyu](https://www.pseudoyu.com/zh/)：我们可爱的老师

### 8. 其他文章

- [What Are EIP and ERC and How Are They Connected?](https://www.coindesk.com/learn/what-are-eip-and-erc-and-how-are-they-connected/)
- [What happens when you send 1 DAI](https://www.notonlyowner.com/learn/what-happens-when-you-send-one-dai)

## 视频资料

- [《区块链技术与应用》by 北京大学肖臻老师](https://www.bilibili.com/video/BV1Vt411X7JF/)

## Foundry

- [Foundry Book](https://book.getfoundry.sh/)
- [Foundry 常用命令](https://app.heptabase.com/w/3fbd82f11298301c426a2fbaeb6b0bab9322bbba075785ba3788c4acba6a630d)
- [foundry-starter-kit](https://github.com/pseudoyu/foundry-starter-kit)

ERC 相关：

<https://www.coindesk.com/learn/what-are-eip-and-erc-and-how-are-they-connected/>
<https://ethereum.org/en/developers/docs/standards/tokens/erc-20/>
<https://ethereum.org/en/developers/docs/standards/tokens/erc-721/>
<https://celo.academy/t/a-practical-comparison-between-erc-1155-and-erc-721/62>

Demo 项目：

<https://github.com/pseudoyu/exchange-demo-contracts/>

<https://github.com/pseudoyu/social-dApp-demo-contracts>

