//
//  userHandler.h
//  FastPassParking
//
//  Created by Alex Gordon on 10/26/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface userHandler : NSObject

@property(nonatomic,copy) NSString* kBaseURL;


-(void) initWithBaseURL;
-(void) authenticateLogin:(NSString*) loginName withLoginPassword:(NSString*) loginPassword;


@end
