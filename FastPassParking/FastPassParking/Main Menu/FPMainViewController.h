//
//  FPMainViewController.h
//  FastPassParking
//
//  Created by Ivan Lugo on 10/5/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPMapView.h"

@interface FPMainViewController : UIViewController <MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource>


// Storyboard
@property (strong, nonatomic) IBOutlet FPMapView *mapView;
@property (strong, nonatomic) IBOutlet UITableView *parkingLotTableView;

// User Information
@property (weak, nonatomic) IBOutlet UILabel *userFundsLabel;

// ParkingLotData
@property (strong, nonatomic) NSMutableDictionary* parkingLotDataObjectsIDsToPolygons;

#pragma MapView Delegate
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView
            rendererForOverlay:(id<MKOverlay>)overlay;


@end