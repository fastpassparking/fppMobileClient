//
//  CreditCardInfo.m
//  FastPassParking
//
//  Created by Alex Gordon on 10/12/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "CreditCardInfo.h"
#import "userHandler.h"
#import "VehicleHandler.h"
#import "AppDelegate.h"

@interface CreditCardInfo ()
@property (weak, nonatomic) IBOutlet UITextField *typeTextField;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;
@property (weak, nonatomic) IBOutlet UITextField *monthTextField;
@property (weak, nonatomic) IBOutlet UITextField *yearTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@property AppDelegate* creditCardDelegate;

@end

@implementation CreditCardInfo

- (IBAction)creditCardNextButton:(id)sender {
    
    // Create the User account
    user* userToCreate = _creditCardDelegate.loggedInUser;
    vehicle* vehicleToCreate = _creditCardDelegate.selectedVehicle;
    
    [UserHandler createAccount:userToCreate withCompletionHandler:^(BOOL success, user* returnedUser) {
        
        if(success == YES) {
            // Add the vehicle to the user
            [VehicleHandler createVehicle:vehicleToCreate withUserId:returnedUser.dbId withCompletionHandler:^(BOOL success, vehicle* returnedVehicle) {
                
                if(success == YES) {
                    // Set global user and vehicle to nil
                    _creditCardDelegate.loggedInUser = nil;
                    _creditCardDelegate.selectedVehicle = nil;
                    
                    // Return to the main page
                    
                } else {
                    // Make user aware that request failed
                    NSLog(@"Error creating vehicle for user");
                }
            }];
            
        } else {
            // Make user aware that request failed
            NSLog(@"Error creating user");
        }
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _creditCardDelegate = [[UIApplication sharedApplication] delegate];
    
   // [ScanCreditCardButton setImage: [UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
   // [ScanCreditCardButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)]; //top left botttom right
    //[ScanCreditCardButton setTitle:@"Scan Credit Card" forState:UIControlStateNormal];
    
    ScanCreditCardButton.layer.borderWidth = 1.0f;
    ScanCreditCardButton.layer.borderColor = [UIColor grayColor].CGColor;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
