//
//  KylinSDK.h
//  KylinSDK
//
//  Created by Rick on 2018/9/28.
//  Copyright © 2018年 MEET.ONE. All rights reserved.
//

#import "KylinSDKProtocol.h"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KylinSDK : NSObject <KylinSDK>

/**
 *  Run Protocol URI
 *
 *  @param scheme wallet scheme,default is KylinSDK
 *  @param path protocol path
 *  @param params protocol params
 *  @param completion Completion Block
 */
+ (void)runURIWithScheme:(nullable NSString *)scheme
                    path:(NSString *)path
                  params:(NSDictionary *)params
       completionHandler:(void (^ __nullable)(BOOL success))completion;

@end

@interface KylinSDK (Init)

//Implement this method will change the sdk class(default is KylinSDK).
+ (Class<KylinSDK>)usingSDKClass;

@end

NS_ASSUME_NONNULL_END
