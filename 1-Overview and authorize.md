# 概述与授权 

**为了降低使用复杂度，针对转账支付接口(transfer)可以*直接发起调用*，不用提前注册DApp，但是请各钱包应用提醒用户转账风险；除此之外，还可以结合DApp注册机制实现安全可靠的支付功能。**

本接口规范起于对EOS、EUN的支持，但是从设计上来说同样支持BTC、ETH等已有其他数字资产。

### Token的唯一标识
由于现在存在POW、DPOS等多种不同链的数字通证，为了唯一标识一个token需要四个字段：
* chainid: 该币所在链chainid 或者 NUM #0 block hash
* contract: token的合约地址或者账户地址，可以为空，比如BTC
* tokenname: token名称
* precision: 币种精度，十进制，比如 4 就是精确到 10^-4，18 就是 10^-18

在该 Specification 中，我们统一使用 `tokenid` 来代表一个数字通证的唯一标识，其组成如下：
```
    chainid[:8]#contract[:16]#tokenname#precision
```

比如：
```
    EOS: 42f0e906#eosio.token#EOS#4
    BTC: 0a8ce26f##BTC#8
    ETH: b1cb8fa3##ETH#18
    ERC20 EOS: b1cb8fa3#78ecfdb0#EOS#18
```

### DAPP的唯一标识
现在有很多支持DAPP的钱包或者平台，为了保证一个DAPP在不同平台上面无缝切换，避免每次调用都需要传递DAPP各种信息，需要有个跨平台的唯一ID来对应每个DAPP，这样方便不同平台进行识别同一个DAPP。
为了保证更高的安全性，DAPP应该给各平台注册同一个ID，另外提交自己针对每种币的收款账户，防止被其他应用假冒，导致用户资产损失。 

在该 Specification 中，我们统一使用 `symbol` 来代表一个DAPP的唯一标识，为简单起见，采用精确到毫秒的Unix时间戳，示例如下：
```
    unix timestamp millisecond, ex: 154017876810
```
 
下面是建议的DAPP提供的信息示例： 

| symbol | dapp_name | dapp_scheme | account_info | org | description |
| ----------- | ----------- | ----------- | ----------- | ----------- | ----------- |
| 154017876810 | {"cn":"游戏达人","en":"dappone"} | KylinDappDemo | [{"tokenid":"42f0e906#eosio.token#EOS#4","account":"wallet4bixin","memo":"123123"}] | {"name":"DAPPONE","website":"http://dappone.com/","email":"dappone@outlook.com","branding":{"logo":"http://dappone.com/pic/logo.png","cover":"http://dappone.com/pic/cover.png"},"social_network":{"steemit":"https://steemit.com/eos/@dappone","twitter":"https://twitter.com/CIGEOS","facebook":"https://www.facebook.com/cigeos","telegram":"https://t.me/cigeos"}} | {"cn":"第一款超级dapp游戏","en":"This is a super DAPP"} |
注: 
* symbol: 全局唯一的DApp自己的标识，并在各个DApp统一使用，Unix timestamp 
* account_info: DApp预先注册的收款账户地址，
* dapp_scheme: dapp的scheme，可供iOS添加scheme白名单使用 

<br>

# DApp开放平台认证授权逻辑
## 签名授权机制

DApp在开放平台可以申请自己的secretkey(长度大于32B)进行数据签名，保证数据安全和请求的有效性，签名计算方法为：
```
signature = base64(hmac-sha1(secretkey, ( timestamp + ‘\n’+ params_str)))

timestamp: unix 时间戳
params_str: 参数名name按照字典序从小到大排序，然后 ‘,’.join(name+’:’value)
```
HTTPS 请求时 HEAD里面增加 Authorization 字段内容如下：
```
	accesskey + ":" + signature
``` 
注:  
* `/kylindapp/login` 接口需要使用该签名，其余接口参数中包含`sessionid`即可。

## DApp应用在开放平台中注册
让DApp注册的目的是明确DApp在当前开放平台的身份信息，推荐钱包平台要启用KYC验证。类似于支付宝商家认证，最终是为了保证用户权益。每个DApp都会分配一个唯一dapp_id用于在平台内部标识。
```
    URL:
        /kylindapp/register
    POST PARAM: 
        dappsymbol: DApp唯一标识，在各个开放平台要一致
    RESPONSE:
        code: 错误信息代码，0表示成功
        message: symbol已存在|DAPP名称已被注册|参数异常
        dapp_id: DApp的唯一标识，建议使用UUID，保证在不同平台的唯一性
        platformid: 开放平台标识
        accesskey: 返回的默认accesskey
        secretkey: 返回的默认secretkey 
```

## DApp应用申请密钥对
DApp与开放平台进行交互时需要确认身份，采用隔离性更好的AccessKey 和 SecretKey机制。
```
    URL:
        /kylindapp/request/accesskey
    POST PARAM: 
        dapp_id: 112
        platformid
        tag : 申请业务标识 32 B 英文字符，为后面拓展开放平台功能预留 
        sessionid
    RESPONSE:
        code: 错误信息代码，0表示成功
        message 
        accesskey 
        secretkey 
```
## DApp应用在开放平台中解除注册应用信息
该接口主要是用于注销\锁定一个DApp授权，调用以后该 dapp_id 对应的Accesskey都将会禁止。
```
    URL:
        /kylindapp/unregister
    POST PARAM: 
        dapp_id: 112
        platformid
        sessionid
    RESPONSE:
        code: 错误信息代码，0表示成功
        message: 
```