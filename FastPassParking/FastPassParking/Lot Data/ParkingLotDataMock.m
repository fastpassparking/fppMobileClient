//
//  ParkingLotDataMock.m
//  FastPassParking
//
//  Created by Ivan Lugo on 10/5/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "ParkingLotDataMock.h"

@implementation ParkingLotDataMock

+ (ParkingLotDataMock*) createPolygonWithCoordinates:(CLLocationCoordinate2D *)coords andCount:(NSUInteger)count
{
    return [ParkingLotDataMock polygonWithCoordinates:coords count:count];
}

@end
