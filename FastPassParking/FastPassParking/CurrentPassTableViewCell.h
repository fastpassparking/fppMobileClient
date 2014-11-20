//
//  CurrentPassTableViewCell.h
//  FastPassParking
//
//  Created by Alex Gordon on 11/19/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrentPassTableViewCell : UITableViewCell

@property (weak,nonatomic) IBOutlet UILabel *parkingLotName;
@property (weak,nonatomic) IBOutlet UILabel *parkingDate;

@end
