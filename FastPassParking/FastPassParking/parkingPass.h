//
//  parkingPass.h
//  FastPassParking
//
//  Created by Kerl on 10/29/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "geoCoordinate.h"

@interface parkingPass : NSObject

@property(nonatomic,copy) NSString* dbId;
@property(nonatomic,copy) NSString* vehicleId;
@property(nonatomic,copy) NSString* parkingLotId;
@property(nonatomic,copy) NSString* parkingType;
@property(nonatomic,copy) geoCoordinate* parkingLocation;
@property(nonatomic,copy) NSNumber* parkingLocationLatitude;
@property(nonatomic,copy) NSNumber* parkingLocationLongitude;
@property(nonatomic,copy) NSDate* startDateTime;
@property(nonatomic,copy) NSDate* endDateTime;
@property(nonatomic,copy) NSArray* parkingPayments;

// Constructor
- (id) initWithJson:(NSObject*) jsonObject;
// Object to Json
+ (NSMutableDictionary*) serializeToJson:(parkingPass*) userObject;

@end
