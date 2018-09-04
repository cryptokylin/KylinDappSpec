# Web端接口规范  
## 扫码支付  
该接口是在Web页面中嵌入DApp请求用户支付的二维码，使用钱包应用进行扫描，在用户同意的情况下发起转账交易。二维码内容如下： 
```
    {
        "v":"kylinv1",
        "from":"payeaccount",
        "to": "receiveracnt",
        "tokenid": "eos",
        "billid":"39c22df9f92470936cddc1ade0e2f2ea",
        "num": "1000.03",
        "userid":"122332",
        "memo": "123456",
        "cb": "https://xxxx.xxx/xxx",
        "dappsymbol":"DAPPONE",
        "sessionid":"xxxxxxxx"
    }
```

注：
* v: 支付二维码类型版本信息
* to: 接收币的目的账户
* tokenid: tokens_info.json 中的每个数字资产的唯一标识
* num: 支付数量
* userid: 用户身份ID，可选参数
* billid: 当前支付订单ID，可选参数
* cb: 钱包支付完成的回调地址，可选参数
* from: 支付账户，可选参数
* dappsymbol: dapps_info.json 中DApp全网唯一的symbol字段, 可选参数
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

## 扫码登录
该接口是在Web页面中嵌入DApp的请求登录二维码，使用钱包应用进行扫描。登录二维码内容如下：
```
    URL:
        dappxxx.xx/kylindapp/login/carcode?dapp_symbol=XXXXX
```

流程逻辑：
	钱包扫码以后根据`dapp_symbol`获取DApp相关信息，提醒用户是否确认登录，用户同意后将通知DApp：
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