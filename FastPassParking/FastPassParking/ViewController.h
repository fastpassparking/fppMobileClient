//
//  ViewController.h
//  FastPassParking
//
//  Created by Ivan Lugo on 9/21/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

{
    IBOutlet UILabel *test_height;  //Used to test pixl height for storyboards ** Is not needed any longer.
    
    IBOutlet UIButton *SignInButton;
    IBOutlet UIButton *CreateAccountButton;

    IBOutlet UITextField *SignInScreen_UserName;
    IBOutlet UITextField *SignInScreen_Password;



}

- (IBAction)checkSignIn:(id)sender;


@end

