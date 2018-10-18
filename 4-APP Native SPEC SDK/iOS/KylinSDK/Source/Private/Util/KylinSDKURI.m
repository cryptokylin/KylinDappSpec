//
//  KylinSDKURI.m
//  KylinSDK
//
//  Created by Rick on 2018/9/28.
//  Copyright © 2018年 MEET.ONE. All rights reserved.
//

#import "KylinSDKURI.h"
#import "NSData+KylinSDKDataConvert.h"
#import "NSString+KylinSDKDataConvert.h"
#import "NSString+KylinSDKHelp.h"
#import "NSDictionary+KylinSDKHelp.h"

@interface KylinSDKURI ()

@property (nonatomic, copy) NSString *uri;

@property (nonatomic, copy) NSString *scheme;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *query;

@property (nonatomic, copy) NSDictionary *params;

@end

@implementation KylinSDKURI

+ (instancetype)uriWithURIString:(NSString *)uriString
{
    KylinSDKURI *uri = [[self alloc] init];
    uri.uri = uriString;
    [uri parseURI];
    return uri;
}

+ (instancetype)uriWithScheme:(NSString *)scheme
                         path:(NSString *)path
                       params:(NSDictionary *)params
{
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"/"];
    path = [path stringByTrimmingCharactersInSet:characterSet];
    
    KylinSDKURI *uri = [[self alloc] init];
    uri.scheme = scheme;
    uri.path = path;
    uri.params = params;
    return uri;
}

- (void)appendingParams:(NSDictionary *)params
{
    if (!params.count) {
        return;
    }
    NSMutableDictionary *newDict = [NSMutableDictionary dictionaryWithDictionary:self.params];
    [newDict addEntriesFromDictionary:params];
    self.params = newDict;
    ///重加载 uri string
    _uri = nil;
}

- (NSString *)uri
{
    if (!_uri.length) {
        NSString *scheme = self.scheme ?: @"kylindapp";
        NSString *path = self.path ?: @"";

        NSString *uriString = [NSString stringWithFormat:@"%@://%@", scheme, path];
        if (self.params.count > 0) {
            uriString = [uriString kylinsdk_appendingURLParams:@"params=%@", [[self.params kylinsdk_toJSONString] kylinsdk_base64EncodedString]];
        }
        _uri = uriString;
    }
    return _uri;
}

- (void)parseURI
{
    NSString *uriString = self.uri;

    NSArray *array = [uriString componentsSeparatedByString:@"://"];
    BOOL hasScheme = NO;
    if (array.count > 1) {
        self.scheme = array.firstObject;
        hasScheme = YES;
    }
    else {
        self.scheme = @"kylindapp";
    }

    NSString *path = array.lastObject;

    ///截取 query
    if ([path containsString:@"?"]) {
        array = [path componentsSeparatedByString:@"?"];
        self.path = array.firstObject;
        self.query = array.lastObject;

        NSDictionary *queryMap = [KylinSDKURI queryDictionaryWithString:self.query];
        NSString *paramsString = queryMap[@"params"];
        self.params = [[paramsString kylinsdk_base64DecodedString] kylinsdk_jsonDictionary];
        
        if (!self.params && queryMap.count) {
            self.params = queryMap;
        }
    }
    else {
        self.path = path;
    }
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"\n scheme:%@ \n path:%@ \n params:%@ \n", self.scheme, self.path, self.params];
}

+ (NSDictionary *)queryDictionaryWithString:(NSString *)urlString
{
    NSArray *array = [urlString componentsSeparatedByString:@"?"];
    NSString *encodedString = array.lastObject;

    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    NSArray *pairs = [encodedString componentsSeparatedByString:@"&"];

    for (NSString *kvp in pairs) {
        if ([kvp length] == 0) {
            continue;
        }

        NSRange pos = [kvp rangeOfString:@"="];
        NSString *key;
        NSString *val;

        if (pos.location == NSNotFound) {
            key = kvp;
            val = @"";
        }
        else {
            key = [kvp substringToIndex:pos.location];
            val = [kvp substringFromIndex:pos.location + pos.length];
        }
        if (!key || !val) {
            continue; // I'm sure this will bite my arse one day
        }
        [result setObject:val forKey:key];
    }
    return result;
}
@end
