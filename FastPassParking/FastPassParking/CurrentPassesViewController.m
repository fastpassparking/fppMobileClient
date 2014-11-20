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
#import "userHandler.h"
#import "parkingPass.h"
#import "parkingPayment.h"

@interface CurrentPassesViewController () < UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate >
{
    float _dollarFunds;
    float _centsFunds;
}
@property (strong, nonatomic) UIView *updateFundsContainer;
@property (strong, nonatomic) UIView *shadowView;
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
    
    // Set variable to get current passes / get history
    _onlyCurrentPasses = YES;
    
    [ParkingPassHandler getParkingPassesForUserId:appDelegate.loggedInUser.dbId onlyCurrent:_onlyCurrentPasses withCompletionHandler:^(BOOL success, NSArray * returnedParkingPasses) {
        
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
    
    
    UIView *shadow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    shadow.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.0];
    self.shadowView = shadow;
    
    
    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    
    [shadow addGestureRecognizer:singleFingerTap];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBOutlet Actions

- (IBAction)updateFundsButton:(id)sender {
    if ([_updateFundsContainer isDescendantOfView:self.view])
        return;
    
    CGFloat initialY = self.view.bounds.size.height;
    CGFloat initialX = (self.view.bounds.size.width / 2) - 110;
    NSLog(@"Initial X: %f", initialX);
    CGFloat containerHeight = 220.0;
    CGFloat containerWidth = 220.0;
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(initialX, initialY, containerWidth, containerHeight)];
    containerView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
    
    UIPickerView *fundsPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, containerWidth, 170)];
    fundsPicker.delegate = self;
    fundsPicker.dataSource = self;
    fundsPicker.showsSelectionIndicator = YES;
    
    UIButton *doneButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 170, containerWidth, 50)];
    [doneButton setTitle:@"+ Add Funds" forState:UIControlStateNormal];
    doneButton.backgroundColor = [UIColor colorWithRed:0.07 green:0.329 blue:0.329 alpha:1.0];
    [doneButton addTarget:self action:@selector(dismissUpdateView) forControlEvents:UIControlEventTouchUpInside];
    
    [containerView addSubview:fundsPicker];
    [containerView addSubview:doneButton];
    
    _updateFundsContainer = containerView;
    
    __weak CurrentPassesViewController *weakSelf = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            _shadowView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.8];
        }];
        
        [UIView animateWithDuration:0.6
                              delay:0.0
             usingSpringWithDamping:0.5
              initialSpringVelocity:0.5
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^
         {
             _updateFundsContainer.center = [weakSelf.view convertPoint:weakSelf.view.center fromView:weakSelf.view.superview];\
             [weakSelf.view addSubview:_shadowView];
             [weakSelf.view addSubview:containerView];
         }
                         completion:^(BOOL finished){}];
        
    });

}


- (void)dismissUpdateView
{
    // store funds in user model on database
    
    // change funds in super view
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.6 animations:^{
            _shadowView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.0];
        }];
        
        [UIView animateWithDuration:0.6
                              delay:0.0
             usingSpringWithDamping:0.5
              initialSpringVelocity:0.5
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^
         {
             _updateFundsContainer.transform = CGAffineTransformMakeTranslation(0, 400);
         }
                         completion:^(BOOL finished)
         {
             [_updateFundsContainer removeFromSuperview];
             [_shadowView removeFromSuperview];
             
             NSLog(@"Dollar amount is %f", _dollarFunds);
             NSLog(@"Cent amount is %f", _centsFunds);
             
             AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
             parkingPayment *payment = [[parkingPayment alloc]init];
             
             NSNumber *newBalance = [NSNumber numberWithFloat:((_dollarFunds * 60.0) + _centsFunds)];
             payment.paymentAmount = [NSNumber numberWithDouble:3.0];
             payment.amountOfTime = newBalance;
             
           //  NSLog(@"New balance is %f", newBalance);
             
             // Update the user in the database
            // user* userToUpdate = appDelegate.loggedInUser;
             //userToUpdate.availableCredit = [NSNumber numberWithFloat:newBalance];
             
             [ParkingPassHandler updateParkingPass:_pass.dbId withParkingPayment:payment withCompletionHandler:^(BOOL success, parkingPass * returnedParkingPass) {
                 
                 if (success == YES) {
                     
                     dispatch_async(dispatch_get_main_queue(), ^{
                         UIAlertView *updateComplete = [[UIAlertView alloc] initWithTitle:@"Update Complete" message:@"Click OK to Continue" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil, nil];
                         
                         [updateComplete show];
                     });
                     
                 }
                 
                 else{
                     NSLog(@"Failed");
                 }
                 
             }];
             
             // reset fund variables
             _dollarFunds = 1.0;
             _centsFunds = 0.0;
             
         }];
        
    });
}

#pragma mark - UIPicker Delegate

//- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    NSString *title = @"sample title";
//    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
//
//    return attString;
//
//}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
    NSLog(@"Selected row: %ld", row);
    if (component == 0) {
        _dollarFunds = row + 1.0;
    } else
    {
        _centsFunds = row * 0.25;
    }
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger dollarRows = 25;
    NSUInteger centsRow = 4;
    
    if (component == 0)
        return dollarRows;
    
    return centsRow;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
    
    if (component == 0)
    {
        title = [@"" stringByAppendingFormat:@"%ld",row + 1];
    }
    else
    {
        title = [@"" stringByAppendingFormat:@"%02ld",row * 25];
    }
    return title;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 70;
    
    return sectionWidth;
}

#pragma mark - Tap Gesture Recognizer
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    NSLog(@"DID RECEIVE TAP");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.6 animations:^{
            _shadowView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.0];
        }];
        
        [UIView animateWithDuration:0.6
                              delay:0.0
             usingSpringWithDamping:0.5
              initialSpringVelocity:0.5
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^
         {
             _updateFundsContainer.transform = CGAffineTransformMakeTranslation(0, 400);
         }
                         completion:^(BOOL finished)
         {
             [_updateFundsContainer removeFromSuperview];
             [_shadowView removeFromSuperview];
         }];
        
    });
}

#pragma mark - UITableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_data count];
}

-(UITableViewCell *)tableView:(UITableView*) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"carTableCell";
    UITableViewCell *carTableCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    _pass = [_data objectAtIndex:indexPath.row];
    
    if(carTableCell == nil){
        carTableCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [carTableCell.textLabel setText:pass.parkingLotName];

    NSLocale *englishLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en"];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    [dateFormatter setLocale:englishLocale];
    
    NSDate* passDate = pass.startDateTime;
    
    NSString* dateString = [dateFormatter stringFromDate:passDate];
    
    NSLog(@"%@",[dateFormatter stringFromDate:pass.startDateTime]);
    
    [carTableCell.detailTextLabel setText:[dateFormatter stringFromDate:_pass.startDateTime]];
    
    return carTableCell;
    
}


- (void) tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    _pass = [_data objectAtIndex:indexPath.row];
    
    NSDate* date1 = _pass.startDateTime;
    NSDate* date2 = _pass.endDateTime;
    //NSTimeInterval distanceBetweenDates = [date1 timeIntervalSinceDate:date2];
    //double secondsInAnHour = 3600;
    //NSInteger hoursBetweenDates = distanceBetweenDates / secondsInAnHour;
    
    _parkingLotName.text = _pass.parkingLotName;
    _timeLeft.text = [NSString stringWithFormat:@"Time Left: %d",5];
    
    NSLog(@"here");
    
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
