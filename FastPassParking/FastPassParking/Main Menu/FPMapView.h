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


@interface FPMapView : MKMapView <UIGestureRecognizerDelegate>

@property (nonatomic, assign) double lastZoomLevel;

@property (strong, nonatomic) UIPinchGestureRecognizer* pinchToZoom;
@property (weak, nonatomic) NSMutableDictionary* parkingLotDataObjectsIDsToPolygons;

// Main map view
- (double) getZoomLevel;

- (void) detectPinchStatus:(UIGestureRecognizer*)gestureRecognizer;
- (void) attachPinchGestureRecognizer;

@end
