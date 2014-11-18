//
//  parkingLot.h
//  FastPassParking
//
//  Created by Kerl on 10/29/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "geoCoordinate.h"

@interface parkingLot : NSObject

@property(nonatomic,copy) NSString* dbId;
@property(nonatomic,copy) NSString* clientId;
@property(nonatomic,copy) NSString* name;
@property(nonatomic,copy) NSNumber* costPerHour;
@property(nonatomic,copy) geoCoordinate* centerLocation;
@property(nonatomic,copy) NSArray* coordinates;
@property(nonatomic,copy) NSString* addressStreet;
@property(nonatomic,copy) NSString* addressState;
@property(nonatomic,copy) NSString* addressCity;
@property(nonatomic,copy) NSString* addressZipCode;
@property(nonatomic,copy) NSString* addressTimeZone;

// Constructor
- (id) initWithJson:(NSObject*) jsonObject;
// Object to Json
+ (NSMutableDictionary*) serializeToJson:(parkingLot*) object;

@end
