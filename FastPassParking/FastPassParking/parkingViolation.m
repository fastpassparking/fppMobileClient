//
//  parkingViolation.m
//  FastPassParking
//
//  Created by Kyle Mera on 10/29/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "parkingViolation.h"

@implementation parkingViolation

- (id) initWithJson:(NSObject*)jsonObject{
    self = [super init];
    if (self && jsonObject) {
        self.dbId = [jsonObject valueForKey:@"id"];
        self.vehicleId = [jsonObject valueForKey:@"vehicleId"];
        self.dateTimeGiven = [jsonObject valueForKey:@"givenDateTime"];
        self.violationStartTime = [jsonObject valueForKey:@"violationStartTime"];
        self.violationEndTime = [jsonObject valueForKey:@"violationEndTime"];
        self.violationFee = [jsonObject valueForKey:@"violationFee"];
        self.outstanding = [jsonObject valueForKey:@"outstanding"];
    }
    return self;
}

+ (NSMutableDictionary*) serializeToJson:(parkingViolation*)object {
    
    NSMutableDictionary* wrapper;
    if(object) {
        wrapper = [[NSMutableDictionary alloc] init];
        NSMutableDictionary* newObject = [[NSMutableDictionary alloc] init];
        [newObject setObject:object.dbId forKey:@"id"];
        [newObject setObject:object.vehicleId forKey:@"vehicleId"];
        [newObject setObject:object.dateTimeGiven forKey:@"givenDateTime"];
        [newObject setObject:object.violationStartTime forKey:@"violationStartTime"];
        [newObject setObject:object.violationEndTime forKey:@"violationEndTime"];
        [newObject setObject:object.violationFee forKey:@"violationFee"];
        [newObject setObject:[NSNumber numberWithBool:object.outstanding] forKey:@"outstanding"];
        
        [wrapper setObject:newObject forKey:@"parkingViolation"];
    }
    
    return wrapper;
}

@end
