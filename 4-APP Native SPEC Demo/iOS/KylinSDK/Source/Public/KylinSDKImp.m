//
//  KylinSDK.m
//  KylinSDK
//
//  Created by Rick on 2018/9/28.
//  Copyright © 2018年 MEET.ONE. All rights reserved.
//

#import "KylinSDKSetting.h"
#import "KylinSDKImp.h"
#import "NSString+KylinSDKHelp.h"
#import "KylinSDKURI.h"
#import <UIKit/UIKit.h>

@interface KylinSDK ()

//Sdk Setting
@property (nonatomic, strong) id <KylinSDKSetting> setting;
//Authentication,according to the platform
@property (nonatomic, strong) id <KylinSDKAuthorization> authorization;

@property (nonatomic, copy) NSString *sdkVersion;

@end

@implementation KylinSDK

- (instancetype)init {
    self = [super init];
    if (self) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        
        self.setting = [KylinSDKSetting new];
        self.sdkVersion = [NSString stringWithFormat:@"kylinv%@", app_Version];
    }
    
    return self;
}

+ (instancetype)sharedSDK {
    static KylinSDK *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class sdkClass = [KylinSDK class];
        if ([sdkClass respondsToSelector:@selector(usingSDKClass)]) {
            sdkClass = [KylinSDK usingSDKClass];
        }
        instance = [[sdkClass alloc] init];
    });
    return instance;
}

#pragma mark - Public
+ (NSString *)sdkVersion {
    return [KylinSDK sharedSDK].sdkVersion;
}

+ (BOOL)registerWithSetting:(id <KylinSDKSetting>)setting
           andAuthorization:(nullable id <KylinSDKAuthorization>)authorization {
    KylinSDK *sdk = [KylinSDK sharedSDK];
    sdk.setting = setting;
    sdk.authorization = authorization;
    return YES;
}

+ (BOOL)handleCallbackWithResult:(NSURL *)resultUrl
                 completionBlock:(KylinCompletionBlock)completionBlock {
    KylinSDKURI *uri = [KylinSDKURI uriWithURIString:resultUrl.absoluteString];
    if (![uri.path isEqualToString:@"kylin/callback"]) {
        return NO;
    }
    NSDictionary *res = uri.params;
    if (completionBlock) {
        completionBlock(res);
    }
    return YES;
}

+ (void)runURIWithScheme:(nullable NSString *)scheme
                    path:(NSString *)path
                  params:(NSDictionary *)params
       completionHandler:(void (^ __nullable)(BOOL success))completion {
    KylinSDKURI *uri = [KylinSDKURI uriWithScheme:kylinsdk_isNotEmptyString(scheme) ? scheme : @"kylindapp" path:path params:params];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:uri.uri] options:@{} completionHandler:completion];
}

#pragma mark - Token

+ (void)payToken:(NSString *)tokenID
            from:(nullable NSString *)from
              to:(NSString *)to
          number:(CGFloat)number
            memo:(nullable NSString *)memo
        actionID:(nullable NSString *)actionID
          userID:(nullable NSString *)userID
         message:(nullable NSString *)message
    walletScheme:(nullable NSString *)walletScheme
completionHandler:(void (^)(BOOL success))completion {
    if (kylinsdk_isEmptyString(tokenID) || kylinsdk_isEmptyString(to)) {
        if (completion) {
            completion(NO);
        }
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    params[@"tokenid"] = tokenID;
    params[@"num"] = @(number);
    params[@"to"] = to;
    if (kylinsdk_isNotEmptyString(from)) {
        params[@"from"] = from;
    }
    if (kylinsdk_isNotEmptyString(memo)) {
        params[@"memo"] = memo;
    }
    if (kylinsdk_isNotEmptyString(actionID)) {
        params[@"actionid"] = actionID;
    }
    if (kylinsdk_isNotEmptyString(userID)) {
        params[@"userid"] = userID;
    }
    if (kylinsdk_isNotEmptyString(message)) {
        params[@"msg"] = message;
    }
    [KylinSDK runKylinSDKURIWithScheme:walletScheme path:@"pay" params:params completionHandler:^(BOOL success) {
        if (completion) {
            completion(success);
        }
    }];
}

+ (void)executeTokenContract:(NSString *)tokenID
                     account:(NSString *)account
                     address:(NSString *)address
                     actions:(NSArray *)actions
                     options:(nullable NSDictionary *)options
                    actionID:(nullable NSString *)actionID
                     message:(nullable NSString *)message
                walletScheme:(nullable NSString *)walletScheme
           completionHandler:(void (^)(BOOL success))completion {
    if (kylinsdk_isEmptyString(tokenID) || kylinsdk_isEmptyString(account) || kylinsdk_isEmptyString(address) || 0 == [actions count]) {
        if (completion) {
            completion(NO);
        }
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    params[@"tokenid"] = tokenID;
    params[@"account"] = account;
    params[@"address"] = address;
    params[@"actions"] = actions;
    if ([options count]) {
        params[@"options"] = options;
    }
    if (kylinsdk_isNotEmptyString(actionID)) {
        params[@"actionid"] = actionID;
    }
    if (kylinsdk_isNotEmptyString(message)) {
        params[@"msg"] = message;
    }
    [KylinSDK runKylinSDKURIWithScheme:walletScheme path:@"contract" params:params completionHandler:^(BOOL success) {
        if (completion) {
            completion(success);
        }
    }];
    
}

#pragma mark - Wallet

+ (void)loginWithTokenID:(NSString *)tokenID
            walletScheme:(nullable NSString *)walletScheme
       completionHandler:(void (^)(BOOL success))completion {
    if (kylinsdk_isEmptyString(tokenID)) {
        if (completion) {
            completion(NO);
        }
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    params[@"tokenid"] = tokenID;
    [KylinSDK runKylinSDKURIWithScheme:walletScheme path:@"wallet/login" params:params completionHandler:^(BOOL success) {
        if (completion) {
            completion(success);
        }
    }];
}

+ (void)requestSignatureWithTokenID:(NSString *)tokenID
                  walletAccountName:(NSString *)walletAccountName
                         customData:(nullable NSString *)customData
                            message:(nullable NSString *)message
                       walletScheme:(nullable NSString *)walletScheme
                  completionHandler:(void (^)(BOOL success))completion {
    if (kylinsdk_isEmptyString(tokenID) || kylinsdk_isEmptyString(walletAccountName)) {
        if (completion) {
            completion(NO);
        }
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    params[@"tokenid"] = tokenID;
    params[@"accountname"] = walletAccountName;
    if (kylinsdk_isNotEmptyString(customData)) {
        params[@"customdata"] = customData;
    }
    if (kylinsdk_isNotEmptyString(message)) {
        params[@"msg"] = message;
    }
    [KylinSDK runKylinSDKURIWithScheme:walletScheme path:@"wallet/sign" params:params completionHandler:^(BOOL success) {
        if (completion) {
            completion(success);
        }
    }];
}

#pragma mark - Private

+ (void)runKylinSDKURIWithScheme:(nullable NSString *)scheme
                            path:(NSString *)path
                          params:(NSDictionary *)params
               completionHandler:(void (^ __nullable)(BOOL success))completion {
    KylinSDK *sdk = [KylinSDK sharedSDK];
    NSMutableDictionary *uriParams = [NSMutableDictionary dictionaryWithDictionary:params];
    if (kylinsdk_isNotEmptyString(sdk.sdkVersion)) {
        uriParams[@"v"] = sdk.sdkVersion;
    }
    if (kylinsdk_isNotEmptyString(sdk.setting.dappSymbol)) {
        uriParams[@"dappsymbol"] = sdk.setting.dappSymbol;
    }
    if (kylinsdk_isNotEmptyString(sdk.authorization.authorization)) {
        uriParams[@"authorization"] = sdk.authorization.authorization;
    }
    if (kylinsdk_isNotEmptyString(sdk.setting.dappScheme)) {
        uriParams[@"cb"] = sdk.setting.dappScheme;
    }
    NSString *targetScheme;
    if (kylinsdk_isNotEmptyString(scheme)) {
        targetScheme = scheme;
    } else if (kylinsdk_isNotEmptyString(sdk.setting.defaultWalletScheme)) {
        targetScheme = sdk.setting.defaultWalletScheme;
    }
    [KylinSDK runURIWithScheme:targetScheme path:path params:uriParams completionHandler:completion];
}

@end
