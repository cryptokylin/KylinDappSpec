### *为了在易用性前提下保留安全性，该文档会分成两部分：第一部分是针对获取用户信息、转账等高频场景定义简单直接的接口，安全性主要依靠用户个人意识；第二部分是针对开放平台提供的安全实施建议方案。*

# Web端接口规范  
* ## 扫码支付  
该接口是在Web页面中嵌入DApp请求用户支付的二维码，使用钱包应用进行扫描，在用户同意的情况下发起转账交易。二维码内容如下： 
```
    {
        "v":"kylinv1",
        "from":"payeaccount",
        "to": "receiveracnt",
        "token": "EOS",
        "chainid":"f0e906",
        "contract":"eosio.token"
        "billid":"39c22df9f92470936cddc1ade0e2f2ea",
        "num": "1000.03",
        "memo": "123456",
        "cb": "https://xxxx.xxx/xxx",
        "dappname":"DAPPONE"
    }
```

注：
* v: 支付二维码类型版本信息
* to: 接收币的目的账户
* token: 该币的symbol
* chainid: 该币所在链chainid 或者 #1 block hash的后6位
* contract: 该币的合约地址
* num: 支付数量
* userid: 用户身份ID，可选参数
* billid: 当前支付订单ID，可选参数
* cb: 钱包支付完成的回调地址，可选参数
* from: 支付账户，可选参数
* dappname: DApp的名称, 可选参数

如果回调地址不为空，按照以下逻辑处理：
```
Callback URL:
    http://xxx.xx/xxx

PARAM
    {
        "billid":"39c22df9f92470936cddc1ade0e2f2ea",
        "txid":"xxxxxxxxxxxx"
    }

RESPONSE
    {
        "code":"错误信息代码，0表示成功",
        "message": "错误信息"
    }
```
钱包支付时需要在交易备注中添加如下形式信息:
```
{"from":"","to":"","billid":"","msg":""} 
```
注：
* billid：填写支付参数中的 billid
* from: 填写支付用户在钱包系统中的userid，可选参数
* to: 填写支付参数中的userid，可选参数
* msg: 其他信息，可选参数

<br/>  

# JavaScript 接口规范  
* ## 支付接口
```
Kylin.{TOKEN}.transfer(from, to, token, contract, num, memo, gas, gas_price)

PARAM:
    to: String 接收币的目的账户, 
    token: String 该币的symbol
    contract: String 该币的合约地址
    num: String 支付数量
    from: String 支付账户，可选参数
    memo: String 转账备注，可选参数
    gas: Number|String|BigNumber btc、etc gas 数量，可选参数
    gas_price: Number|String|BigNumber btc、etc gas 价格，可选参数

RETURN:
    Object:
        code: Int 错误信息代码，0表示成功
        txid: String, 转账id
        msg: String, 其他信息
```  
注：
* TOKEN：
    * eos: EOS token
    * enu: ENU token

钱包支付时需要在交易备注中添加如下形式信息:
```
{"from":"","to":"","billid":"","msg":""} 
```
注：
* billid：填写支付参数中的 billid
* from: 填写支付用户在钱包系统中的userid，可选参数
* to: 填写支付参数中的userid，可选参数
* msg: 其他信息，可选参数
  
<br/>  

# APP监听消息接口规范 
* ## 系统消息注册
    * 默认消息监听：kylindapp://category/method?params=paramsBase64String
    * 具体钱包注册自己的监听，但要以 `kylindapp_` 开头，目前有如下记录:
        * kylindapp_meetone://
        * kylindapp_tokenpacket://
注：
* category: 不同的功能分类
    * eos: EOS token 相关
    * enu: ENU token 相关
    * wallet: wallet 相关功能
* method: 调用方法名，比如 transfer, get_account
* params: 调用参数，格式如下：paramsJson.toString('utf-8').base64String()

* ## 系统消息回调接口
钱包完成DApp的调用以后，如果参数中有`cb`参数，除了下面给出的必须参数外，还需要根据不同接口按照要求传递其他参数。
```
    dappxxx://kylin/callback?params=paramsBase64String

    PARAM:
        code: Int 错误信息代码，0表示成功
        msg: String, 其他信息
        path: String, 处理请求的调用路径，比如 /eos/transfer
```

* ## 支付接口
```
kylindapp://{TOKEN}/transfer?params=paramsBase64String

PARAM:
    to: String 接收币的目的账户, 
    token: String 该币的symbol
    contract: String 该币的合约地址
    num: String 支付数量
    memo: String 转账备注，可选参数
    billid: 当前支付订单ID，可选参数
    gas: Number|String|BigNumber btc、etc gas 数量，可选参数
    gas_price: Number|String|BigNumber btc、etc gas 价格，可选参数
    from: String 支付账户，可选参数
    dappname: DApp的名称，可选参数
    cb: 回调接口，回调参数至少包含如下参数：
         txid: String, 转账id
         billid: String, 传递过来的参数billid
```  
注：
* TOKEN：
    * EOS: eos
    * ENU: enu 

钱包支付时需要在交易备注中添加如下形式信息:
```
{"from":"","to":"","billid":"","msg":""} 
```
注：
* billid：填写支付参数中的 billid
* from: 填写支付用户在钱包系统中的userid，可选参数
* to: 填写支付参数中的userid，可选参数
* msg: 其他信息，可选参数







