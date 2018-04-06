
## 个人信息

 - 陈祥龙，男，1992 年 10 月生于湖南
 - 2014 年 07 月毕业于中北大学飞行器制造工程专业，本科学历
 - 手机：13761223471
 - Email：shannonchenchn@foxmail.com
 - 工作年限：3 年半（iOS 开发经验 2 年半）
 - 应聘职位：iOS 开发工程师
 - Github：[https://github.com/ShannonChenCHN](https://github.com/ShannonChenCHN)
 - 博客：[http://www.jianshu.com/u/4ef5e287fc91](http://www.jianshu.com/u/4ef5e287fc91)


## 工作经历


#### 上海悦会信息科技有限公司 （2016 年 08 月至今）
**职位**：iOS 开发工程师     
**职责**：参与 YHOUSE、OnlyU（独立完成）等多款产品的开发和维护，负责部分技术文档的维护。

#### 宝宝树的电商-美囤妈妈 （2015 年 10 月 ~ 2016 年 08 月）
**职位**：iOS 开发工程师      
**职责**：参与宝宝树孕育、美囤妈妈等产品的开发和维护，并在后期临时担任过 iOS 团队负责人（5 人团队）。

#### 中航工业江西洪都航空工业集团有限责任公司 （2014 年 07 月 ~ 2015 年 09 月）
**职位**：飞机装配工艺工程师    
**相关经历**：在此期间，通过自学入门 iOS 开发，先后学习了 Objective-C 语言和 Cocoa Touch 框架等 iOS 开发相关知识，并独立完成了 2 个完整项目。

## 项目经历
2 年多来先后参与了 6 个项目的开发，主要项目以及负责的主要工作如下：

#### 达人猫（电商平台）

- 项目整体架构的设计和搭建
- 网络层的搭建
- 路由系统设计
- 引入 OHHTTPStubs 工具进行 API mock 调试，以提高开发效率

#### YHOUSE（美食玩乐预定）

- gif-like 视频播放控件
- 为了更方便地实现常见的列表，抽象了一个轻量级的数据驱动列表框架：[YHListKit](https://github.com/ShannonChenCHN/YHListKit)，让实现 feeds 流列表的过程就像写配置文件一样简单
- 图文快照功能模块设计
- Hybrid 升级
  - 将 UIWebView 迁移到 WKWebView
  - 设计一个同时支持 UIWebView 和 WKWebView 的容器：SCWebBrowserView 
  - 架构上的优化：引入 WebViewJavaScriptBridge 框架，并对其进行封装，以改进 JS 端的调用方式和原生端的“插件化”设计


#### 宝宝树孕育（母婴电商）

- 采用数据源思想，设计了一个低耦合的、可复用的三级分类列表控件
- UIWebView 加载 WebP 图片
- 多个 APP 间共享同一设备唯标识
- 实现带有吸顶效果的 “cell header”，并设计了一个可复用的框架 SCStickyCellHeaderCollectionView
- 通过 “分类 + runtime” 的形式优雅地实现 UITabBarButton 上的自定义 badge view
- 通过 Instrument 分析工具找出机身发热的元凶 —— 导航栏中跑马灯的 bug 导致 CPU 消耗过高


## 开源项目和作品
#### 技术文章
- [WebViewJavascriptBridge 从原理到实战](http://www.jianshu.com/p/6f34903be630)
- [SDWebImage 源码解析](http://www.jianshu.com/p/06f0265c22eb)
- [图文快照分享框架的实现](http://www.jianshu.com/p/b3fcb449cb35)

#### 开源项目
- [YHListKit](https://github.com/ShannonChenCHN/YHListKit) （Star 66）：一个轻量级的数据驱动列表框架。
- [SCWebBrowserView](https://github.com/ShannonChenCHN/SCWebBrowserView)：基于 UIWebView 和 WKWebView 的封装的 web view 容器。
- [SCGoJD](https://github.com/ShannonChenCHN/SCGoJD)（Star 72）：一个非官方京东 iOS 客户端。

## 技能清单
除了公司项目中用到的 Objective-C 之外，还利用业余时间学习了数据结构和算法、计算机网络、 Swift 和前端相关知识技能（包括 JavaScript/HTML/CSS 和 React Native）。
