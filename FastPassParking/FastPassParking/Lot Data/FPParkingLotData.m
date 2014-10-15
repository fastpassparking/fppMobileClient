//
//  FPParkingLotData.m
//  FastPassParking
//
//  Created by Ivan Lugo on 10/12/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "FPParkingLotData.h"
#define kFPPAnnotationReuseIdentifier @"kFPPAnnotationReuseIdentifier"


@implementation FPParkingLotData

+ (FPParkingLotData*) createPolygonWithCoordinates:(CLLocationCoordinate2D *)coords andCount:(NSUInteger)count
{
    return [FPParkingLotData polygonWithCoordinates:coords count:count];
}

@end

@implementation FPParkingLotAnnotation

+ (FPParkingLotAnnotation*) initWithAnnotation:(id<MKAnnotation>)annotation
{
    return [[FPParkingLotAnnotation alloc ] initWithAnnotation:annotation reuseIdentifier:kFPPAnnotationReuseIdentifier];
}

@end
