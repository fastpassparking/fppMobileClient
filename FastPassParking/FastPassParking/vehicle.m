//
//  vehicle.m
//  FastPassParking
//
//  Created by Kyle Mera on 10/29/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "vehicle.h"
#import "JsonSerializerUtils.h"

@implementation vehicle

- (id) initWithJson:(NSObject*)jsonObject{
    self = [super init];
    if (self && jsonObject) {
        self.dbId = [jsonObject valueForKey:@"_id"];
        self.userId = [jsonObject valueForKey:@"userId"];
        self.licenseNumber = [jsonObject valueForKey:@"licensePlateNumber"];
        self.licenseState = [jsonObject valueForKey:@"licenseState"];
        
        self.make = [jsonObject valueForKey:@"make"];
        self.model = [jsonObject valueForKey:@"model"];
        self.color = [jsonObject valueForKey:@"color"];
        self.year = [jsonObject valueForKey:@"year"];
    }
    return self;
}

+ (NSMutableDictionary*) serializeToJson:(vehicle*)vehicleObject {
    
    NSMutableDictionary* vehicleWrapper;
    if(vehicleObject) {
        vehicleWrapper = [[NSMutableDictionary alloc] init];
        NSMutableDictionary* newVehicle = [[NSMutableDictionary alloc] init];
        [JsonSerializerUtils setObject:vehicleObject.dbId forKey:@"_id" forDictionary:newVehicle];
        [newVehicle setObject:vehicleObject.userId forKey:@"userId"];
        [newVehicle setObject:vehicleObject.licenseNumber forKey:@"licensePlateNumber"];
        [newVehicle setObject:vehicleObject.licenseState forKey:@"licenseState"];
        
        [newVehicle setObject:vehicleObject.make forKey:@"make"];
        [newVehicle setObject:vehicleObject.model forKey:@"model"];
        [newVehicle setObject:vehicleObject.color forKey:@"color"];
        [newVehicle setObject:vehicleObject.year forKey:@"year"];
        
        [vehicleWrapper setObject:newVehicle forKey:@"vehicle"];
    }
    
    return vehicleWrapper;
}

@end
