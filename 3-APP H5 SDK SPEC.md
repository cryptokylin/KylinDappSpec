# JavaScript 接口规范
* ## 直接兼容Scatter的接口
```
链接地址:
https://get-scatter.com/docs/dev/getting-started
```

* ## 支付接口
```
Kylin.{TOKEN}.transfer(from, to, tokenid, num, memo, sessionid)

PARAM:
    to: String 接收币的目的账户, 
    tokenid: tokens_info.json 中的每个数字资产的唯一标识
    num: String 支付数量
    from: String 支付账户，可选参数
    memo: String 转账备注，可选参数
    sessionid: 调用登录以后获取的sessionid，可选参数

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
    * btc: Bitcoin
    * 更多参看 tokens_info.json

钱包支付时需要在交易备注中添加如下形式信息:
```
{"from":"","to":"","billid":"","msg":""} 
```
注：
* billid：填写支付参数中的 billid
* from: 填写支付用户在钱包系统中的userid或者用户地址，可选参数
* to: 填写支付参数中的userid，可选参数
* msg: 其他信息，可选参数

* ## 请求登录授权
```
Kylin.wallet.login(dapp_symbol)

PARAM:
    dapp_symbol: dapps_info.json中DApp全网唯一的symbol字段, 可选参数

RETURN:
    Object:
        code: Int 错误信息代码，0表示成功
        msg: String, 其他信息
        sessionid: 用户同意后产生的UUID
        platform_id: kylinwallet
```  