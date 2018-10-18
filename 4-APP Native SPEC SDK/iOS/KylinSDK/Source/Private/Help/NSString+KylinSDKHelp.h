//
//  NSString+KylinSDKHelp.h
//  KylinSDK
//
//  Created by Rick on 2018/9/28.
//  Copyright © 2018年 MEET.ONE. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN BOOL kylinsdk_isEmptyString(NSString *_Nullable);
FOUNDATION_EXTERN BOOL kylinsdk_isNotEmptyString(NSString *_Nullable);
FOUNDATION_EXTERN BOOL kylinsdk_isBlankString(NSString *_Nullable);
FOUNDATION_EXTERN BOOL kylinsdk_isNotBlankString(NSString *_Nullable);

@interface NSString (KylinSDKHelp)

/**
 *  @brief 判断字符串为 nil or @"" or null or (null) or <null>
 */
+ (BOOL)kylinsdk_isEmptyString:(nullable NSString *)string;

/**
 *  只判断是否为空字符串   不判断是否为 "null"
 */
+ (BOOL)kylinsdk_isBlankString:(nullable NSString *)string;

/**
 *  @brief 获取去除空格后的字符串, 只能去除两端
 */
- (NSString *)kylinsdk_trimString;

- (NSDictionary *)kylinsdk_queryDictionary;

- (NSString *)kylinsdk_appendingURLParams:(id)params, ...;

- (nullable NSDictionary *)kylinsdk_jsonDictionary;

@end

NS_ASSUME_NONNULL_END
