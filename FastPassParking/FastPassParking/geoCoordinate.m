//
//  geoCoordinate.m
//  FastPassParking
//
//  Created by Kyle Mera on 10/29/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "geoCoordinate.h"

@implementation geoCoordinate

- (id) initWithJson:(NSObject*)jsonObject{
    self = [super init];
    if (self && jsonObject) {
        self.latitude = [jsonObject valueForKey:@"latitude"];
        self.longitude = [jsonObject valueForKey:@"longitude"];
    }
    return self;
}

+ (NSMutableDictionary*) serializeToJson:(geoCoordinate*)object {
    
    NSMutableDictionary* newObject;
    if(object) {
        newObject = [[NSMutableDictionary alloc] init];
        [newObject setObject:object.latitude forKey:@"latitude"];
        [newObject setObject:object.longitude forKey:@"longitude"];
    }
    
    return newObject;
}

+ (NSMutableDictionary*) serializeToJsonWithWrapper:(geoCoordinate*)object {
    
    NSMutableDictionary* wrapper;
    if(object) {
        wrapper = [[NSMutableDictionary alloc] init];
        NSMutableDictionary* newObject = [[NSMutableDictionary alloc] init];
        [newObject setObject:object.latitude forKey:@"latitude"];
        [newObject setObject:object.longitude forKey:@"longitude"];
        
        [wrapper setObject:newObject forKey:@"geoLocation"];
    }
    
    return wrapper;
}

@end
