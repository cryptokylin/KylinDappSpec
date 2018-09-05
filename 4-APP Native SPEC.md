# APP监听消息接口规范 
* ## 系统消息注册
    * 默认消息监听：kylindapp://method_path?params=paramsBase64String
    * 具体钱包注册自己的监听，但要以 `kylindapp_` 开头，比如:
        * kylindapp_meetone://
        * kylindapp_tokenpacket://
注：
* method_path: 调用方法名，比如  transfer, wallet/get_account
* params: 调用参数，格式如下：paramsJson.toString('utf-8').base64String()

* ## 钱包回调接口
钱包完成DApp的调用以后，会发起此回调，回调参数中除了下面给出的**参数**外，还会根据不同接口传递其他参数。
```
    dappxxx://kylin/callback?params=paramsBase64String

    PARAMS:
        code: Int 错误信息代码，0表示成功
        msg: String, 其他信息
        path: String, 处理请求的调用路径，比如 wallet/login/request
        platform_id: String e.g.wallet4bixin
        authorization: String 将dapp发起请求时所携带的authorization参数原样返回做认证
```
注：
* dappxxx: 为dapp客户端自身注册的scheme。可通过dapps_info.json 中DApp全网唯一的symbol查到。

* ## 支付接口
```
kylindapp://transfer?params=paramsBase64String

PARAMS:
    to: String 接收币的目的账户, 
    tokenid: tokens_info.json 中的每个数字资产的唯一标识
    num: String 支付数量
    memo: String 转账备注，可选参数
    billid: 当前支付订单ID，可选参数
    from: String 支付账户，可选参数
    dappsymbol: dapps_info.json 中DApp全网唯一的symbol字段, 可选参数
    authorization: String 认证，格式为 accesskey + ":" + signature

CALLBACK: 回调接口，回调参数至少包含如下参数：
    txid: String, 转账id
    billid: String, 传递过来的参数billid
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

* ## 请求登录授权
由于存在安装多个钱包的情况，所以需要先看用户使用哪个钱包打开，钱包根据`dapp_symbol`获取DApp相关信息，提醒用户是否确认登录，用户只需在钱包选择一个已导入钱包账号进行授权登录. 
```
kylindapp://wallet/login/request?params=paramsBase64String

PARAMS:
    tokenid: tokens_info.json 中的每个数字资产的唯一标识，指定需要哪个币种的账号，可选参数
    dapp_symbol: dapps_info.json 中DApp全网唯一的symbol字段
    authorization: String 认证，格式为 accesskey + ":" + signature

CALLBACK: 回调接口，回调参数至少包含如下参数：
    account_info: Dictionary 获取到的钱包账号信息
``` 

注：
* account_info：获取到的钱包账号信息，可能根据不同的公链有不同的字段返回，但是必须包含以下字段：
    * tokenid: tokens_info.json 中的每个数字资产的唯一标识
    * account_name: String 用户在钱包系统中的userid。如eos中为其eos账号名，eth为公钥地址
    * nickname: String 昵称，可选参数
    * avatar: String 头像url地址，可选参数
    * balance: double 对应tokenid主代币可用余额，可选参数
    * extra: Dictionary 钱包可选附加信息，可选参数

* ## 获取钱包签名
由于存在安装多个钱包的情况，所以需要先看用户使用哪个钱包打开，钱包根据`dapp_symbol`获取DApp相关信息，提醒用户是否确认授予签名. 
```
kylindapp://wallet/sign/request?params=paramsBase64String

PARAMS:
    tokenid: tokens_info.json 中的每个数字资产的唯一标识，指定需要哪个币种的账号
    account_name: String 提供签名的钱包账号在钱包系统中的userid。如eos中为其eos账号名，eth为公钥地址
    memo: String 获取钱包签名备注，可选参数
    dappsymbol: dapps_info.json 中DApp全网唯一的symbol字段, 可选参数
    authorization: String 认证，格式为 accesskey + ":" + signature
        

CALLBACK: 回调接口，回调参数至少包含如下参数：
    sign: String 钱包签名
``` 
