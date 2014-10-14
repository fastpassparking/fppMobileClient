//
//  FPParkingLotData.h
//  FastPassParking
//
//  Created by Ivan Lugo on 10/12/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface FPParkingLotData : MKPolygon <MKAnnotation>

@property (nonatomic, strong) NSString* parkingLotName;
@property (nonatomic, strong) NSString* parkingLotDocumentID;

@property (nonatomic, strong) MKPolygonRenderer* rendererForLot;
@property (nonatomic, assign) BOOL polygonIsDrawn;
@property (nonatomic, assign) BOOL annotationIsDrawn;

+ (FPParkingLotData*) createPolygonWithCoordinates:(CLLocationCoordinate2D*)coords andCount:(NSUInteger)count;

@end
