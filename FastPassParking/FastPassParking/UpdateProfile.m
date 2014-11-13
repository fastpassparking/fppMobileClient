//
//  UpdateProfile.m
//  FastPassParking
//
//  Created by Alex Gordon on 11/9/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "UpdateProfile.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "SWRevealViewController.h"

@interface UpdateProfile ()

@end

@implementation UpdateProfile

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"Logo"] forState:UIControlStateNormal];
    [button addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0, 0, 32, 32)];
    //UIBarButtonItem *barButton =
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];

    
    // Do any additional setup after loading the view.
    FirstName.layer.borderColor = [UIColor blackColor].CGColor;
    FirstName.layer.borderWidth = 1.0;
    LastName.layer.borderColor = [UIColor blackColor].CGColor;
    LastName.layer.borderWidth = 1.0;
    Email.layer.borderColor = [UIColor blackColor].CGColor;
    Email.layer.borderWidth = 1.0;
    Password.layer.borderColor = [UIColor blackColor].CGColor;
    Password.layer.borderWidth = 1.0;
    MobileNumber.layer.borderColor = [UIColor blackColor].CGColor;
    MobileNumber.layer.borderWidth = 1.0;
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    FirstNameTextField.text = appDelegate.loggedInUser.firstName;
    LastNameTextField.text = appDelegate.loggedInUser.lastName;
    EmailTextField.text = appDelegate.loggedInUser.email;
    PasswordTextField.text = appDelegate.loggedInUser.password;
    MobileNUmberTextField.text = appDelegate.loggedInUser.phoneNumber;
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)BackButtonAction:(id)sender {
    
    //[self dismissViewControllerAnimated:YES completion:nil];
    
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
