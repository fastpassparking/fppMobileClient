//
//  VehicleHandler.h
//  FastPassParking
//
//  Created by Kyle Mera on 11/2/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "vehicle.h"
#import "httpRequestHandler.h"

@interface VehicleHandler : NSObject

+(void) getVehiclesForUser:(NSString*) userId withCompletionHandler:(void(^)(BOOL, NSArray*)) handler;
+(void) createVehicle:(vehicle*) vehicleObject withUserId:(NSString*) userId withCompletionHandler:(void(^)(BOOL, vehicle*)) handler;
+(void) updateVehicle:(vehicle*) vehicleObject withUserId:(NSString*) userId withCompletionHandler:(void(^)(BOOL, vehicle*)) handler;


@end
