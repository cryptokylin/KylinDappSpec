# APP监听消息接口规范 
* ## 系统消息注册
    * 默认消息监听：kylindapp://{category}/method?params=paramsBase64String
    * 具体钱包注册自己的监听，但要以 `kylindapp_` 开头，比如:
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
钱包完成DApp的调用以后，如果参数中有`cb`参数，除了下面给出的**必须参数**外，还需要根据不同接口按照要求传递其他参数。
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
    tokenid: tokens_info.json 中的每个数字资产的唯一标识
    num: String 支付数量
    memo: String 转账备注，可选参数
    billid: 当前支付订单ID，可选参数
    from: String 支付账户，可选参数
    dappsymbol: dapps_info.json 中DApp全网唯一的symbol字段, 可选参数
    sessionid: 调用登录以后获取的sessionid，可选参数
    cb: 回调接口，回调参数至少包含如下参数：
         txid: String, 转账id
         billid: String, 传递过来的参数billid
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
* from: 填写支付用户在钱包系统中的userid，可选参数
* to: 填写支付参数中的userid，可选参数
* msg: 其他信息，可选参数

* ## 请求登录授权
由于存在安装多个钱包的情况，所以需要先看用户使用哪个钱包打开，钱包根据`dapp_symbol`获取DApp相关信息，提醒用户是否确认登录，确认登录后通过`cb`回调应用. 
```
kylindapp://wallet/login/request?params=paramsBase64String

PARAM:
    dapp_symbol: dapps_info.json 中DApp全网唯一的symbol字段
    cb: 回调接口，回调参数至少包含如下参数：
        code: Int 错误信息代码，0表示成功
        msg: String, 其他信息
        sessionid: 用户同意后产生的UUID
        platform_id: wallet4bixin
``` 
