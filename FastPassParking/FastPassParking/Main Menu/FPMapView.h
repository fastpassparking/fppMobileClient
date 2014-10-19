//
//  FPMapView.h
//  FastPassParking
//
//  Created by Ivan Lugo on 10/5/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "FPParkingLotData.h"

@protocol FPMapViewDelegate <NSObject>

- (void)respondToTapSelectionOfLotData:(FPParkingLotData*)lot;

@end

@interface FPMapView : MKMapView <UIGestureRecognizerDelegate>

@property (nonatomic, assign) double lastZoomLevel;

@property (strong, nonatomic) UIPinchGestureRecognizer* pinchToZoom;
@property (strong, nonatomic) UITapGestureRecognizer* tapRecognizer;
@property (strong, nonatomic) FPParkingLotData* tapSelectedLot;
@property (weak, nonatomic) id <FPMapViewDelegate> mapDelegate;

@property (weak, nonatomic) NSMutableDictionary* parkingLotDataObjectsIDsToPolygons;

// Main map view
- (double) getZoomLevel;


// Gesture recognizers
- (void) detectPinchStatus:(UIGestureRecognizer*)gestureRecognizer;
- (void) attachPinchGestureRecognizer;
- (void) attachTapGestureRecognizer;

// Rendering helpers
- (void) updatePolygonsAndAnnotationsAndForceDraw:(BOOL)force;

@end
