//
//  parkingViolation.h
//  FastPassParking
//
//  Created by Kyle Mera on 10/29/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface parkingViolation : NSObject

@property(nonatomic,copy) NSString* dbId;
@property(nonatomic,copy) NSString* vehicleId;
@property(nonatomic,copy) NSDate* dateTimeGiven;
@property(nonatomic,copy) NSDate* violationStartTime;
@property(nonatomic,copy) NSDate* violationEndTime;
@property(nonatomic,copy) NSArray* coordinates;
@property(nonatomic,copy) NSNumber* violationFee;
@property (assign) BOOL outstanding;

// Constructor
- (id) initWithJson:(NSObject*) jsonObject;
// Object to Json
+ (NSMutableDictionary*) serializeToJson:(parkingViolation*) object;

@end
