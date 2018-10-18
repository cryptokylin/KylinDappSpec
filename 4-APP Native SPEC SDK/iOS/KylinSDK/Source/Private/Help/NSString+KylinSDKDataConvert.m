//
//  NSString+KylinSDKDataConvert.m
//  KylinSDK
//
//  Created by Rick on 2018/9/28.
//  Copyright © 2018年 MEET.ONE. All rights reserved.
//

#import "NSString+KylinSDKDataConvert.h"
#import "NSData+KylinSDKDataConvert.h"

@implementation NSString (KylinSDKDataConvert)

- (NSString *)kylinsdk_base64EncodedString {
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data kylinsdk_base64EncodedString];
}

- (NSString *)kylinsdk_base64DecodedString {
    NSData *data = [NSData kylinsdk_dataWithBase64EncodedString:self];
    if (data) {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

@end
