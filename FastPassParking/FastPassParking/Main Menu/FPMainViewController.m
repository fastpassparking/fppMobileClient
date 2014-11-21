//
//  FPMainViewController.m
//  FastPassParking
//
//  Created by Ivan Lugo on 10/5/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "FPMainViewController.h"
#import "FPLotTableViewCell.h"
#import "FPLotDetailViewController.h"
#import "FPParkingLotData.h"
#import "ParkingLotHandler.h"
#import "parkingLot.h"
#import "SWRevealViewController.h"
#import "FPFundPickerView.h"
#import "user.h"
#import "userHandler.h"
#import "parkingLot.h"
#import "AppDelegate.h"

#define showLotDetailView @"showLotDetailView"
#define kFPPAnnotationReuseIdentifier @"kFPPAnnotationReuseIdentifier"

@interface FPMainViewController () <UIPickerViewDelegate, UIPickerViewDataSource>
{
    float _dollarFunds;
    float _centsFunds;
}
@property (strong, nonatomic) IBOutlet UINavigationItem *mainNavigationBar;
@property (strong, nonatomic) UIView *addFundsView;
@property (strong, nonatomic) UIView *shadowView;
@end

@implementation FPMainViewController

#pragma mark - ViewController Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

    //Slide out menu
   // _barButton.target = self.revealViewController;
   // _barButton.action = @selector(revealToggle:);
    
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"Logo"] forState:UIControlStateNormal];
    [button addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0, 0, 32, 32)];
    //UIBarButtonItem *barButton =
    self.mainNavigationBar.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    // View initializing properties
    appDelegate = [[UIApplication sharedApplication] delegate];
    CLLocationCoordinate2D ucfCampusCenter = CLLocationCoordinate2DMake(28.602428, -81.20006);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.005, 0.005);
    MKCoordinateRegion region = MKCoordinateRegionMake(ucfCampusCenter, span);
    
    FPMapView* implementation = [[FPMapView alloc] init];
    _implementation = implementation;
    _implementation.delegate = self;
    _implementation.mapDelegate = self;
    _implementation.pitchEnabled = NO;
    _implementation.rotateEnabled = NO;
    
    [implementation setRegion:region];
    [implementation attachPinchGestureRecognizer];
    [implementation attachTapGestureRecognizer];
    
    implementation.lastQueriedCenter = implementation.centerCoordinate;
    
    _parkingLotDataObjectsIDsToPolygons = [NSMutableDictionary dictionary];
    implementation.parkingLotDataObjectsIDsToPolygons = _parkingLotDataObjectsIDsToPolygons;
    
    // ==================
    // testing rendering
    // ==================
    // Scorpius top left -      28.602912, -81.197560
    // Scorpius top right -     28.602919, -81.196587
    // Scorpius bottom right -  28.601758, -81.196624
    // Scorpius bottom left -   28.601734, -81.197566
    
    CLLocationCoordinate2D* polygonVertices = malloc(sizeof(CLLocationCoordinate2D) * 5);
    CLLocationCoordinate2D tl = CLLocationCoordinate2DMake(28.602912, -81.197560);
    CLLocationCoordinate2D tr = CLLocationCoordinate2DMake(28.602919, -81.196587);
    CLLocationCoordinate2D br = CLLocationCoordinate2DMake(28.601758, -81.196624);
    CLLocationCoordinate2D bl = CLLocationCoordinate2DMake(28.601734, -81.197566);
    polygonVertices[0] = tl;
    polygonVertices[1] = tr;
    polygonVertices[2] = br;
    polygonVertices[3] = bl;
    polygonVertices[4] = tl;
    
    FPParkingLotData* newPoly = [FPParkingLotData createPolygonWithCoordinates:polygonVertices andCount:5];
    MKPolygonRenderer* renderer = [[MKPolygonRenderer alloc] initWithPolygon:newPoly];
    renderer.lineWidth = 2.0;
    renderer.strokeColor = [UIColor blackColor];
    renderer.fillColor = [[UIColor yellowColor] colorWithAlphaComponent:0.5];
    newPoly.rendererForLot = renderer;
    newPoly.parkingLotName = @"Lot C";
    
    [implementation addOverlay:newPoly];
    [_parkingLotDataObjectsIDsToPolygons setObject:newPoly forKey:newPoly.parkingLotName];
    free(polygonVertices);
    
    // poly 2
    polygonVertices = malloc(sizeof(CLLocationCoordinate2D) * 8);
    bl = CLLocationCoordinate2DMake(28.603145, -81.197847);
    CLLocationCoordinate2D ml = CLLocationCoordinate2DMake(28.603595, -81.198118);
    tl = CLLocationCoordinate2DMake(28.604065, -81.198570);
    CLLocationCoordinate2D tm = CLLocationCoordinate2DMake(28.604592, -81.198361);
    tr = CLLocationCoordinate2DMake(28.605002, -81.198077);
    CLLocationCoordinate2D mr = CLLocationCoordinate2DMake(28.604168, -81.197079);
    br = CLLocationCoordinate2DMake(28.603156, -81.196591);
    polygonVertices[0] = bl;
    polygonVertices[1] = ml;
    polygonVertices[2] = tl;
    polygonVertices[3] = tm;
    polygonVertices[4] = tr;
    polygonVertices[5] = mr;
    polygonVertices[6] = br;
    polygonVertices[7] = bl;
    
    FPParkingLotData* newPoly2 = [FPParkingLotData createPolygonWithCoordinates:polygonVertices andCount:8];
    MKPolygonRenderer* renderer2 = [[MKPolygonRenderer alloc] initWithPolygon:newPoly2];
    renderer2.lineWidth = 2.0;
    renderer2.strokeColor = [UIColor blackColor];
    renderer2.fillColor = [[UIColor yellowColor] colorWithAlphaComponent:0.5];
    newPoly2.rendererForLot = renderer2;
    newPoly2.parkingLotName = @"Lot D";
    
    [implementation addOverlay:newPoly2];
    [_parkingLotDataObjectsIDsToPolygons setObject:newPoly2 forKey:newPoly2.parkingLotName];
    
    
    newPoly.polygonIsDrawn = YES;
    newPoly.annotationIsDrawn = NO;
    newPoly2.polygonIsDrawn = YES;
    newPoly2.annotationIsDrawn = NO;
    
    [_parkingLotTableView reloadData];
    
    //Move global variable to title
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.minimumFractionDigits = 2;
    formatter.maximumFractionDigits = 2;
    
    NSString *currentBalance = @"Balance: $";
    NSString *accountBalancePlus = [currentBalance stringByAppendingString:[formatter stringFromNumber:appDelegate.loggedInUser.availableCredit]];
    
    dispatch_async(dispatch_get_main_queue(), ^() {
        [_mainNavigationBar setTitle:accountBalancePlus];
        [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObject: [UIColor colorWithRed:3.0/255 green:172.0/255 blue:175.0/255 alpha:1.0] forKey: NSForegroundColorAttributeName] ];
    });
    
    // set default adder balance
    _dollarFunds = 1.0;
    _centsFunds = 0.0;
    
    UIView *shadow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    shadow.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.0];
    
    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    
    [shadow addGestureRecognizer:singleFingerTap];
    self.shadowView = shadow;
}

- (void) viewDidAppear:(BOOL)animated{
    
    //[self viewDidLoad];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.minimumFractionDigits = 2;
    formatter.maximumFractionDigits = 2;
    
    NSString *currentBalance = @"Balance: $";
    NSString *accountBalancePlus = [currentBalance stringByAppendingString:[formatter stringFromNumber:appDelegate.loggedInUser.availableCredit]];
    
    dispatch_async(dispatch_get_main_queue(), ^() {
        [_mainNavigationBar setTitle:accountBalancePlus];
        [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObject: [UIColor colorWithRed:3.0/255 green:172.0/255 blue:175.0/255 alpha:1.0] forKey: NSForegroundColorAttributeName] ];
    });
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_implementation updatePolygonsAndAnnotationsAndForceDraw:YES];
    [_implementation setNeedsDisplay];
}

- (void) viewDidLayoutSubviews
{
    _implementation.frame = _mapView.frame;
    [_mapView addSubview:_implementation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - FPMapView delegate
- (void) respondToTapSelectionOfLotData:(FPParkingLotData *)lot
{
    if(_selectedLot)
    {
        _selectedLot.rendererForLot.fillColor = [[UIColor yellowColor] colorWithAlphaComponent:0.5];
    }
    
    _selectedLot = lot;
    
    lot.rendererForLot.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.7];
    [_mapView setNeedsDisplay];
    
    //global parking lot = _selectedlot
//    AppDelegate* appDelegate = [[UIApplication sharedApplication]delegate];
    appDelegate.selectedParkingLot = _selectedLot.ParkingLot;
    
    [self performSegueWithIdentifier:showLotDetailView sender:lot];
}

#pragma mark - MapView Delegate
- (MKOverlayRenderer*) mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    if([overlay isKindOfClass:[FPParkingLotData class]])
    {
        return ((FPParkingLotData*)overlay).rendererForLot;
    }
    
    return nil;
}


- (void) performNetRequestAndUpdateAllViews
{
    if(!CLLocationCoordinate2DIsValid(_implementation.lastQueriedCenter))
    {
        _implementation.lastQueriedCenter = _implementation.centerCoordinate;
    }

    float delta = .0005;
    float queryDelta = .05;
    
    CLLocationCoordinate2D newCenter = _implementation.centerCoordinate;
    
    float latDelta = fabsf(newCenter.latitude - _implementation.lastQueriedCenter.latitude);
    float longDelta = fabsf(newCenter.longitude - _implementation.lastQueriedCenter.longitude);
    NSLog(@"Lat Delta == %f, Long Delta == %f", latDelta, longDelta);
    
    
    if(!(latDelta > delta) && !(longDelta > delta))
    {
        return;
    }
    
//    _parkingLotDataObjectsIDsToPolygons = [[NSMutableDictionary alloc] init];
    
    NSNumber* MILA = [NSNumber numberWithFloat:newCenter.latitude - queryDelta];
    NSNumber* MALA = [NSNumber numberWithFloat:newCenter.latitude + queryDelta];
    NSNumber* MILO = [NSNumber numberWithFloat:newCenter.longitude - queryDelta];
    NSNumber* MALO = [NSNumber numberWithFloat:newCenter.longitude + queryDelta];
    
    [ParkingLotHandler getParkingLotsForBoundingBox:MILA withMaxLat:MALA withMinLong:MILO withMaxLong:MALO withCompletionHandler:^(BOOL success, NSArray* lotArray){
        if(success)
        {
            NSLog(@"Success - got lots");
            NSLog(@"%@", lotArray);
            for(parkingLot* lot in lotArray)
            {
                if([_parkingLotDataObjectsIDsToPolygons objectForKey:lot.name])
                    continue;
                
                CLLocationCoordinate2D* lotVs = malloc(sizeof(CLLocationCoordinate2D) * [lot.coordinates count] + 1);
                int i = 0;
                
                for(NSDictionary* coord in lot.coordinates)
                {
                    double gLat = [[coord valueForKey:@"latitude"] doubleValue];
                    double gLong = [[coord valueForKey:@"longitude"] doubleValue];
                    CLLocationCoordinate2D c = CLLocationCoordinate2DMake(gLat, gLong);
                    
                    lotVs[i++] = c;
                }
                
                // test data does not have repeated first and last entries; no big deal.
                lotVs[i] = lotVs[0];
                
                FPParkingLotData* newLotFromNet = [FPParkingLotData createPolygonWithCoordinates:lotVs andCount:[lot.coordinates count] + 1];
                
                MKPolygonRenderer* netRender = [[MKPolygonRenderer alloc] initWithPolygon:newLotFromNet];
                netRender.lineWidth = 2.0;
                netRender.strokeColor = [UIColor blackColor];
                netRender.fillColor = [[UIColor yellowColor] colorWithAlphaComponent:0.5];
                newLotFromNet.rendererForLot = netRender;
                newLotFromNet.parkingLotName = lot.name;
                newLotFromNet.ParkingLot = lot;
                
                [_implementation addOverlay:newLotFromNet];
                [_parkingLotDataObjectsIDsToPolygons setObject:newLotFromNet forKey:newLotFromNet.parkingLotName];
                
                newLotFromNet.polygonIsDrawn = YES;
                newLotFromNet.annotationIsDrawn = NO;
                
                free(lotVs);
            }
            
            dispatch_async(dispatch_get_main_queue(), ^(){
                [_parkingLotTableView reloadData];
                [_implementation updatePolygonsAndAnnotationsAndForceDraw:NO];
                _implementation.lastQueriedCenter = newCenter;
            });
        }
        else
        {
            NSLog(@"Parking lot net query unsuccessful; skipping.");
        }
    }];
    
}

- (void) mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    for(UIGestureRecognizer* gr in _implementation.gestureRecognizers)
        if(gr.state != 0)
            _isRecognizer = YES;
    NSArray* grs = [[_implementation.subviews firstObject] gestureRecognizers];
    for(id gr in grs)
        if(((UIGestureRecognizer*)gr).state != 0)
            _isRecognizer = YES;
    
}

- (void) mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^void(){
        [self performNetRequestAndUpdateAllViews];
    });
    
    if(_isRecognizer)
    {
        _isRecognizer = NO;
        return;
    }
    [_implementation updatePolygonsAndAnnotationsAndForceDraw:YES];
    [_implementation setNeedsDisplay];
}

- (void) mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    if(! [view isKindOfClass:[FPParkingLotAnnotation class]])
        return;
    
    FPParkingLotData* lotForCell = ((FPParkingLotAnnotation*)view).lotForView;
    
    if(_selectedLot)
    {
        _selectedLot.rendererForLot.fillColor = [[UIColor yellowColor] colorWithAlphaComponent:0.5];
    }
    
    _selectedLot = lotForCell;
    
    lotForCell.rendererForLot.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.7];
    [_mapView setNeedsDisplay];
    
    //global parking lot = _selectedlot
    //AppDelegate* appDelegate = [[UIApplication sharedApplication]delegate];
    //appDelegate.selectedParkingLot = _selectedLot.ParkingLot;
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self performSegueWithIdentifier:showLotDetailView sender:lotForCell];
    });
}

- (UIView*) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if(! [annotation isKindOfClass:[FPParkingLotData class]])
        return nil;
    
    FPParkingLotAnnotation* pinView = [FPParkingLotAnnotation initWithAnnotation:annotation];
    
    UIImage* pin = [UIImage imageNamed:@"pin"];
    pinView.image = pin;
    pinView.centerOffset = CGPointMake(0 , - (pin.size.height / 2));
    
    pinView.draggable = NO;
    pinView.canShowCallout = NO;
    
    pinView.lotForView = (FPParkingLotData*)annotation;
    
    return pinView;
}

#pragma mark - TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView  numberOfRowsInSection:(NSInteger)section
{
    return [[_parkingLotDataObjectsIDsToPolygons allValues] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* allLots = [_parkingLotDataObjectsIDsToPolygons allValues];
    FPParkingLotData* lotForCell = [allLots objectAtIndex:indexPath.row];
    
    FPLotTableViewCell* parkingLotCell = [tableView dequeueReusableCellWithIdentifier:FPLotTableViewCellIdentifier];
    if(parkingLotCell == nil)
    {
        parkingLotCell = [[FPLotTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FPLotTableViewCellIdentifier];
    }
    
    [parkingLotCell.textLabel setText:lotForCell.parkingLotName];
    
    return parkingLotCell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_selectedLot)
    {
        _selectedLot.rendererForLot.fillColor = [[UIColor yellowColor] colorWithAlphaComponent:0.5];
    }
    
    NSArray* allLots = [_parkingLotDataObjectsIDsToPolygons allValues];
    FPParkingLotData* lotForCell = [allLots objectAtIndex:indexPath.row];
    
    lotForCell.rendererForLot.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.7];
    [_mapView setNeedsDisplay];
    
    //global parking lot = _selectedlot
//    AppDelegate* appDelegate = [[UIApplication sharedApplication]delegate];
    appDelegate.selectedParkingLot = lotForCell.ParkingLot;

    
    [self performSegueWithIdentifier:showLotDetailView sender:lotForCell];
}

- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* allLots = [_parkingLotDataObjectsIDsToPolygons allValues];
    FPParkingLotData* lotForCell = [allLots objectAtIndex:indexPath.row];
    
    lotForCell.rendererForLot.fillColor = [[UIColor yellowColor] colorWithAlphaComponent:0.5];
    if(_selectedLot)
    {
        _selectedLot.rendererForLot.fillColor = [[UIColor yellowColor] colorWithAlphaComponent:0.5];
        _selectedLot = nil;
    }
}

#pragma mark - IBOutlet Actions

- (IBAction)didPressAddFundsButton:(id)sender
{
    if ([_addFundsView isDescendantOfView:self.view])
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
    [doneButton addTarget:self action:@selector(dismissAddFundsView) forControlEvents:UIControlEventTouchUpInside];
    
    [containerView addSubview:fundsPicker];
    [containerView addSubview:doneButton];
    
    _addFundsView = containerView;

    __weak FPMainViewController *weakSelf = self;
    
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
            _addFundsView.center = [weakSelf.view convertPoint:weakSelf.view.center fromView:weakSelf.view.superview];\
            [weakSelf.view addSubview:_shadowView];
            [weakSelf.view addSubview:containerView];
        }
                         completion:^(BOOL finished){}];
        
    });
}

- (void)dismissAddFundsView
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
            _addFundsView.transform = CGAffineTransformMakeTranslation(0, 400);
        }
                         completion:^(BOOL finished)
        {
            [_addFundsView removeFromSuperview];
            [_shadowView removeFromSuperview];
            
            NSLog(@"Dollar amount is %f", _dollarFunds);
            NSLog(@"Cent amount is %f", _centsFunds);
            
            float newBalance = [appDelegate.loggedInUser.availableCredit floatValue] + _dollarFunds + _centsFunds;
            
            NSLog(@"New balance is %f", newBalance);
            
            // Update the user in the database
            user* userToUpdate = appDelegate.loggedInUser;
            userToUpdate.availableCredit = [NSNumber numberWithFloat:newBalance];
            
            [UserHandler updateAccount:userToUpdate withCompletionHandler:^(BOOL success, user* returnedUser) {
                
                if (success == YES) {
                    
                    if(returnedUser != nil) {
                        appDelegate.loggedInUser.availableCredit = returnedUser.availableCredit;
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [_mainNavigationBar setTitle:[NSString stringWithFormat:@"Balance: $%.2f", newBalance]];
                        });
                        
                    }

                }
                else {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIAlertView *updateIncomplete = [[UIAlertView alloc] initWithTitle:@"Add funds Failed" message:@"Click OK to Continue" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil, nil];
                        
                        [updateIncomplete show];
                    });
                }
            }];
            
            // reset fund variables
            _dollarFunds = 1.0;
            _centsFunds = 0.0;
            
        }];
        
    });
    
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
             _addFundsView.transform = CGAffineTransformMakeTranslation(0, 400);
         }
                         completion:^(BOOL finished)
         {
             [_addFundsView removeFromSuperview];
             [_shadowView removeFromSuperview];
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"showLotDetailView"])
    {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            
            FPLotDetailViewController* dest = [segue destinationViewController];
            
            dest.main = self;
            dest.lot = (FPParkingLotData*)sender;
            
            _selectedLot = (FPParkingLotData*)sender;
            
//            [_implementation setCenterCoordinate:((FPParkingLotData*)sender).coordinate];
//            [_implementation setVisibleMapRect:_selectedLot.boundingMapRect];
            
//            CLLocationCoordinate2D regionCenter = CLLocationCoordinate2DMake(28.602428, -81.20006);
//            MKCoordinateSpan span = MKCoordinateRegionForMapRect(_selectedLot.boundingMapRect);
            MKCoordinateRegion region = MKCoordinateRegionForMapRect(_selectedLot.boundingMapRect);
            region.span = MKCoordinateSpanMake(region.span.latitudeDelta + 0.005, region.span.longitudeDelta + 0.005);
            
            [_implementation setRegion:region];
            
            dispatch_async(dispatch_get_main_queue(), ^(){
                [_implementation updatePolygonsAndAnnotationsAndForceDraw:YES];
                [_implementation setNeedsDisplay];
            });
        });
    }
}


@end