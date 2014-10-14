//
//  FPLotDetailViewController.m
//  FastPassParking
//
//  Created by Darin Doria on 10/5/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "FPLotDetailViewController.h"

@implementation FPLotDetailViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    _main.implementation.frame = _lotDetailMapView.frame;
    [_lotDetailMapView addSubview:_main.implementation];
    
    
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    _main.implementation.frame = _main.mapView.frame;
    [_main.mapView addSubview:_main.implementation];
}

@end
