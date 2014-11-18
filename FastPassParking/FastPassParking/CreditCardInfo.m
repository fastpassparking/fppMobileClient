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

@interface CreditCardInfo () < UIAlertViewDelegate >
@property (weak, nonatomic) IBOutlet UITextField *typeTextField;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;
@property (weak, nonatomic) IBOutlet UITextField *monthTextField;
@property (weak, nonatomic) IBOutlet UITextField *yearTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@property AppDelegate* appDelegate;

@end

@implementation CreditCardInfo

- (IBAction)creditCardNextButton:(id)sender {
    
    // Create the User account
    user* userToCreate = _appDelegate.loggedInUser;
    vehicle* vehicleToCreate = _appDelegate.selectedVehicle;
    
    [UserHandler createAccount:userToCreate withCompletionHandler:^(BOOL firstSuccess, user* returnedUser) {
        
        if(firstSuccess == YES) {
            
            // Add the vehicle to the user
            vehicleToCreate.userId = returnedUser.dbId;
            [VehicleHandler createVehicle:vehicleToCreate withUserId:returnedUser.dbId withCompletionHandler:^(BOOL secondSuccess, vehicle* returnedVehicle) {
                
                if(secondSuccess == YES) {
                    // Set global user and vehicle to nil
                    _appDelegate.loggedInUser = nil;
                    _appDelegate.selectedVehicle = nil;
                    
                    // Alert the user that account has been created
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Account Created!" message:@"Your account has been created, please log in" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                        [alert show];
                    });
                    
                } else {
                    // Make user aware that request failed
                    NSLog(@"Error creating vehicle for user");
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIAlertView *alertFailed = [[UIAlertView alloc] initWithTitle:@"Creation Error!" message:@"Error creating vehicle for user" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                        [alertFailed show];
                    });
                }
            }];
            
        } else {
            // Make user aware that request failed
            NSLog(@"Error creating user");
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alertFail = [[UIAlertView alloc] initWithTitle:@"Creation Error!" message:@"Error creating user" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alertFail show];
            });
        }
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _appDelegate = [[UIApplication sharedApplication] delegate];
    
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == 0){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
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
