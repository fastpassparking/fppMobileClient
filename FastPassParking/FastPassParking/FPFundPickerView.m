//
//  FPFundPickerView.m
//  FastPassParking
//
//  Created by Darin Doria on 11/12/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "FPFundPickerView.h"

@implementation FPFundPickerView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        CGRect rect = CGRectMake(0, 0, frame.size.width, frame.size.height-40);
        UIPickerView *picker = [[UIPickerView alloc] initWithFrame:rect];
        
        self.backgroundColor = [UIColor grayColor];
        self.layer.cornerRadius = 15;
        
        
        [self addSubview:picker];
    }
    
    return self;
}

@end
