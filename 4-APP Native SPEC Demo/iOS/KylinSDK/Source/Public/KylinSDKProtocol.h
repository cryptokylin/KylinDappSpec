//
//  KylinSDKProtocol.h
//  KylinSDK
//
//  Created by Rick on 2018/9/12.
//  Copyright © 2018年 CryptoKylin. All rights reserved.
//

#ifndef KylinSDKProtocol_h
#define KylinSDKProtocol_h

#import "KylinSDKAuthorizationProtocol.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^KylinCompletionBlock)(NSDictionary *res);

//========================================================================================================

#pragma mark -

@protocol KylinSDKSetting

@property (nonatomic, copy) NSString *dappSymbol;
@property (nonatomic, copy) NSString *dappScheme;
@property (nonatomic, copy) NSString *defaultWalletScheme;

@end

//========================================================================================================

#pragma mark -

@protocol KylinTokenSDK <NSObject>

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

@end

//========================================================================================================

#pragma mark -

@protocol KylinWalletSDK <NSObject>

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

@end

//========================================================================================================

#pragma mark -

@protocol KylinSDK <KylinTokenSDK, KylinWalletSDK>

#pragma mark - Public

/**
 *  SDK Version
 *
 *  @return SDK Version
 */
+ (NSString *)sdkVersion;

/**
 *  Register SDK
 *
 *  @param setting dapp's sdk setting
 *  @param authorization dapp's authorization
 *
 *  @return succsee
 */
+ (BOOL)registerWithSetting:(id <KylinSDKSetting>)setting
           andAuthorization:(nullable id <KylinSDKAuthorization>)authorization;

/**
 *  KylinSDK Callback Handler
 *
 *  @param resultUrl callback open url
 *  @param completionBlock callback block
 *
 *  @return Whether sdk can handle
 */
+ (BOOL)handleCallbackWithResult:(NSURL *)resultUrl
                 completionBlock:(KylinCompletionBlock)completionBlock;

@end

NS_ASSUME_NONNULL_END

#endif /* KylinSDKProtocol_h */
