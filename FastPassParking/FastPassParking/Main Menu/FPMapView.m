//
//  FPMapView.m
//  FastPassParking
//
//  Created by Ivan Lugo on 10/5/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "FPMapView.h"

#define MERCATOR_OFFSET 268435456
#define MERCATOR_RADIUS 85445659.44705395

@implementation FPMapView


- (void) attachPinchGestureRecognizer
{
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(detectPinchStatus:)];
    
    //    self.pinchToZoom = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(detectPinchStatus:)];
    pinch.enabled = YES;
    pinch.delegate = self;
    self.pinchToZoom = pinch;
    
    [self addGestureRecognizer:pinch];
}

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void) detectPinchStatus:(UIGestureRecognizer*)gestureRecognizer
{
    if(gestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        [self updatePolygonsAndAnnotations];
    }
}

- (void) updatePolygonsAndAnnotations
{
    NSArray* views = [_parkingLotDataObjectsIDsToPolygons allValues];
    
    if([self getZoomLevel] <= 14.5)
    {
        for(FPParkingLotData* lot in views)
        {
            if(lot.polygonIsDrawn)
            {
                [self removeOverlay:lot];
                [self addAnnotation:lot];
                lot.polygonIsDrawn = NO;
                lot.annotationIsDrawn = YES;
            }
        }
    }
    else
    {
        for(FPParkingLotData* lot in views)
        {
            if(lot.annotationIsDrawn)
            {
                [self removeAnnotation:lot];
                [self addOverlay:lot];
                lot.polygonIsDrawn = YES;
                lot.annotationIsDrawn = NO;
            }
        }
    }
}


#pragma mark Map conversion methods

- (double)longitudeToPixelSpaceX:(double)longitude
{
    return round(MERCATOR_OFFSET + MERCATOR_RADIUS * longitude * M_PI / 180.0);
}

- (double)latitudeToPixelSpaceY:(double)latitude
{
    return round(MERCATOR_OFFSET - MERCATOR_RADIUS * logf((1 + sinf(latitude * M_PI / 180.0)) / (1 - sinf(latitude * M_PI / 180.0))) / 2.0);
}

- (double)pixelSpaceXToLongitude:(double)pixelX
{
    return ((round(pixelX) - MERCATOR_OFFSET) / MERCATOR_RADIUS) * 180.0 / M_PI;
}

- (double)pixelSpaceYToLatitude:(double)pixelY
{
    return (M_PI / 2.0 - 2.0 * atan(exp((round(pixelY) - MERCATOR_OFFSET) / MERCATOR_RADIUS))) * 180.0 / M_PI;
}



- (double)getZoomLevel{
    MKCoordinateRegion reg=self.region; // the current visible region
    MKCoordinateSpan span=reg.span; // the deltas
    CLLocationCoordinate2D centerCoordinate=reg.center; // the center in degrees
    // Get the left and right most lonitudes
    CLLocationDegrees leftLongitude=(centerCoordinate.longitude-(span.longitudeDelta/2));
    CLLocationDegrees rightLongitude=(centerCoordinate.longitude+(span.longitudeDelta/2));
    CGSize mapSizeInPixels = self.bounds.size; // the size of the display window
    
    // Get the left and right side of the screen in fully zoomed-in pixels
    double leftPixel=[self longitudeToPixelSpaceX:leftLongitude];
    double rightPixel=[self longitudeToPixelSpaceX:rightLongitude];
    // The span of the screen width in fully zoomed-in pixels
    double pixelDelta=abs(rightPixel-leftPixel);
    
    // The ratio of the pixels to what we're actually showing
    double zoomScale= mapSizeInPixels.width /pixelDelta;
    // Inverse exponent
    double zoomExponent=log2(zoomScale);
    // Adjust our scale
    double zoomLevel=zoomExponent+20;
    return zoomLevel;
}

@end
