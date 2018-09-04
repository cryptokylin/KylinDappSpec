# 概述与授权

本接口规范由 [CryptoKylin](https://github.com/cryptokylin) 小组与部分钱包同学一起发起制定。KylinDApp Open Platform Specification 主要目的是制定统一的 DApp (包含Web、Native、Hybird) 应用与钱包、交易所开放平台之间的一套接口协议，使得遵循该协议开发的DApp可以在不同的钱包和交易所之间使用，无需再进行接口适配。 

**为了降低使用复杂度，针对转账支付接口(transfer)可以*直接发起调用*，不用提前注册DApp，但是请各钱包应用提醒用户转账风险；除此之外，还可以结合DApp注册机制实现安全可靠的支付功能。**

本接口规范起于对EOS、EUN的支持，但是从设计上来说同样支持BTC、ETH等已有其他代币。

为了降低信息维护复杂度，该 [Repository](https://github.com/cryptokylin/KylinDappSpec)会提供已经支持的Token、DApp相关信息，分别为 tokens_info.json、dapp_info.json，不在统计范围内的Token和DApp可以通过Pull Request来提交更新请求。

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