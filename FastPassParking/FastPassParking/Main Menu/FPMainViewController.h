//
//  FPMainViewController.h
//  FastPassParking
//
//  Created by Ivan Lugo on 10/5/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPMapView.h"
#import "AppDelegate.h"

@interface FPMainViewController : UIViewController <MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource, FPMapViewDelegate> {
    AppDelegate* appDelegate;
}


// Storyboard
@property (strong, nonatomic) IBOutlet UIView *mapView;

@property (strong, nonatomic) IBOutlet UITableView *parkingLotTableView;
@property (strong, nonatomic) FPMapView* implementation;

// User Information
@property (weak, nonatomic) IBOutlet UILabel *userFundsLabel;

// ParkingLotData
@property (strong, nonatomic) NSMutableDictionary* parkingLotDataObjectsIDsToPolygons;
@property (strong, nonatomic) FPParkingLotData* selectedLot;

@property (strong, nonatomic) UIView* pin;

#pragma MapView Delegate
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView
            rendererForOverlay:(id<MKOverlay>)overlay;


@end