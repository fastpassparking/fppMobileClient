//
//  parkingPass.m
//  FastPassParking
//
//  Created by Kerl on 10/29/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "parkingPass.h"

@implementation parkingPass

- (id) initWithJson:(NSObject*)jsonObject{
    self = [super init];
    if (self && jsonObject) {
        self.dbId = [jsonObject valueForKey:@"_id"];
        self.vehicleId = [jsonObject valueForKey:@"vehicleId"];
        self.parkingLotId = [jsonObject valueForKey:@"parkingLotId"];
        self.parkingLotName = [jsonObject valueForKey:@"parkingLotName"];
        
        NSDate *startDate, *endDate;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSz"];
        startDate = [dateFormatter dateFromString:[(NSDictionary*)jsonObject objectForKey:@"startDateTime"]];
        endDate = [dateFormatter dateFromString:[(NSDictionary*)jsonObject objectForKey:@"endDateTime"]];
        
        self.startDateTime = startDate;
        self.endDateTime = endDate;
        
        // TODO: Properly parse these fields
        self.parkingLocation = [jsonObject valueForKey:@"parkingLocation"];
        
        // TODO: Properly parse this array of parking payments objects
        self.parkingPayments = [jsonObject valueForKey:@"parkingPayments"];
    }
    return self;
}

+ (NSMutableDictionary*) serializeToJson:(parkingPass*)parkingPassObject {
    
    NSMutableDictionary* parkingPassWrapper;
    if(parkingPassObject) {
        parkingPassWrapper = [[NSMutableDictionary alloc] init];
        NSMutableDictionary* newParkingPass = [[NSMutableDictionary alloc] init];
        [newParkingPass setObject:parkingPassObject.dbId forKey:@"_id"];
        [newParkingPass setObject:parkingPassObject.parkingLotId forKey:@"parkingLotId"];
        [newParkingPass setObject:parkingPassObject.vehicleId forKey:@"vehicleId"];
        [newParkingPass setObject:parkingPassObject.parkingLotName forKey:@"parkingLotName"];
        [newParkingPass setObject:parkingPassObject.startDateTime forKey:@"startDateTime"];
        [newParkingPass setObject:parkingPassObject.endDateTime forKey:@"endDateTime"];
        
        // TODO: Properly set these nested json fields
        [newParkingPass setObject:parkingPassObject.parkingLocation forKey:@"parkingLocation"];
        
        // TODO: Properly set this array of parking payment objects
        [newParkingPass setObject:parkingPassObject.parkingPayments forKey:@"parkingPayments"];
        
        [parkingPassWrapper setObject:newParkingPass forKey:@"parkingPass"];
    }
    
    return parkingPassWrapper;
}

@end
