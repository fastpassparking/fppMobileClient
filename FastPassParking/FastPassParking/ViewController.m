//
//  ViewController.m
//  FastPassParking
//
//  Created by Ivan Lugo on 9/21/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "ViewController.h"
#import "User.h"
#import "UserHandler.h"
#import "AppDelegate.h"
#import "VehicleHandler.h"

@interface ViewController () <UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    SignInScreen_UserName.delegate = self;
    SignInScreen_Password.delegate = self;

    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    SignInScreen_UserName.text = appDelegate.loggedInUser.email;
    appDelegate.loggedInUser = nil;
    appDelegate.selectedVehicle = nil;
    
}

- (IBAction)didTapView:(id)sender {
    [SignInScreen_UserName resignFirstResponder];
    [SignInScreen_Password resignFirstResponder];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)checkSignIn:(id)sender{
    
    NSString* loginText = [SignInScreen_UserName text];
    NSString* passwordText = [SignInScreen_Password text];
    
    [UserHandler authenticateLogin:loginText withLoginPassword:passwordText withCompletionHandler:^(BOOL success, user* returnedUser) {
        
        if(success == YES) {
            // Set the logged in user
            AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
            appDelegate.loggedInUser = returnedUser;
            
            [VehicleHandler getVehiclesForUser:returnedUser.dbId withCompletionHandler:^(BOOL succeed, NSArray *userCars) {
                
                appDelegate.selectedVehicle = userCars[0];
                
            }];

            
            // Perform segue
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [self performSegueWithIdentifier:@"LoginSegue" sender:self];
            });
        } else {
            // Make user aware that login failed
        }
    }];
}

@end
