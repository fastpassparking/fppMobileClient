//
//  CurrentPassesViewController.h
//  FastPassParking
//
//  Created by Alex Gordon on 11/18/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "parkingPass.h"
#import "parkingPayment.h"

@interface CurrentPassesViewController : UIViewController

@property (strong,nonatomic) IBOutlet UITableView *parkingPassTableView;

@property (strong,nonatomic) NSArray *data;
@property BOOL onlyCurrentPasses;

@property (strong,nonatomic) parkingPass *pass;
//@property (strong,nonatomic) parkingPayment *payment;

@property (weak,nonatomic) IBOutlet UILabel *parkingLotName;
@property (weak,nonatomic) IBOutlet UILabel *timeLeft;

@end
