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

// Core Lot Details
@property (nonatomic, strong) NSString* parkingLotName;
@property (nonatomic, strong) NSString* parkingLotDocumentID;


// Rendering
@property (nonatomic, strong) MKPolygonRenderer* rendererForLot;
@property (nonatomic, assign) BOOL polygonIsDrawn;
@property (nonatomic, assign) BOOL annotationIsDrawn;


# pragma mark - MKPolygon Creation

+ (FPParkingLotData*) createPolygonWithCoordinates:(CLLocationCoordinate2D*)coords andCount:(NSUInteger)count;

@end


# pragma mark - MKAnnotation Protocol Handling

@interface FPParkingLotAnnotation : MKAnnotationView

@property (nonatomic, strong) FPParkingLotData* lotForView;

+ (FPParkingLotAnnotation*) initWithAnnotation:(id<MKAnnotation>)annotation;

@end