# KylinDappSpec

KylinDApp Open Platform Specification 由 [CryptoKylin](https://github.com/cryptokylin) 小组成员 EOSBIXIN 与 MEET.ONE、TokenPocket 等钱包同学一起发起制定。KylinDApp Open Platform Specification 主要目的是制定统一的 DApp (包含Web(JS)、Hybird(JSBridge)、Native(System Register Callback)) 应用与钱包、交易所开放平台之间的一套接口协议，使得遵循该协议开发的DApp可以在不同的钱包和交易所之间使用，无需再进行接口适配。

注： 
* 本文档中的所有接口均是 HTTPS 请求
* Content-Type: application/json

协议规范分为了4部分：
* 1-Overview and Authorize.md
* 2-Web JS SPEC.md
* 3-APP H5 SDK SPEC.md
* 4-APP Native SPEC.md
  
针对DApp的开发者，可以直接使用转账、智能合约的调用；针对钱包等开放平台可以提供DApp的注册授权功能，以提供更安全的支付服务。


