# Serverless-webide

> 由自邮之翼（free4inno）团队开发的 Serverless VSCode webide

## 介绍 & 演示

本项目基于 Serverless 架构实现了一款轻量化、多用户的 VSCode webide。充分利用了阿里云函数计算（FC）服务、对象存储（OSS）服务所提供的功能。整体采用 Java 与 Go 语言进行实现。该 webide 主要具有以下特点：

- 多用户，多租隔离；
- 用户自定义个人配置，海量可选插件；
- 多工作区，方便项目管理，支持协同编辑；
- 秒级启动，即用即走，工作区数据实时保存；

- 后端弹性函数池，充分利用函数计算资源。

我们目前提供了一个演示视频，对本项目进行了展示：

[自邮之翼-2022队WebIDE演示视频.mp4](https://www.aliyundrive.com/s/AhrdtXka6DG)
（您也可以在项目根目录下找到该视频）

同时，目前本项目已经在线上部署 demo 供各位评委体验：

[webide.free4inno.com](http://webide.free4inno.com/)

> 注意！为防止恶意过度使用 demo 资源，目前仅开放了 2 个测试账号用于体验，同时限制了单个用户最大激活状态工作区数量为 3
>
> - 测试账号一：demo-01 / abc123
>
> - 测试账号二：visitor1 / password1

具体的应用使用流程以及关于本项目的更多详细详细信息请参见下文“应用详情”与“系统架构”。

## 应用详情

### 目录说明

```
- serverless-webide
	- webide-core 		# core 核心模块 (Java - SpringBoot)
	- webide-server-fc 	# function 函数计算服务所用函数 (Go)
	- webide-front      # front 前端模块
	- 自邮之翼-2022队WebIDE演示视频.mp4
    - README.md 
```

### 功能 & 使用流程

本项目所提供的 webide主要具有以下功能：

- 用户账户：基于账号密码登录，多用户，多租隔离；
- 用户配置：用户可自定义个人配置，海量可选插件；
- 工作区机制：独立代码空间，分项目持久化；
- 工作区激活：绑定函数，秒级启动，一键转到 webide；
- 工作区共享：分享链接，支持协同编辑；
- 工作区释放：即用即走，工作区数据实时保存；

- 函数负载弹性自适应算法：后端弹性函数池，自动扩容缩容，充分利用函数计算资源。

以下是系统的具体使用流程：

① 进入 webide 首页后，首先您需要登录。如果您已有账号即可直接登录；如果您没有账号则需要注册（系统具有注册功能，但是在demo中并未开放）。② 完成登录后，您可以看到工作区列表，工作区的概念类似于仓库，您可以创建出多个仓库来持久化您不同的项目。工作区具有激活/未激活状态，未激活的状态下工作区不可被使用，因此在创建工作区后需要激活您的工作区。③ 完成工作区激活后，您可以点击链接一键跳转到该工作区下的 ide 内，激活与启动 ide 的过程都是秒级的。④ 进入 ide 后，您可以自由配置各类插件、调整 ide 偏好，这些配置都是与用户绑定的，即您在不同的工作区内将会共享这些配置；您可以自由编写代码，这些数据都是安全隔离、实时保存的；此外，工作区还支持协同编辑，您可以将工作区 ide 的链接分享给其他人，打开页面后即可实时同步、共同完成项目。⑤ 在结束工作区的使用后，您可以回到工作区列表释放该激活的工作区（demo中限制了单个用户最大激活工作区数量为 3），该工作区的代码与状态会被保存，并释放函数资源避免浪费。

![image](https://yuncodeweb.oss-cn-hangzhou.aliyuncs.com/uploads/zhaoht2022/serverless-webide/a2a50416687d289c86d80a1ae7ee0ac0/image.png)

## 技术架构

### 系统架构图

目前该系统整体的系统架构图如下：

![image](https://yuncodeweb.oss-cn-hangzhou.aliyuncs.com/uploads/zhaoht2022/serverless-webide/a60173b05df687f415180ec5a6b17922/image.png)

- 最顶层为用户交互层 webide-front，负责前端页面展示，与后端 webide-core 通过 restful-api 连接；

- 第二层为系统核心层为 webide-core，其中维护了函数资源池，包含有函数负载弹性自适应算法、工作区激活释放调度算法等。同时负责持久化各类系统资源，包括用户、工作区等；
- 第三层为函数资源层，该层是利用阿里云函数计算（FC）服务所创建出的各个函数，由 webide-core 负责维护管理并调度给工作区使用。这些函数是基于官方 webide 函数示例改造而成的，主要作用是提供最底层的 VSCode webide 服务；
- 最底层为持久化层，一方面通过 MySQL 持久化存储用户与工作区的基本信息，另一方面通过阿里云对象存储（OSS）服务所提供的 bucket 存储用户的 ide 配置、工作区代码。

### 技术细节

- 多用户数据隔离

多租隔离的基本实现思路是，首先为每个用户分配一个不重复的独立 code，通过在 OSS bucket 中基于该 code 建立不同目录独立存取。与用户绑定的数据为 ide 的配置、插件数据。另外为每个用户分配多个工作区，基于工作区概念进一步进行多级隔离。

- 工作区激活与释放

工作区激活的过程本质上是通过修改环境变量与绑定自定义域名的方式，将工作区与 FC 中的函数实现关联。我们修改了示例函数 demo 中数据路径存取地址的配置方式，从配置文件读取改为环境变量读取，使得统一函数可以支持多个工作区的反复使用，提高了函数资源利用率。同时，充分利用了 FC 所提供的自定义域名绑定功能，在工作区激活时，按照工作区生成域名并绑定到函数，使得函数能够被用户访问，且在释放过程中将会解绑这一域名，保证隔离性与安全性。与工作区绑定的数据为 ide 中的代码数据。

- 函数的创建与删除

函数的概念即为阿里云函数计算（FC）服务中的函数概念，函数部分的代码是基于官方提供的示例 demo 改写而成的。制作了 layer 用于存放公用的 OpenVSCode webide 基础环境；制作了 code.zip 代码包用于存放编译后的可执行文件，并上传到 OSS. 最终在创建、删除的过程中，利用 webide-core 调用函数计算的 sdk，实现函数创建、触发器创建等具体操作。

- 函数资源池

本项目中设计了函数资源池用于管理系统所使用的函数资源，旨在通过构建可被多个工作区反复利用的服务函数来优化启动速度以及资源利用率。

函数资源池使用了“函数负载弹性自适应算法”来保证用户激活工作区时总能立即分配到函数，有效减少了冷启动时需要拉取代码包与层、创建函数、绑定触发器等过程所造成的时延开销；同时能够根据目前活跃的工作区数量自适应调整资源池中的函数保有量，避免了过度开销造成的不必要浪费。

![image](https://yuncodeweb.oss-cn-hangzhou.aliyuncs.com/uploads/zhaoht2022/serverless-webide/e09d3a116857c9ccb5bca3ab89aa196c/image.png)

如图所示，目前函数资源池中存在4个函数，其中 func-1 绑定到了 workspace-1，其余函数均为空闲（即没有绑定域名、分配工作区，没有启动实例的函数）；存在3个工作区，只有 workspace-1 是激活状态。如果用户此时希望立即激活 workspace-2，那么将会分配 func-2 给 workspace-2 进行绑定。绑定后的资源情况如下。

![image](https://yuncodeweb.oss-cn-hangzhou.aliyuncs.com/uploads/zhaoht2022/serverless-webide/fb3bb58c13b9450131a27c9ea8011d53/image-20220904153126125.png)

在“函数负载弹性自适应算法”中，其中需要设置两个参数 `MIN_LEFT_FUNC` 与 `MAX_REST_FUNC` 。这两个参数分别代表函数资源池中保有的空闲函数的最小与最大值。当空闲函数的数量过低时将会自动扩容到 `MIN_LEFT_FUNC` ，当空闲函数的数量过低时将会自动缩容到  `MAX_REST_FUNC` 。目前，我们设置这两个参数分别为 3 和 5，因此对于上述图片将会自动创建一个新的函数加入资源池。

![image](https://yuncodeweb.oss-cn-hangzhou.aliyuncs.com/uploads/zhaoht2022/serverless-webide/e884088e9d4cc98bd810140c1b461290/image-20220904153618178.png)





