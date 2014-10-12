//
//  CreditCardInfo.m
//  FastPassParking
//
//  Created by Alex Gordon on 10/12/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "CreditCardInfo.h"

@interface CreditCardInfo ()

@end

@implementation CreditCardInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   // [ScanCreditCardButton setImage: [UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
   // [ScanCreditCardButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)]; //top left botttom right
    //[ScanCreditCardButton setTitle:@"Scan Credit Card" forState:UIControlStateNormal];
    
    ScanCreditCardButton.layer.borderWidth = 1.0f;
    ScanCreditCardButton.layer.borderColor = [UIColor grayColor].CGColor;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
