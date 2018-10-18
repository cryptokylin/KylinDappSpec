//
//  NSData+KylinSDKDataConvert.h
//  KylinSDK
//
//  Created by Rick on 2018/9/28.
//  Copyright © 2018年 MEET.ONE. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (KylinSDKDataConvert)

///base64 编码
- (NSString *)kylinsdk_base64EncodedString;
///base64 解码
- (NSString *)kylinsdk_base64DecodedString;

+ (NSData *)kylinsdk_dataWithBase64EncodedString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
