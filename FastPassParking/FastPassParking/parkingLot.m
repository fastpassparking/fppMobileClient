//
//  parkingLot.m
//  FastPassParking
//
//  Created by Kyle Mera on 10/29/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "parkingLot.h"

@implementation parkingLot

- (id) initWithJson:(NSObject*)jsonObject{
    self = [super init];
    if (self && jsonObject) {
        self.dbId = [jsonObject valueForKey:@"_id"];
        self.clientId = [jsonObject valueForKey:@"clientId"];
        self.name = [jsonObject valueForKey:@"name"];
        self.costPerHour = [jsonObject valueForKey:@"costPerHour"];
        
        // TODO: Properly parse this nested object
        self.centerLocation = [jsonObject valueForKey:@"centerLocation"];
        
        // TODO: Properly parse this arrays of objects
        self.coordinates = [jsonObject valueForKey:@"coordinates"];
        
        // TODO: Properly parse this nested object
        self.addressCity = [jsonObject valueForKeyPath:@"address.city"];
        self.addressState = [jsonObject valueForKeyPath:@"address.state"];
        self.addressStreet = [jsonObject valueForKeyPath:@"address.street"];
//        self.addressTimeZone = [jsonObject valueForKeyPath:@"address.timeZone"];
        self.addressZipCode = [jsonObject valueForKeyPath:@"address.zipcode"];
    }
    return self;
}

+ (NSMutableDictionary*) serializeToJson:(parkingLot*)object {
    
    NSMutableDictionary* wrapper;
    if(object) {
        wrapper = [[NSMutableDictionary alloc] init];
        NSMutableDictionary* newObject = [[NSMutableDictionary alloc] init];
        [newObject setObject:object.dbId forKey:@"_id"];
        [newObject setObject:object.clientId forKey:@"clientId"];
        [newObject setObject:object.name forKey:@"name"];
        [newObject setObject:object.costPerHour forKey:@"costPerHour"];
        
        // TODO: Properly
        [newObject setObject:object.centerLocation forKey:@"centerLocation"];
        
        // TODO: Properly
        [newObject setObject:object.coordinates forKey:@"coordinates"];
        
        // TODO: Properly
        [newObject setObject:object.addressCity forKey:@"city"];
        [newObject setObject:object.addressState forKey:@"state"];
        [newObject setObject:object.addressStreet forKey:@"street"];
//        [newObject setObject:object.addressTimeZone forKey:@"timeZone"];
        [newObject setObject:object.addressZipCode forKey:@"zipcode"];
        
        [wrapper setObject:newObject forKey:@"parkingLot"];
    }
    
    return wrapper;
}

@end
