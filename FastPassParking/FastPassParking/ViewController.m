//
//  ViewController.m
//  FastPassParking
//
//  Created by Ivan Lugo on 9/21/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "ViewController.h"
#import "User.h"
#import "userHandler.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)checkSignIn:(id)sender{
    
    NSString* loginText = [SignInScreen_UserName text];
    NSString* passwordText = [SignInScreen_Password text];
    
    userHandler* checkingUser = [[userHandler alloc] init];
    [checkingUser initWithAppDelegate];
    
    [checkingUser authenticateLogin:loginText withLoginPassword:passwordText withCompletionHandler:^(BOOL isFinished) {
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [self performSegueWithIdentifier:@"LoginSegue" sender:self];
        });
    }];
    
    
    
}

@end
