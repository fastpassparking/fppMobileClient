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
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(detectPinchStatus:)];
    
    pinch.enabled = YES;
    pinch.delegate = self;
    self.pinchToZoom = pinch;
    
    [self addGestureRecognizer:pinch];
}

- (void) attachTapGestureRecognizer
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(userDidTapMap:)];
    tap.enabled = YES;
    tap.delegate = self;
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    
    self.tapRecognizer = tap;
    
    [self addGestureRecognizer:tap];
}

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void) userDidTapMap:(UITapGestureRecognizer*)gesture
{
    if([self getZoomLevel] <= 14.5)
        return;
    
    CGPoint point = [gesture locationInView:self];
    CLLocationCoordinate2D tapPoint = [self convertPoint:point toCoordinateFromView:self];
    
    double delta = 0.00000001;
    CLLocationCoordinate2D topLeft = CLLocationCoordinate2DMake(tapPoint.latitude + delta, tapPoint.longitude - delta);
    CLLocationCoordinate2D topRight = CLLocationCoordinate2DMake(tapPoint.latitude + delta, tapPoint.longitude + delta); ;
    CLLocationCoordinate2D bottom = CLLocationCoordinate2DMake(tapPoint.latitude - delta, tapPoint.longitude);
    
    CLLocationCoordinate2D* touchTri = malloc(sizeof(CLLocationCoordinate2D) * 4);
    touchTri[0] = topLeft;
    touchTri[1] = topRight;
    touchTri[2] = bottom;
    touchTri[3] = topLeft;
    
    MKPolygon* touchPoly = [MKPolygon polygonWithCoordinates:touchTri count:4];
    
    NSArray* visible = [_parkingLotDataObjectsIDsToPolygons allValues];
    BOOL continueSearch = YES;
    for(FPParkingLotData* polygon in visible)
    {
        if([polygon isKindOfClass:[FPParkingLotData class]] &&
           [polygon intersectsMapRect:[touchPoly boundingMapRect]])
        {
            if([_mapDelegate respondsToSelector:@selector(respondToTapSelectionOfLotData:)])
            {
                [_mapDelegate performSelector:@selector(respondToTapSelectionOfLotData:) withObject:polygon];
                continueSearch = NO;
            }
        }


    }
}

- (void) didMoveToSuperview
{
    [self updatePolygonsAndAnnotationsAndForceDraw:NO];
    [self setNeedsDisplay];
}

- (void) detectPinchStatus:(UIGestureRecognizer*)gestureRecognizer
{
    if(gestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        [self updatePolygonsAndAnnotationsAndForceDraw:NO];
    }
}

- (void) updatePolygonsAndAnnotationsAndForceDraw:(BOOL)force
{
    NSArray* views = [_parkingLotDataObjectsIDsToPolygons allValues];
    
    if(force)
    {
        for(FPParkingLotData* lot in views)
        {
            [self addOverlay:lot];
            [self removeAnnotation:lot];
            lot.polygonIsDrawn = YES;
            lot.annotationIsDrawn = NO;
        }
        
        return;
    }
    
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
