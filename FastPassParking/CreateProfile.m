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


@end

@implementation CreateProfile

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
}
- (IBAction)nextBtnPressed:(id)sender {
    // Todo: do local validation for each string, use regex???
    
    //do database validation??
    
    				
    
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
