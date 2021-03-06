//
//  UpdateProfile.h
//  FastPassParking
//
//  Created by Alex Gordon on 11/9/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface UpdateProfile : UIViewController{
    
    IBOutlet UILabel *FirstName;
    IBOutlet UILabel *LastName;
    IBOutlet UILabel *Email;
    IBOutlet UILabel *Password;
    IBOutlet UILabel *MobileNumber;
    
    IBOutlet UITextField *FirstNameTextField;
    IBOutlet UITextField *LastNameTextField;
    IBOutlet UITextField *EmailTextField;
    IBOutlet UITextField *PasswordTextField;
    IBOutlet UITextField *MobileNUmberTextField;
    
    IBOutlet UILabel *UpdateButton;
    
    AppDelegate *appDelegate;
    
    
}
- (IBAction)ClickUpdateButton:(id)sender;

@end
