//
//  FPLotDetailViewController.h
//  FastPassParking
//
//  Created by Darin Doria on 10/5/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPMainViewController.h"
#import "parkingPayment.h"

@interface FPLotDetailViewController : UIViewController < UIPickerViewDelegate, UIPickerViewDataSource >

@property (weak, nonatomic) IBOutlet UIView *lotDetailMapView;
@property (weak, nonatomic) IBOutlet UILabel *parkingLotName;
@property (weak, nonatomic) IBOutlet UILabel *ParkinLotAddress;
@property (weak, nonatomic) IBOutlet UILabel *parkingLotCityStateZip;
@property (weak, nonatomic) IBOutlet UILabel *costPerHourLabel;
@property (strong, nonatomic) IBOutlet UIPickerView *fundsPicker;

@property (weak, nonatomic) FPMainViewController* main;
@property (weak, nonatomic) FPParkingLotData* lot;

@property (strong,nonatomic) parkingPayment* Payment;

- (IBAction)parkButtonclicked:(id)sender;

@end