//
//  UpdateVehicleInfoViewController.m
//  FastPassParking
//
//  Created by Alex Gordon on 11/16/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "UpdateVehicleInfoViewController.h"
#import "SWRevealViewController.h"
#import "VehicleHandler.h"
#import "AppDelegate.h"

@interface UpdateVehicleInfoViewController ()

@end

@implementation UpdateVehicleInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    PlateNumber.layer.borderColor = [UIColor blackColor].CGColor;
    PlateNumber.layer.borderWidth = 1.0;
    State.layer.borderColor = [UIColor blackColor].CGColor;
    State.layer.borderWidth = 1.0;
    Make.layer.borderColor = [UIColor blackColor].CGColor;
    Make.layer.borderWidth = 1.0;
    Model.layer.borderColor = [UIColor blackColor].CGColor;
    Model.layer.borderWidth = 1.0;
    Year.layer.borderColor = [UIColor blackColor].CGColor;
    Year.layer.borderWidth = 1.0;
    
    
    
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"Logo"] forState:UIControlStateNormal];
    [button addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0, 0, 32, 32)];
    //UIBarButtonItem *barButton =
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    PlateNumberTextField.text = appDelegate.selectedVehicle.licenseNumber;
    StateTextField.text = appDelegate.selectedVehicle.licenseState;
    MakeTextField.text = appDelegate.selectedVehicle.make;
    ModelTextField.text = appDelegate.selectedVehicle.model;
    ColorTextField.text = appDelegate.selectedVehicle.color;
    YearTextField.text = appDelegate.selectedVehicle.year;
    
    
}


- (IBAction)dismissKeyboardTap:(id)sender {
    
    [PlateNumberTextField resignFirstResponder];
    [StateTextField resignFirstResponder];
    [MakeTextField resignFirstResponder];
    [ModelTextField resignFirstResponder];
    [ColorTextField resignFirstResponder];
    [YearTextField resignFirstResponder];
    
    
}


- (IBAction)ClickUpdateButton:(id)sender{
    
    appDelegate.selectedVehicle.licenseNumber = [PlateNumberTextField text];
    appDelegate.selectedVehicle.licenseState = [StateTextField text];
    appDelegate.selectedVehicle.make = [MakeTextField text];
    appDelegate.selectedVehicle.model = [ModelTextField text];
    appDelegate.selectedVehicle.color = [ColorTextField text];
    appDelegate.selectedVehicle.year = [YearTextField text];
    
    
    [VehicleHandler updateVehicle:appDelegate.selectedVehicle withUserId:appDelegate.loggedInUser.dbId withCompletionHandler:^(BOOL success) {
        
        if (success == YES) {
            
            UIAlertView *updateComplete = [[UIAlertView alloc] initWithTitle:@"Update Complete" message:@"Click OK to Continue" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil, nil];
            
            [updateComplete show];
            
            
        }
        
        else{
            
            
        }
        
    }];
    
    
    
    
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
