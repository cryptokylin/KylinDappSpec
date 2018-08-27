### *为了在易用性前提下保留安全性，该文档会分成两部分：第一部分是针对登录、获取用户信息、转账高频场景定义简单直接的接口，安全性主要依靠用户个人意识；第二部分是针对开放平台提供的安全实施建议方案。*

# Web端接口规范  
* ## 扫码获取用户信息  
该接口是在Web页面中嵌入DApp请求用户信息的二维码，使用钱包应用进行扫描，在用户同意授权的情况下提交用户的主要信息到DApp。  
登录二维码内容如下： 
```
    dappxxx.xx/.../kylindapp/info/request
```
*注： URL需要以 kylindapp/info/request 结尾的URL*  

流程逻辑:  
1. 扫码应用获取DApp的相关信息，至少返回如下数据:  
```
    GET 
        https://dappxxx.xx/.../kylindapp/info/request

    RESPONSE:

    {
        "code":"错误信息代码，0表示成功",
        "message": "错误信息", 
        "dapp_name_en":"dapp英文名称",
        "dapp_name_cn":"dapp中文名称",
        "dapp_uuid":"dapp唯一标识",
        "dapp_logo_256_png":"256x256 PNG格式图片地址",
        "website":"dapp官方网站",
        "contact":"dapp联系人或者组织名称",
        "description":"dapp简单描述",
        "version":"当前dapp版本"
    }
```      
2. 根据第一步获取的信息进行页面展示，并提示用户是否同意授权DApp获取个人信息
3. 如果用户同意，将用户信息提交到DApp，至少包含如下数据：
```
    POST
        https://dappxxx.xx/.../kylindapp/info/request
    
    PARAM:
    {
        "platform_id":"开放平台标识id，比如 tokenpackt",
        "userid":"用户ID",
        "nickname":"用户昵称",
        "avatar":"用户头像地址"
    }

    RESPONSE:
    {
        "code":"错误信息代码，0表示成功",
        "message": "错误信息", 
        "dapp_uuid":"dapp唯一标识",
        "dapp_userid:"该用户在DApp中的用户ID"
    }
```  

* ## 扫码支付  
该接口是在Web页面中嵌入DApp请求用户支付的二维码，使用钱包应用进行扫描，在用户同意的情况下发起转账交易。  
登录二维码内容如下： 
```
    dappxxx.xx/.../kylindapp/transfer/request?billid=UUID
```
*注： URL需要以 kylindapp/transfer/request 结尾的URL*  

流程逻辑:  
1. 扫码应用获取DApp的相关转账信息，至少返回如下数据:  
```
    GET 
        https://dappxxx.xx/.../kylindapp/transfer/request?billid=UUID

    RESPONSE:

    {
        "code":"错误信息代码，0表示成功",
        "message": "错误信息", 
        "dapp_name_en":"dapp英文名称",
        "dapp_name_cn":"dapp中文名称",
        "dapp_uuid":"dapp唯一标识",
        "dapp_logo_256_png":"256x256 PNG格式图片地址",
        "dapp_info_url":"https://dappxxx.xx/.../kylindapp/info/request"
        "from":"发起账户名称，可不填",
        "to":"目的账号名称",
        "token":"token名称，比如EOS",
        "tokencontract":"合约账户或者地址",
        "amount":"转账数量，不用带token名称",
        "memo":"转账需要填写的memo信息",
        "description":"转账明细",
        "callback":"转账回调地址:  https://dappxxx.xx/.../kylindapp/info/request/cb?billid=UUID"
    }
```      
2. 根据第一步获取的信息进行页面展示，并提示用户是否同意转账
3. 如果用户同意，进行转账，并将转账信息通过回调传递给DApp，至少包含如下数据：
```
    POST
        https://dappxxx.xx/.../kylindapp/info/request/cb?billid=UUID
    
    PARAM:
    {
        "platform_id":"开放平台标识id，比如 tokenpackt",
        "txid":"转账交易链上ID"
    }

    RESPONSE:
    {
        "code":"错误信息代码，0表示成功",
        "message": "错误信息"
    }
```   
<br/>  

# Web端接口规范  
* ## 扫码获取用户信息  
该接口是在Web页面中嵌入DApp请求用户信息的二维码，使用钱包应用进行扫描，在用户同意授权的情况下提交用户的主要信息到DApp。  






