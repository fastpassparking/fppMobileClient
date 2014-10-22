//
//  FPParkingLot.m
//  FastPassParking
//
//  Created by Darin Doria on 10/14/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "FPParkingLot.h"

@implementation FPParkingLot

- (instancetype) initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self) {
        _name = dictionary[@"name"];
        __id = dictionary[@"_id"];
    }
    return self;
}


@end
