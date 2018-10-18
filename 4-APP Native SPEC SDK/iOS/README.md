## 文件目录

- Source
    - KylinSDK.h //引入sdk只需要导入此头文件
    - Private //一些帮助类
    - Public //公有API
        - KylinSDKProtocol.h //API协议定义
        - KylinSDKAuthorizationProtocol.h //授权相关协议定义
        - KylinSDKImp.h
        - KylinSDKImp.m //协议实现
 
## 初始化
```objc
#import "KylinSDK.h"  
KylinSDKSetting *setting = [KylinSDKSetting new];
setting.dappScheme = @"KylinDappDemo";
setting.dappSymbol = @"dappone_c391d81c";
[KylinSDK registerWithSetting:setting andAuthorization:nil];
```

## API
```objc
/**
 *  Pay Token
 *
 *  @param tokenID Token ID
 *  @param from Payer
 *  @param to Receiver
 *  @param number Token Count
 *  @param memo Payment Memo
 *  @param actionID Payment Action ID
 *  @param userID Platform User ID
 *  @param message Reason Of Payment
 *  @param walletScheme wallet's scheme,'nil' will use setting.defaultWalletScheme
 *  @param completion Completion Block
 */
+ (void)payToken:(NSString *)tokenID
            from:(nullable NSString *)from
              to:(NSString *)to
          number:(CGFloat)number
            memo:(nullable NSString *)memo
        actionID:(nullable NSString *)actionID
          userID:(nullable NSString *)userID
         message:(nullable NSString *)message
    walletScheme:(nullable NSString *)walletScheme
completionHandler:(void (^)(BOOL success))completion;

/**
 *  Execute Token Contract
 *
 *  @param tokenID Token id
 *  @param account Executer's Account
 *  @param address Executer's Address
 *  @param actions Contract Actions
 *  @param options Contract Options
 *  @param actionID Payment action id
 *  @param message Reason of Payment
 *  @param walletScheme wallet's scheme,'nil' will use setting.defaultWalletScheme
 *  @param completion Completion Block
 */
+ (void)executeTokenContract:(NSString *)tokenID
                     account:(NSString *)account
                     address:(NSString *)address
                     actions:(NSArray *)actions
                     options:(nullable NSDictionary *)options
                    actionID:(nullable NSString *)actionID
                     message:(nullable NSString *)message
                walletScheme:(nullable NSString *)walletScheme
           completionHandler:(void (^)(BOOL success))completion;

/**
 *  Login wallet
 *
 *  @param tokenID Token id
 *  @param walletScheme wallet's scheme,'nil' will use setting.defaultWalletScheme
 *  @param completion Completion Block
 */
+ (void)loginWithTokenID:(NSString *)tokenID
            walletScheme:(nullable NSString *)walletScheme
       completionHandler:(void (^)(BOOL success))completion;

/**
 *  Request Signature
 *
 *  @param tokenID Token id
 *  @param walletAccountName Account Name In Wallet
 *  @param customData Custom Signature Data String
 *  @param message Reason of Requesting Signature
 *  @param walletScheme wallet's scheme,'nil' will use setting.defaultWalletScheme
 *  @param completion Completion Block
 */
+ (void)requestSignatureWithTokenID:(NSString *)tokenID
                  walletAccountName:(NSString *)walletAccountName
                         customData:(nullable NSString *)customData
                            message:(nullable NSString *)message
                       walletScheme:(nullable NSString *)walletScheme
                  completionHandler:(void (^)(BOOL success))completion;
```

## DEMO
```objc
//1.Pay Token
[KylinSDK payToken:@"eos"
              from:nil
                to:@"eosaccount12"
            number:0.0001
              memo:@"Just for Test"
          actionID:nil
            userID:nil
           message:@"EOS TO THE MOON !!!"
      walletScheme:nil
 completionHandler:^(BOOL success) {
     ;
 }];
 
 //2.contract
[KylinSDK executeTokenContract:@"eos"
                       account:@"eosaccount11"
                       address:@"EOS5FSY7uwixFNF1mbvESmZ1w2mNgb3GhXUvdvS6GwdurYxXZqLSn"
                       actions:@[@{@"account":@"eosio.token",@"name":@"transfer",@"authorization":@[@{@"actor":@"eosaccount11",@"permission":@"active"}],@"data":@{@"from":@"eosaccount11",@"to":@"eosaccount12",@"quantity":@"0.0001 EOS",@"memo":@"sdk test"}}]
                       options:@{@"broadcast":@(YES)}
                      actionID:nil
                       message:@"EOS TO THE MOON !!!"
                  walletScheme:nil
             completionHandler:^(BOOL success) {
                 ;
             }];
             
//3.login
[KylinSDK loginWithTokenID:@"eos" walletScheme:nil completionHandler:^(BOOL success) {
    ;
}];

//4.request sign
[KylinSDK requestSignatureWithTokenID:@"eos" walletAccountName:@"eosaccount11" customData:@"for test" message:@"EOS TO THE MOON !!!" walletScheme:nil completionHandler:^(BOOL success) {
    ;
}];
```

## 自定义SDK
- 继承 Class KylinSDK，实现以下代码，比如自定义类名为MeetOneSDK。
```objc
//change to MeetOneSDK to custom your sdk
+ (Class<KylinSDK>)usingSDKClass {
    return [MeetOneSDK class];
}
```
此时KylinSDK的方法调用都会默认采用MeetOneSDK里的方法定义


