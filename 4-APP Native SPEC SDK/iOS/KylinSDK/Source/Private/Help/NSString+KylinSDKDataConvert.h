//
//  NSString+KylinSDKDataConvert.h
//  KylinSDK
//
//  Created by Rick on 2018/9/28.
//  Copyright © 2018年 MEET.ONE. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (KylinSDKDataConvert)

- (NSString *)kylinsdk_base64EncodedString;
- (NSString *)kylinsdk_base64DecodedString;

@end

NS_ASSUME_NONNULL_END
