# 概述与授权 

**为了降低使用复杂度，针对转账支付接口(transfer)可以*直接发起调用*，不用提前注册DApp，但是请各钱包应用提醒用户转账风险；除此之外，还可以结合DApp注册机制实现安全可靠的支付功能。**

本接口规范起于对EOS、EUN的支持，但是从设计上来说同样支持BTC、ETH等已有其他数字资产。

为了降低信息维护复杂度，该 [Repository](https://github.com/cryptokylin/KylinDappSpec) 会提供已经支持的Token、DApp相关信息，分别为 tokens_info.json、dapps_info.json，不在统计范围内的Token和DApp可以通过Pull Request来提交更新请求。

### tokens_info.json 示例
| tokenid | name_en | name_cn | chainid | contract | tokenname | website | 
| ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- |
| eos | EOS | 柚子 | aca376f206b8fc25a6ed44dbdc66547c36c6c33e3a119ffbeaef943642f0e906 | eosio.token | EOS | https://github.com/EOSIO/eos |
| enu | ENU | 牛油果 | cf057bbfb72640471fd910bcb67639c22df9f92470936cddc1ade0e2f2e7dc4f | enu.token | ENU | https://github.com/enumivo/enumivo |
| btc | BTC | 比特币 | 00000000839a8e6886ab5951d76f411475428afc90947ee320161bbf18eb6048 |  | BTC | https://github.com/bitcoin/bitcoin |  
 
注: 
* tokenid: 全局唯一的由chainid、contract、tokenname 三者确定的一个ID
* chainid: 该币所在链chainid 或者 NUM #1 block hash

### dapps_info.json 示例
| symbol | dapp_name_cn | dapp_name_en | account_info | dapp_logo_256_png | website | contact | phone | description_cn | description_en |
| ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- |
| dappone_c391d81c | 游戏达人 | dappone | [{"tokenid":"eos","account":"wallet4bixin","memo":"123123"}] | https://xxxx.xxx/xxx.png | https://xxxx.xxx | xxxxxx | +861521123123 |第一款超级dapp游戏|This is a super DAPP|
注: 
* symbol: 全局唯一的DApp自己的标识，并在各个DApp统一使用，长度尽量短，最长 64 个字符，合法字符 a-z|0-9|_ 
* account_info: DApp预先注册的收款账户地址，tokenid 采用 tokens_info.json 中的字段

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
        dapp_name: 本土名称
        dapp_name_en: 英文名称
        dapp_symbol: DApp唯一标识，在各个开放平台要一致
        account_info: DApp预先注册的收款账户地址，tokenid 采用 tokens_info.json 中的字段
        dapp_logo_256_png: 
        website: 官网
        contact: 联系人
        phone: 联系电话
        description_cn: DApp其他描述
        description_en: DApp Description
    RESPONSE:
        code: 错误信息代码，0表示成功
        message: symbol已存在|DAPP名称已被注册|参数异常
        dapp_id: DApp的唯一标识，建议使用UUID，保证在不同平台的唯一性
        platform_id: 开放平台标识
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
        platform_id
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
        platform_id
        sessionid
    RESPONSE:
        code: 错误信息代码，0表示成功
        message: 
```