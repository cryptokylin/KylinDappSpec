//
//  KylinSDKAuthorization.h
//  KylinSDK
//
//  Created by Rick on 2018/10/12.
//  Copyright © 2018 MEET.ONE. All rights reserved.
//

#ifndef KylinSDKAuthorization_h
#define KylinSDKAuthorization_h

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol KylinSDKAuthorization

#pragma mark - Public

- (NSString *)authorization;

@end

NS_ASSUME_NONNULL_END

#endif /* KylinSDKAuthorization_h */
