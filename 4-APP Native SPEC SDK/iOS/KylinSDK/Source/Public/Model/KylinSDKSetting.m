//
//  KylinSDKSetting.m
//  KylinSDK
//
//  Created by Rick on 2018/10/12.
//  Copyright © 2018 MEET.ONE. All rights reserved.
//

#import "KylinSDKSetting.h"

@implementation KylinSDKSetting

@synthesize dappSymbol = _dappSymbol;
@synthesize dappScheme = _dappScheme;
@synthesize defaultWalletScheme = _defaultWalletScheme;// default is @"kylindapp"

- (instancetype)init {
    self = [super init];
    if (self) {
        self.defaultWalletScheme = @"kylindapp";
    }
    return self;
}

@end
