### *为了在易用性前提下保留安全性，该文档会分成两部分：第一部分是扫码即用的支付接口，钱包应用需要做好安全性提示；第二部分是针对钱包开放平台提供的整套DApp认证、授权逻辑。*

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
        "dappname":"DAPPONE",
        "sessionid":"xxxxxxxx"
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
* sessionid: 调用登录以后获取的sessionid，可选参数

如果回调地址不为空，按照以下逻辑处理：
```
Callback URL:
    http://xxx.xx/xxx

POST PARAM
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
Kylin.{TOKEN}.transfer(from, to, token, contract, num, memo, gas, gas_price, sessionid)

PARAM:
    to: String 接收币的目的账户, 
    token: String 该币的symbol
    contract: String 该币的合约地址
    num: String 支付数量
    from: String 支付账户，可选参数
    memo: String 转账备注，可选参数
    gas: Number|String|BigNumber btc、etc gas 数量，可选参数
    gas_price: Number|String|BigNumber btc、etc gas 价格，可选参数
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
    sessionid: 调用登录以后获取的sessionid，可选参数
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

<br/>  

# DApp开放平台认证授权逻辑
* ## 签名授权机制

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
    `/kylindapp/login` 接口需要使用该签名，其余接口参数中包含`sessionid`即可。

* ## DApp应用在开放平台中注册
让DApp注册的目的是明确DApp在当前开放平台的身份信息，推荐钱包平台要启用KYC验证。类似于支付宝商家认证，最终是为了保证用户权益。每个DApp都会分配一个唯一dapp_id用于在平台内部标识。
```
    URL:
        /kylindapp/register
    POST PARAM: 
        dapp_name: 本土名称
        dapp_name_en: 英文名称
        dapp_symbol: DApp唯一标识，在各个开放平台要一致
        dapp_logo_256_png: 
        website: 官网
        contact: 联系人
        phone: 联系电话
        description: DApp其他描述
    RESPONSE:
        code: 错误信息代码，0表示成功
        message
        dapp_id: DApp的唯一标识，建议使用UUID，保证在不同平台的唯一性
        platform_id: 开放平台标识
        accesskey: 返回的默认accesskey
        secretkey: 返回的默认secretkey 
```

* ## DApp应用申请密钥对
DApp与开放平台进行交互时需要确认身份，采用隔离性更好的AccessKey 和 SecretKey机制。
```
    URL:
        /kylindapp/request/accesskey
    POST PARAM: 
        dapp_id: 112
        platform_id
        tag : 申请业务标识 32 B 英文字符，为后面拓展开放平台功能预留 
    RESPONSE:
        code: 错误信息代码，0表示成功
        message 
        accesskey 
        secretkey 
```
* ## DApp应用在开放平台中解除注册应用信息
该接口主要是用于注销\锁定一个DApp授权，调用以后该 dapp_id 对应的Accesskey都将会禁止。
```
    URL:
        /kylindapp/unregister
    POST PARAM: 
        dapp_id: 112
        platform_id
    RESPONSE:
        code: 错误信息代码，0表示成功
        message: 
```
<br>

* ## DApp钱包应用扫二维码进行登录，适用于Web
该接口是在Web页面中嵌入DApp的请求登录二维码，使用钱包应用进行扫描。登录二维码内容如下：
```
    URL:
        dappxxx.xx/kylindapp/login/carcode?dapp_symbol=XXXXX
```

流程逻辑：
	钱包扫码以后根据`dapp_symbol`获取DApp相关信息，提醒用户是否确认登录，用户同意后将通知DApp：
```
URL:
    dappxxx.xx/kylindapp/login/carcode
    POST:
        sessionid: 用户同意后产生的UUID
        platform_id: kylinwallet
    RESPONE:
        code: 错误信息代码，0表示成功
        message: 
```
DApp收到上面的请求以后，通知Web端并将`sessionid`发送给Web端应用。成功以后，开放平台标记该用户登录成功，并设置UUID对应的登录有效期。在后续的检查中可以根据UUID来控制一次Session的有效时间。

* ## App请求登录授权
由于存在安装多个钱包的情况，所以需要先看用户使用哪个钱包打开，钱包根据`dapp_symbol`获取DApp相关信息，提醒用户是否确认登录，确认登录后通过`cb`回调应用. 
```
kylindapp://wallet/login/request?params=paramsBase64String

PARAM:
    dapp_symbol: DApp唯一标识，在各个开放平台要一致
    cb: 回调接口，回调参数至少包含如下参数：
        code: Int 错误信息代码，0表示成功
        msg: String, 其他信息
        sessionid: 用户同意后产生的UUID
        platform_id: kylinwallet
``` 

* ## JavaScript请求登录授权
```
Kylin.wallet.login(dapp_symbol)

PARAM:
    dapp_symbol: DApp唯一标识，在各个开放平台要一致

RETURN:
    Object:
        code: Int 错误信息代码，0表示成功
        msg: String, 其他信息
        sessionid: 用户同意后产生的UUID
        platform_id: kylinwallet
```  