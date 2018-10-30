# Web端接口规范  
## 扫码支付  
该接口是在Web页面中嵌入DApp请求用户支付的二维码，使用钱包应用进行扫描，在用户同意的情况下发起转账交易。二维码内容如下： 
```
    {
        "v":"kylinv1",
        "ka":"pay",
        "from":"payeaccount",
        "to": "receiveracnt",
        "tokenid": "42f0e906#eosio.token#EOS#4",
        "actionid":"39c22df9f92470936cddc1ade0e2f2ea",
        "num": "1000.03",
        "userid":"122332",
        "memo": "123456",
        "cb": "https://xxxx.xxx/xxx",
        "dappsymbol":"DAPPONE",
        "sessionid":"xxxxxxxx",
        "msg": "电影票"
    }
```

注：
* v: 支付二维码类型版本信息
* ka: kylin-action 缩写，表明该二维码的动作，支付为 "pay"
* to: 接收币的目的账户
* tokenid: 每个数字资产的唯一标识
* num: 支付数量
* userid: 用户身份ID，可选参数
* actionid: 当前支付订单ID，可选参数
* cb: 钱包支付完成的回调地址，可选参数
* from: 支付账户，可选参数
* dappsymbol: DApp全网唯一的symbol字段, 可选参数
* sessionid: 调用登录以后获取的sessionid，可选参数
* msg: 其他信息，可用作钱包信息呈现，可选参数

如果回调地址不为空，按照以下逻辑处理：
```
Callback URL:
    http://xxx.xx/xxx

POST PARAM
    {
        "actionid":"39c22df9f92470936cddc1ade0e2f2ea",
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
{"from":"","to":"","actionid":"","msg":""} 
```
注：
* actionid：填写支付参数中的 actionid
* from: 填写支付用户在钱包系统中的userid，可选参数
* to: 填写支付参数中的userid，可选参数
* msg: 其他信息，可选参数

## 扫码登录
该接口是在Web页面中嵌入DApp的请求登录二维码，使用钱包应用进行扫描。登录二维码内容如下：
```
    {
        "v": "kylinv1",
        "ka": "login",
        "url": "dappxxx.xx/kylindapp/login/carcode",
        "dappsymbol": "DAPPONE",
        "tokenid":"42f0e906#eosio.token#EOS#4"
    }
```
注：
* v: 版本信息
* ka: kylin-action 缩写，表明该二维码的动作，登录为 "login"
* url: 登录回调地址
* dappsymbol: DApp全网唯一的symbol字段
* tokenid: 此处需要指定tokenid主要是为了针对用户不同币种授权的安全隔离
  
流程逻辑：
	钱包扫码以后根据`dappsymbol`获取DApp相关信息，提醒用户是否确认指定`tokenid`的token进行授权登录，用户同意后将通知DApp：
```
URL:
    dappxxx.xx/kylindapp/login/carcode
    POST:
        v: 版本信息
        dappsymbol: DApp全网唯一的symbol字段
        sessionid: 用户同意后产生的UUID
        platformid: kylinwallet
        accountinfo: Dictionary 获取到的钱包账号信息
    RESPONE:
        code: 错误信息代码，0表示成功
        message: 
```
注：
* accountinfo：获取到的钱包账号信息，可能根据不同的公链有不同的字段返回，但是必须包含以下字段：
    * tokenid: 每个数字资产的唯一标识
    * accountname: String 用户在钱包系统中的userid。如eos中为其eos账号名，eth为公钥地址
    * pubkeys: 针对EOS，需要给出该账户对应的 public keys，比如 {"owner":"xxxxx","active":"xxxx"}
    * nickname: String 昵称，可选参数
    * avatar: String 头像url地址，可选参数
    * balance: double 对应tokenid主代币可用余额，可选参数
    * extra: Dictionary 钱包可选附加信息，可选参数

DApp收到上面的请求以后，通知Web端并将`sessionid`发送给Web端应用。成功以后，开放平台标记该用户登录成功，并设置UUID对应的登录有效期。在后续的检查中可以根据UUID来控制一次Session的有效时间。

## 扫码执行合约
该接口是在Web页面中嵌入DApp请求用户执行合约的二维码，使用钱包应用进行扫描，在用户同意的情况下发起交易。二维码内容如下：
```
    {
        "v":"kylinv1",
        "ka":"contract",
        "msg":"给xxx转账",
        "tokenid":"42f0e906#eosio.token#EOS#4",
        "account":"payeaccount",
        "address": "xxxxxxxxxxxxxxxx",
        "actions": [
            {
                account: "eosio.token",
                name: "transfer",
                authorization: [{
                    actor: "aaaabbbbcccc",
                    permission: "active"
                }],
                data: {
                    from: "aaaabbbbcccc",
                    to: "itokenpocket",
                    quantity: "1.3000 EOS",
                    memo: "something to say"
                }
            }
        ],
        "options": {
            broadcast: true
        },
        "actionid":"39c22df9f92470936cddc1ade0e2f2ea",
        "cb": "https://xxxx.xxx/xxx",
        "dappsymbol":"DAPPONE",
        "sessionid":"xxxxxxxx"
    }
```

注：
* v: 支付二维码类型版本信息
* ka: kylin-action 缩写，表明该二维码的动作，合约调用为 "contract"
* tokenid: 每个数字资产的唯一标识
* account: 当前帐号
* address: 当前帐号对应的公钥地址，钱包会拿该地址对应的私钥进行签名
* msg:  其他信息，可用作钱包信息呈现，可选参数
* options: 合约options，可选参数
* actionid: 当前标识该此次调用的ID，可选参数
* cb: 钱包支付完成的回调地址，可选参数
* dappsymbol: DApp全网唯一的symbol字段, 可选参数
* sessionid: 调用登录以后获取的sessionid，可选参数

如果回调地址不为空，按照以下逻辑处理：
```
Callback URL:
    http://xxx.xx/xxx

POST PARAM
    {
        "actionid":"39c22df9f92470936cddc1ade0e2f2ea",
        "txid":"xxxxxxxxxxxx"
    }

RESPONSE
    {
        "code":"错误信息代码，0表示成功",
        "message": "错误信息"
    }
```
钱包调用合约时需要在交易备注中添加如下形式信息:
```
{"from":"","actionid":"","msg":""} 
```
注：
* actionid：填写参数中的 actionid
* from: 发起合约操作账号名称，可选参数
* msg: 其他信息，可选参数

