//
//  FPLotDetailViewController.h
//  FastPassParking
//
//  Created by Darin Doria on 10/5/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPMainViewController.h"

@interface FPLotDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *lotDetailMapView;
@property (strong, nonatomic) FPMainViewController* main;

@end
