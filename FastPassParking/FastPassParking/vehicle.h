//
//  vehicle.h
//  FastPassParking
//
//  Created by Kyle Mera on 10/29/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface vehicle : NSObject

@property(nonatomic,copy) NSString* dbId;
@property(nonatomic,copy) NSString* userId;
@property(nonatomic,copy) NSString* licenseNumber;
@property(nonatomic,copy) NSString* licenseState;
@property(nonatomic,copy) NSString* make;
@property(nonatomic,copy) NSString* model;
@property(nonatomic,copy) NSString* color;
@property(nonatomic,copy) NSString* year;

// Constructor
- (id) initWithJson:(NSObject*) jsonObject;
// Object to Json
+ (NSMutableDictionary*) serializeToJson:(vehicle*) vehicleObject;

@end
