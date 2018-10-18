//
//  AppDelegate.m
//  KylinSDK
//
//  Created by Rick on 2018/10/12.
//  Copyright © 2018 MEET.ONE. All rights reserved.
//

#import "KylinSDK.h"
#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    KylinSDKSetting *setting = [KylinSDKSetting new];
    setting.dappScheme = @"KylinDappDemo";
    setting.dappSymbol = @"dappone_c391d81c";
    [KylinSDK registerWithSetting:setting andAuthorization:nil];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    
    //Handle KylinSDK Callback
    [KylinSDK handleCallbackWithResult:url completionBlock:^(NSDictionary *res) {
        NSInteger code = [res[@"code"] integerValue];
        NSString *msg = res[@"msg"];
        NSString *path = res[@"path"];
//        NSString *platformid = res[@"platformid"];
//        NSString *authorization = res[@"authorization"];
        if (0 == code) { //success
            ;
        }
        NSLog(@"%@", msg);  //print message
        if ([path isEqualToString:@"pay"]) {
            ;
        } else if ([path isEqualToString:@"wallet/login"]) {
            
        } else if ([path isEqualToString:@"wallet/sign"]) {
            ;
        } else if ([path isEqualToString:@"contract"]) {
            ;
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:path object:res];
    }];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
