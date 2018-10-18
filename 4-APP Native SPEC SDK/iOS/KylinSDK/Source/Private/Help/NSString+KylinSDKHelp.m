//
//  NSString+KylinSDKHelp.m
//  KylinSDK
//
//  Created by Rick on 2018/9/28.
//  Copyright © 2018年 MEET.ONE. All rights reserved.
//

#import "NSString+KylinSDKHelp.h"
#import "NSDictionary+KylinSDKHelp.h"

inline BOOL kylinsdk_isEmptyString(NSString *string) {
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    if (string.length == 0) {
        return YES;
    }
    NSString *trimString = string.kylinsdk_trimString;
    if (trimString.length == 0) {
        return YES;
    }
    NSString *lowercaseString = trimString.lowercaseString;
    if ([lowercaseString isEqualToString:@"(null)"] || [lowercaseString isEqualToString:@"null"] || [lowercaseString isEqualToString:@"<null>"]) {
        return YES;
    }
    return NO;
}

inline BOOL kylinsdk_isNotEmptyString(NSString *string) {
    return !kylinsdk_isEmptyString(string);
}

inline BOOL kylinsdk_isBlankString(NSString *string) {
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    if (string.length == 0) {
        return YES;
    }
    NSString *trimString = string.kylinsdk_trimString;
    if (trimString.length == 0) {
        return YES;
    }
    return NO;
}

inline BOOL kylinsdk_isNotBlankString(NSString *string) {
    return !kylinsdk_isBlankString(string);
}

@implementation NSString (KylinSDKHelp)

+ (BOOL)kylinsdk_isEmptyString:(NSString *)string {
    return kylinsdk_isEmptyString(string);
}

+ (BOOL)kylinsdk_isBlankString:(NSString *)string {
    return kylinsdk_isBlankString(string);
}

- (NSString *)kylinsdk_trimString {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSDictionary *)kylinsdk_queryDictionary {
    NSArray *array = [self componentsSeparatedByString:@"?"];
    NSString *encodedString = array.lastObject;
    
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    NSArray *pairs = [encodedString componentsSeparatedByString:@"&"];
    
    for (NSString *kvp in pairs) {
        if ([kvp length] == 0) {
            continue;
        }
        
        NSRange pos = [kvp rangeOfString:@"="];
        NSString *key;
        id val;
        
        if (pos.location == NSNotFound) {
            key = [self kylinsdk_stringByUnescapingFromURLQuery:kvp];
            val = @"";
        } else {
            key = [self kylinsdk_stringByUnescapingFromURLQuery:[kvp substringToIndex:pos.location]];
            val = [self kylinsdk_stringByUnescapingFromURLQuery:[kvp substringFromIndex:pos.location + pos.length]];
            if ([val hasPrefix:@"{"] && [val hasSuffix:@"}"]) {
                val = [val kylinsdk_jsonDictionary] ?: val;
            }
        }
        
        if (!key || !val) {
            continue; // I'm sure this will bite my arse one day
        }
        
        [result setObject:val forKey:key];
    }
    return result;
}
- (NSString *)kylinsdk_stringByUnescapingFromURLQuery:(NSString *)string {
    NSString *deplussed = [string stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    return [deplussed stringByRemovingPercentEncoding];
}

- (NSString *)kylinsdk_appendingURLParams:(id)params, ... {
    NSString *urlParamsString = nil;
    if ([params isKindOfClass:[NSString class]]) {
        va_list list;
        va_start(list, params);
        urlParamsString = [[NSString alloc] initWithFormat:params arguments:list];
        va_end(list);
    } else if ([params isKindOfClass:[NSDictionary class]]) {
        urlParamsString = [params kylinsdk_toJSONString];
    }
    
    if (!urlParamsString.length) {
        return self;
    }
    
    if ([urlParamsString hasPrefix:@"&"]) {
        urlParamsString = [urlParamsString substringFromIndex:1];
    }
    
    NSString *resultURLString = nil;
    if ([self containsString:@"?"]) {
        if (![self hasSuffix:@"&"]) {
            resultURLString = [self stringByAppendingFormat:@"&%@", urlParamsString];
        } else {
            resultURLString = [self stringByAppendingString:urlParamsString];
        }
    } else {
        resultURLString = [self stringByAppendingFormat:@"?%@", urlParamsString];
    }
    
    return resultURLString;
}

- (nullable NSDictionary *)kylinsdk_jsonDictionary {
    if (self == nil) {
        return nil;
    }
    
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if (err) {
        NSLog(@"json parse error：%@",err);
        return nil;
    }
    return dic;
}

@end
