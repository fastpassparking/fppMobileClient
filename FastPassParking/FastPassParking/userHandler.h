//
//  userHandler.h
//  FastPassParking
//
//  Created by Alex Gordon on 10/26/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "user.h"

@interface UserHandler : NSObject

@property(nonatomic, strong) void (^Finished)(BOOL isFinished);

+(void) authenticateLogin:(NSString*) loginName withLoginPassword:(NSString*) loginPassword withCompletionHandler:(void(^)(BOOL, user*)) handler;
+(void) createAccount:(user*) userObject withCompletionHandler:(void(^)(BOOL, user*)) handler;
+(void) updateAccount:(user*) userObject withCompletionHandler:(void(^)(BOOL))handler;

@end
