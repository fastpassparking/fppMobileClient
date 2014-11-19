//
//  FPLotDetailViewController.m
//  FastPassParking
//
//  Created by Darin Doria on 10/5/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "FPLotDetailViewController.h"
#import "parkingLot.h"
#import "AppDelegate.h"
#import "ParkingPassHandler.h"
#import "parkingPayment.h"

@implementation FPLotDetailViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    
    [_parkingLotName setText:appDelegate.selectedParkingLot.name];
    [_ParkinLotAddress setText:appDelegate.selectedParkingLot.addressStreet];
    [_parkingLotCityStateZip setText: [NSString stringWithFormat:@"%@, %@ %@",appDelegate.selectedParkingLot.addressCity,appDelegate.selectedParkingLot.addressState,appDelegate.selectedParkingLot.addressZipCode]];
    
    
    
    
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

- (IBAction)parkButtonclicked:(id)sender{
    
    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    parkingPayment* Payment = [parkingPayment alloc];
    NSNumber *time = [NSNumber numberWithInt:180];
    NSNumber *hour = [NSNumber numberWithInt:60];
    NSNumber *timePerHour = [NSNumber numberWithInt:(time.intValue / hour.intValue)];
    NSNumber *ammount = [NSNumber numberWithInt:(timePerHour.intValue * appDelegate.selectedParkingLot.costPerHour.intValue)];
    
    Payment.amountOfTime = time;
    Payment.paymentAmount = ammount;
    
    [ParkingPassHandler createParkingPass:Payment withLotId:appDelegate.selectedParkingLot.dbId withVehicleId:appDelegate.selectedVehicle.dbId withCompletionHandler:^(BOOL success, parkingPass *currentPass) {
        
        if(success == YES){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *updateComplete = [[UIAlertView alloc] initWithTitle:@"Parking Pass Purchased" message:@"Click OK to Continue" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil, nil];
                
                [updateComplete show];
            });
            
            
        }
        
        else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *updateComplete = [[UIAlertView alloc] initWithTitle:@"Parking Pass Purchase Failed" message:@"Click OK to Continue" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil, nil];
                
                [updateComplete show];
            });
            
            
        }
        
    }];
    
    
}

@end