//
//  ParkingLotHandler.h
//  FastPassParking
//
//  Created by Kyle Mera on 11/2/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParkingLotHandler : NSObject

+(void) getParkingLotsForBoundingBox:(NSNumber*) minLat withMaxLat:(NSNumber*) maxLat
                         withMinLong:(NSNumber*) minLong withMaxLong:(NSNumber*) maxLong
                         withCompletionHandler:(void(^)(BOOL, NSArray*)) handler;

@end
