//
//  accountCredit.h
//  FastPassParking
//
//  Created by Kerl on 10/29/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface accountCredit : NSObject

@property(nonatomic,copy) NSString* dbId;
@property(nonatomic,copy) NSString* userId;
@property(nonatomic,copy) NSNumber* amount;
@property(nonatomic,copy) NSDate* dateTimeAdded;
@property(nonatomic,copy) NSString* lastFourOfCreditCard;

// Constructor
- (id) initWithJson:(NSObject*) jsonObject;
// Object to Json
+ (NSMutableDictionary*) serializeToJson:(accountCredit*) object;

@end
