//
//  KylinSDKURI.h
//  KylinSDK
//
//  Created by Rick on 2018/9/28.
//  Copyright © 2018年 MEET.ONE. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KylinSDKURI : NSObject

+ (instancetype)uriWithURIString:(NSString *)uri;

+ (instancetype)uriWithScheme:(NSString *)scheme
                         path:(NSString *)path
                       params:(NSDictionary *)params;

@property (nonatomic, copy, readonly) NSString *uri;
@property (nonatomic, copy, readonly) NSString *scheme;
@property (nonatomic, copy, readonly) NSString *path;
@property (nonatomic, copy, readonly) NSString *query;
@property (nonatomic, copy, readonly) NSDictionary *params; /**< json string*/

@end

NS_ASSUME_NONNULL_END
