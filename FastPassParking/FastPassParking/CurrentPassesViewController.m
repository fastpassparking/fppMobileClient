//
//  CurrentPassesViewController.m
//  FastPassParking
//
//  Created by Alex Gordon on 11/18/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "CurrentPassesViewController.h"
#import "SWRevealViewController.h"
#import "ParkingPassHandler.h"
#import "AppDelegate.h"
#import "parkingPass.h"

@interface CurrentPassesViewController ()

@end

@implementation CurrentPassesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.parkingPassTableView.delegate = self;
    
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"Logo"] forState:UIControlStateNormal];
    [button addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0, 0, 32, 32)];
    //UIBarButtonItem *barButton =
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    [ParkingPassHandler getParkingPassesForUserId:appDelegate.loggedInUser.dbId withCompletionHandler:^(BOOL success, NSArray * returnedParkingPasses) {
        
        if (success == YES) {
            
            _data = returnedParkingPasses;
           
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.parkingPassTableView reloadData];
            });
            
            
        }
        
        else{
            NSLog(@"error");
        }
        
        
    }];
    
    
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_data count];
}

-(UITableViewCell *)tableView:(UITableView*) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"carTableCell";
    UITableViewCell *carTableCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    parkingPass *pass = [_data objectAtIndex:indexPath.row];
    
    if(carTableCell == nil){
        carTableCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [carTableCell.textLabel setText:pass.parkingLotName];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"MM/dd/yyyy";
    NSLog(@"%@",[dateFormatter stringFromDate:pass.startDateTime]);
    
    [carTableCell.detailTextLabel setText:[dateFormatter stringFromDate:pass.startDateTime]];
    
    return carTableCell;
    
}


- (void) tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    parkingPass *pass = [_data objectAtIndex:indexPath.row];
    
    NSDate* date1 = pass.startDateTime;
    NSDate* date2 = pass.endDateTime;
    //NSTimeInterval distanceBetweenDates = [date1 timeIntervalSinceDate:date2];
    //double secondsInAnHour = 3600;
    //NSInteger hoursBetweenDates = distanceBetweenDates / secondsInAnHour;
    
    _parkingLotName.text = pass.parkingLotName;
    _timeLeft.text = [NSString stringWithFormat:@"Time Left: %d",5];
    
    NSLog(@"here");
    
}

@end
