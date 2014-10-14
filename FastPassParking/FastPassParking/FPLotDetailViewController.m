//
//  FPLotDetailViewController.m
//  FastPassParking
//
//  Created by Darin Doria on 10/5/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "FPLotDetailViewController.h"

@interface FPLotDetailViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *detailImageView;
@property (strong, nonatomic) IBOutlet UILabel *lotTitleLabel;

@end

@implementation FPLotDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *url = @"http://107.203.220.120/parkinglots";
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:url]
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
            {
                NSLog(@"Response from URL: %@", response);
                NSError *err;
                NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];

                if (err)
                {
                    NSLog(@"Error parsing json");
                }
                
                for (NSDictionary *user in jsonArray)
                {
                    NSLog(@"User: %@", user);
                    NSLog(@"Lot name: %@", [user objectForKey:@"name"]);
                }
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.lotTitleLabel.text = [[jsonArray firstObject] objectForKey:@"name"];
                });
                
                
                
            }] resume];
    
    
    
    NSLog(@"STARTING LOT DETAIL VIEW");
}

@end
