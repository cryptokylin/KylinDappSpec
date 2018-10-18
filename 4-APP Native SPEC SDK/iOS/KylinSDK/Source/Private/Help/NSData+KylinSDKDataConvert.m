//
//  NSData+KylinSDKDataConvert.m
//  KylinSDK
//
//  Created by Rick on 2018/9/28.
//  Copyright © 2018年 MEET.ONE. All rights reserved.
//

#import "NSString+KylinSDKDataConvert.h"
#import "NSData+KylinSDKDataConvert.h"
#import "NSString+KylinSDKHelp.h"

@implementation NSData (KylinSDKDataConvert)

- (NSString *)kylinsdk_base64EncodedString {
    if (![self length]) {
        return nil;
    }
    
    NSString *encoded = nil;
    
    encoded = [self base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)0];
    
    return encoded;
}

- (NSString *)kylinsdk_base64DecodedString {
    NSString *decodeString = [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
    return [decodeString kylinsdk_base64DecodedString];
}

+ (NSData *)kylinsdk_dataWithBase64EncodedString:(NSString *)string {
    if (kylinsdk_isEmptyString(string)) {
        return nil;
    }
    
    NSData *decoded = nil;
    
    decoded = [[self alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    return [decoded length]? decoded: nil;
}

@end
