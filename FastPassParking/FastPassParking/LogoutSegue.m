//
//  LogoutSegue.m
//  FastPassParking
//
//  Created by Alex Gordon on 11/16/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "LogoutSegue.h"

@implementation LogoutSegue

- (void)perform{
    
    UIViewController *sourceViewController = (UIViewController*) [self sourceViewController];
    UIViewController *destinationController = (UIViewController*)[self destinationViewController];
    //UINavigationController *navigationController = sourceViewController.navigationController;

    // Pop to root view controller (not animated) before pushing
    //[navigationController popToRootViewControllerAnimated:NO];
   // [navigationController pushViewController:destinationController animated:YES];
   
    
    
    
}

@end
