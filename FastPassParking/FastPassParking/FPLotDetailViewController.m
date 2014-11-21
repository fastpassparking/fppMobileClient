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
#import "userHandler.h"
#import "parkingPayment.h"
#import "SWRevealViewController.h"

@implementation FPLotDetailViewController
{
    int _numberOfHoursToPark;
    int _numberOfMinToPark;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    //self.navigationItem.leftBarButtonItem.title = @"Back";
    
    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    
    [_parkingLotName setText:appDelegate.selectedParkingLot.name];
    [_ParkinLotAddress setText:appDelegate.selectedParkingLot.addressStreet];
    [_parkingLotCityStateZip setText: [NSString stringWithFormat:@"%@, %@ %@",appDelegate.selectedParkingLot.addressCity,appDelegate.selectedParkingLot.addressState,appDelegate.selectedParkingLot.addressZipCode]];
    
    double cost = [appDelegate.selectedParkingLot.costPerHour doubleValue];
    [_costPerHourLabel setText: [NSString stringWithFormat:@"Cost Per Hour: $%.02lf", cost]];
    
    self.fundsPicker.delegate = self;
    self.fundsPicker.dataSource = self;
    
  //  [_fundsPicker selectRow:2 inComponent:0 animated:NO];
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

#pragma mark - UIPickerView Delegate
//- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    NSString *title = @"sample title";
//    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
//
//    return attString;
//
//}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
    NSLog(@"Selected row: %ld", row);
    if (component == 0) {
        _numberOfHoursToPark = row;
    } else
    {
        _numberOfMinToPark = row * 15;
    }
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger hoursRow = 13;
    NSUInteger minutesRow = 4;
    
    if (component == 0)
        return hoursRow;
    
    return minutesRow;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
    
    if (component == 0)
    {
        title = [@"" stringByAppendingFormat:@"%ld",row];
    }
    else
    {
        title = [@"" stringByAppendingFormat:@"%02ld",row * 15];
    }
    return title;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 70;
    
    return sectionWidth;
}

- (IBAction)parkButtonclicked:(id)sender{
    

    
    
    
    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    _Payment = [parkingPayment alloc];
    NSNumber *time = [NSNumber numberWithFloat:((_numberOfHoursToPark*60))];
    NSNumber *hour = [NSNumber numberWithInt:60];
    NSNumber *timePerHour = [NSNumber numberWithInt:(time.intValue / hour.intValue)];
    NSNumber *timePerMinute = [NSNumber numberWithInt:((int)_numberOfMinToPark % hour.intValue)];
    NSNumber *ammount = [NSNumber numberWithDouble:(timePerHour.doubleValue * appDelegate.selectedParkingLot.costPerHour.doubleValue) +((timePerMinute.doubleValue / 60.0) * appDelegate.selectedParkingLot.costPerHour.doubleValue)];
    NSNumber *currentCredit = appDelegate.loggedInUser.availableCredit;
    
    _Payment.amountOfTime = [NSNumber numberWithInt:(time.intValue + _numberOfMinToPark)];
    _Payment.paymentAmount = ammount;
    
    NSLog(@"Current Credit: %f\n",currentCredit.doubleValue);
    NSLog(@"Ammount: %f",ammount.doubleValue);
    
    if (_numberOfHoursToPark == 0 && _numberOfMinToPark == 0)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You must select an amount of time to park"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil, nil];
            
            [alert show];
        });
    }
    
    else{
    
    if (currentCredit.doubleValue < ammount.doubleValue) {
       
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *updateComplete = [[UIAlertView alloc] initWithTitle:@"Insufficient Funds" message:@"Click OK to Continue" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil, nil];
            
            [updateComplete show];
        });
    }
    
    else{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *updateComplete = [[UIAlertView alloc] initWithTitle:@"Confirm Purchase" message:[NSString stringWithFormat:@"%d Hours %d Minutes for $%.02f",_numberOfHoursToPark,_numberOfMinToPark,ammount.doubleValue] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: @"Cancel", nil];
            
            updateComplete.tag = 1;
            
            [updateComplete show];
        });
    
      }
        
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    
    if(alertView.tag == 1){
        
        if(buttonIndex == 0){
            [self createTheParkingPass];
            
        }
        
        else if(buttonIndex == 1){
        
           
    }
        
    }
    
}

- (void) createTheParkingPass{
    
    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    
    [ParkingPassHandler createParkingPass:_Payment withLotId:appDelegate.selectedParkingLot.dbId withVehicleId:appDelegate.selectedVehicle.dbId withCompletionHandler:^(BOOL success, parkingPass* currentPass) {
        
        if(success == YES){
            
            
            
            
            NSNumber *updatedCredit = [NSNumber numberWithDouble: appDelegate.loggedInUser.availableCredit.doubleValue - _Payment.paymentAmount.doubleValue];
            
            appDelegate.loggedInUser.availableCredit = updatedCredit;
            
            
            [UserHandler updateAccount:appDelegate.loggedInUser
                 withCompletionHandler:^(BOOL success, user* returnedUser) {
                     
                     if (success) {
                         NSLog(@"Success");
                         
                        // [self.navigationController popViewControllerAnimated:YES];
                         dispatch_async(dispatch_get_main_queue(), ^{

                        [self.navigationController popViewControllerAnimated:YES];
                             [self.navigationController viewDidLoad];
                         });
                     }
                     
                     else
                         NSLog(@"No Success");
                     
                 }];
            
        }
        
        else {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *updateComplete = [[UIAlertView alloc] initWithTitle:@"Parking Pass Purchase Failed" message:@"Click OK to Continue" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil, nil];
                
                [updateComplete show];
            });
            
        }
        
    }];

    
    
}


@end