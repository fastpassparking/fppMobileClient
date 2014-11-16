//
//  UpdateVehicleInfoViewController.h
//  FastPassParking
//
//  Created by Alex Gordon on 11/16/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface UpdateVehicleInfoViewController : UIViewController{
    
    
    IBOutlet UILabel *PlateNumber;
    IBOutlet UILabel *State;
    IBOutlet UILabel *Make;
    IBOutlet UILabel *Model;
    IBOutlet UILabel *Color;
    IBOutlet UILabel *Year;
    
    IBOutlet UITextField *PlateNumberTextField;
    IBOutlet UITextField *StateTextField;
    IBOutlet UITextField *MakeTextField;
    IBOutlet UITextField *ModelTextField;
    IBOutlet UITextField *ColorTextField;
    IBOutlet UITextField *YearTextField;
    
    IBOutlet UILabel *UpdateButton;
    
    AppDelegate *appDelegate;
    
}


- (IBAction)ClickUpdateButton:(id)sender;

@end
