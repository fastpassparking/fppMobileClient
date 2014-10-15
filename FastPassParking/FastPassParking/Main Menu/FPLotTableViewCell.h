//
//  FPLotTableViewCell.h
//  FastPassParking
//
//  Created by Ivan Lugo on 10/5/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPParkingLotData.h"
static NSString* const FPLotTableViewCellIdentifier = @"FPLotDataCell";

@interface FPLotTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel* parkingLotName;
@property (nonatomic, weak) IBOutlet UILabel* parkingLotDetails;


@end
