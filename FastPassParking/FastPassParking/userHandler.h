//
//  userHandler.h
//  FastPassParking
//
//  Created by Alex Gordon on 10/26/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "httpRequestHandler.h"
#import "AppDelegate.h"

@interface userHandler : NSObject {
    AppDelegate* appDelegate;
}

@property(nonatomic, strong) void (^Finished)(BOOL isFinished);

// TODO: These methods need to return something (user object?)
// TODO: Remove the initWithBaseUrl since the base url is stored in AppDelegate now
-(void) initWithAppDelegate;
-(void) authenticateLogin:(NSString*) loginName withLoginPassword:(NSString*) loginPassword withCompletionHandler:(void(^)(BOOL isFinished)) Finished;
-(void) createAccount:(user*) userObject;

@end
