//
//  parkingLot.m
//  FastPassParking
//
//  Created by Kerl on 10/29/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "parkingLot.h"

@implementation parkingLot

- (id) initWithJson:(NSObject*)jsonObject{
    self = [super init];
    if (self && jsonObject) {
        self.dbId = [jsonObject valueForKey:@"id"];
        self.clientId = [jsonObject valueForKey:@"clientId"];
        self.name = [jsonObject valueForKey:@"name"];
        
        // TODO: Properly parse this nested object
        self.centerLocation = [jsonObject valueForKey:@"geoLocation"];
        
        // TODO: Properly parse this arrays of objects
        self.coordinates = [jsonObject valueForKey:@"coordinates"];
        
        // TODO: Properly parse this nested object
        self.addressCity = [jsonObject valueForKey:@"city"];
        self.addressState = [jsonObject valueForKey:@"state"];
        self.addressStreet = [jsonObject valueForKey:@"street"];
        self.addressTimeZone = [jsonObject valueForKey:@"timeZone"];
        self.addressZipCode = [jsonObject valueForKey:@"zipcode"];
    }
    return self;
}

+ (NSMutableDictionary*) serializeToJson:(parkingLot*)object {
    
    NSMutableDictionary* wrapper;
    if(object) {
        wrapper = [[NSMutableDictionary alloc] init];
        NSMutableDictionary* newObject = [[NSMutableDictionary alloc] init];
        [newObject setObject:object.dbId forKey:@"id"];
        [newObject setObject:object.clientId forKey:@"clientId"];
        [newObject setObject:object.name forKey:@"name"];
        
        // TODO: Properly
        [newObject setObject:object.centerLocation forKey:@"geoLocation"];
        
        // TODO: Properly
        [newObject setObject:object.coordinates forKey:@"coordinates"];
        
        // TODO: Properly
        [newObject setObject:object.addressCity forKey:@"city"];
        [newObject setObject:object.addressState forKey:@"state"];
        [newObject setObject:object.addressStreet forKey:@"street"];
        [newObject setObject:object.addressTimeZone forKey:@"timeZone"];
        [newObject setObject:object.addressZipCode forKey:@"zipcode"];
        
        [wrapper setObject:newObject forKey:@"parkingLot"];
    }
    
    return wrapper;
}

@end
