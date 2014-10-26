//
//  user.h
//  FastPassParking
//
//  Created by Alex Gordon on 10/26/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface user : NSObject

@property(nonatomic,copy) NSString* firstName;
@property(nonatomic,copy) NSString* lastName;
@property(nonatomic,copy) NSString* email;
@property(nonatomic,copy) NSString* password;
@property(nonatomic,copy) NSString* phoneNumber;
@property(nonatomic,copy) NSString* availableCredit;



@end
