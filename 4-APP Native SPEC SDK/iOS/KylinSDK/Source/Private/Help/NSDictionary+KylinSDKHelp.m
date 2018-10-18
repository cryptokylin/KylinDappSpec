//
//  NSDictionary+KylinSDKHelp.m
//  KylinSDK
//
//  Created by Rick on 2018/10/16.
//  Copyright © 2018 MEET.ONE. All rights reserved.
//

#import "NSDictionary+KylinSDKHelp.h"

@implementation NSDictionary (KylinSDKHelp)

- (nullable NSString *)kylinsdk_toJSONString {
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments
                                                     error:nil];
    
    if (data == nil) {
        return nil;
    }
    
    NSString *string = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
    return string;
}

@end
