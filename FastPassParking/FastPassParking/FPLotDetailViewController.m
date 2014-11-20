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

@implementation FPLotDetailViewController
{
    float _numberOfHoursToPark;
    float _numberOfMinToPark;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    
    [_parkingLotName setText:appDelegate.selectedParkingLot.name];
    [_ParkinLotAddress setText:appDelegate.selectedParkingLot.addressStreet];
    [_parkingLotCityStateZip setText: [NSString stringWithFormat:@"%@, %@ %@",appDelegate.selectedParkingLot.addressCity,appDelegate.selectedParkingLot.addressState,appDelegate.selectedParkingLot.addressZipCode]];
    
    double cost = [appDelegate.selectedParkingLot.costPerHour doubleValue];
    [_costPerHourLabel setText: [NSString stringWithFormat:@"Cost Per Hour: $%.02lf", cost]];
    
    self.fundsPicker.delegate = self;
    self.fundsPicker.dataSource = self;
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
        _numberOfMinToPark = row * 0.15;
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
    
    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    parkingPayment* Payment = [parkingPayment alloc];
    NSNumber *time = [NSNumber numberWithFloat:((_numberOfHoursToPark*60)+_numberOfMinToPark)];
    NSNumber *hour = [NSNumber numberWithInt:60];
    NSNumber *timePerHour = [NSNumber numberWithInt:(time.intValue / hour.intValue)];
    NSNumber *ammount = [NSNumber numberWithDouble:(timePerHour.doubleValue * appDelegate.selectedParkingLot.costPerHour.doubleValue)];
    NSNumber *currentCredit = appDelegate.loggedInUser.availableCredit;
    
    Payment.amountOfTime = time;
    Payment.paymentAmount = ammount;
    
    NSLog(@"Current Credit: %f\n",currentCredit.doubleValue);
    NSLog(@"Ammount: %f",ammount.doubleValue);
    
    if (currentCredit.doubleValue < ammount.doubleValue) {
       
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *updateComplete = [[UIAlertView alloc] initWithTitle:@"Insufficient Funds" message:@"Click OK to Continue" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil, nil];
            
            [updateComplete show];
        });
    }
    
    else{
    
        [ParkingPassHandler createParkingPass:Payment
                                    withLotId:appDelegate.selectedParkingLot.dbId
                                withVehicleId:appDelegate.selectedVehicle.dbId
                        withCompletionHandler:^(BOOL success, parkingPass *currentPass) {
        
                            if(success == YES){
            
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    UIAlertView *updateComplete = [[UIAlertView alloc] initWithTitle:@"Parking Pass Purchased"
                                                                                             message:@"Click OK to Continue"
                                                                                            delegate:self
                                                                                   cancelButtonTitle:@"OK"
                                                                                   otherButtonTitles: nil, nil];
                
                                    [updateComplete show];
                                });
            
            
                                NSNumber *updatedCredit = [NSNumber numberWithDouble: currentCredit.doubleValue - ammount.doubleValue];
                                appDelegate.loggedInUser.availableCredit = updatedCredit;
            
                                
                                [UserHandler updateAccount:appDelegate.loggedInUser
                                     withCompletionHandler:^(BOOL success, user* returnedUser) {
                
                                         if (success) {
                                             NSLog(@"Success");
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
    
}

@end