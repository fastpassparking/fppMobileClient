//
//  CurrentPassesViewController.h
//  FastPassParking
//
//  Created by Alex Gordon on 11/18/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrentPassesViewController : UIViewController

@property (strong,nonatomic) IBOutlet UITableView *parkingPassTableView;

@property (strong,nonatomic) NSArray *data;
@property BOOL onlyCurrentPasses;

@property (weak,nonatomic) IBOutlet UILabel *parkingLotName;
@property (weak,nonatomic) IBOutlet UILabel *timeLeft;

@end
