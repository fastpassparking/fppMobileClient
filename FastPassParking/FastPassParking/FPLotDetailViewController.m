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
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _main.implementation.userInteractionEnabled = NO;

}

- (void) viewWillLayoutSubviews
{
    _main.implementation.frame = _lotDetailMapView.frame;
    [_lotDetailMapView addSubview:_main.implementation];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_main.implementation removeOverlay:_lot];
    [_main.implementation updatePolygonsAndAnnotationsAndForceDraw:YES];

    _main.implementation.userInteractionEnabled = YES;
    
}

@end