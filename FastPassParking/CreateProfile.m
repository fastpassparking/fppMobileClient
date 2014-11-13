//
//  CreateProfile.m
//  FastPassParking
//
//  Created by Alex Gordon on 10/1/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "CreateProfile.h"
#import "ViewController.h"
#import "User.h"
#import "UserHandler.h"
#import "AppDelegate.h"

@interface CreateProfile ()
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;

@property (weak, nonatomic) IBOutlet UITextField *licensePlateNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *licensePlateStateTextField;
@property (weak, nonatomic) IBOutlet UITextField *vehicleMakeTextField;
@property (weak, nonatomic) IBOutlet UITextField *vehicleModelTextField;
@property (weak, nonatomic) IBOutlet UITextField *vehicleColorTextField;
@property (weak, nonatomic) IBOutlet UITextField *vehicleYearTextField;

@property AppDelegate* globalDelegate;

@end

@implementation CreateProfile

- (IBAction)createAccountNextButton:(id)sender {
    
    // Validate the account fields
    if([_firstNameTextField.text length] == 0 ||
       [_lastNameTextField.text length] == 0 ||
       [_emailTextField.text length] == 0 ||
       [_passwordTextField.text length] == 0 ||
       [_phoneNumberTextField.text length] == 0) {
        
        // Alert the user that the fields are incorrect
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Missing fields" message:@"Please fill in all fields" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        // Create the current user object
        user* userToCreate = [user alloc];
        userToCreate.firstName = _firstNameTextField.text;
        userToCreate.lastName = _lastNameTextField.text;
        userToCreate.email = _emailTextField.text;
        userToCreate.password = _passwordTextField.text;
        userToCreate.phoneNumber = _phoneNumberTextField.text;
        
        // Set the current user object
        _globalDelegate.loggedInUser = userToCreate;
        
        // Go to the next page
        [self performSegueWithIdentifier:@"showAddVehicle" sender:self];
    }
    
}

- (IBAction)addCarNextButton:(id)sender {
    
    // Validate the account fields
    if([_licensePlateNumberTextField.text length] == 0 ||
       [_licensePlateStateTextField.text length] == 0 ||
       [_vehicleMakeTextField.text length] == 0 ||
       [_vehicleModelTextField.text length] == 0 ||
       [_vehicleColorTextField.text length] == 0 ||
       [_vehicleYearTextField.text length] == 0) {
        
        // Alert the user that the fields are incorrect
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Missing fields" message:@"Please fill in all fields" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        // Create the current vehicle object
        vehicle* vehicleToCreate = [vehicle alloc];
        vehicleToCreate.licenseNumber = _licensePlateNumberTextField.text;
        vehicleToCreate.licenseState = _licensePlateStateTextField.text;
        vehicleToCreate.make = _vehicleMakeTextField.text;
        vehicleToCreate.model = _vehicleModelTextField.text;
        vehicleToCreate.color = _vehicleColorTextField.text;
        vehicleToCreate.year = _vehicleYearTextField.text;
        
        // Set the current vehicle object
        _globalDelegate.selectedVehicle = vehicleToCreate;
        
        // Go to the next page
        [self performSegueWithIdentifier:@"showAddCreditCard" sender:self];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _globalDelegate = [[UIApplication sharedApplication] delegate];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)CancelButtonAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
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
