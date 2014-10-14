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

#define showLotDetailView @"showLotDetailView"

@interface FPMainViewController ()
{
    int _lotCount;
}
@property (strong, nonatomic) IBOutlet UINavigationItem *mainNavigationBar;

@end

@implementation FPMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
<<<<<<< HEAD
    NSLog(@"STARTING MAIN VIEW");
    
    NSString *url = @"http://107.203.220.120/parkinglots";
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:url]
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
      {
          NSLog(@"Response from URL: %@", response);
          NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
          
          [self parseArrayOfLots:jsonArray];
      }] resume];

    
    
=======
>>>>>>> ivan-mapview-changes
    // View initializing properties
    CLLocationCoordinate2D ucfCampusCenter = CLLocationCoordinate2DMake(28.602428, -81.20006);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.005, 0.005);
    MKCoordinateRegion region = MKCoordinateRegionMake(ucfCampusCenter, span);
    
    FPMapView* implementation = [[FPMapView alloc] initWithFrame:CGRectMake(0, 0, _mapView.frame.size.width, _mapView.frame.size.height)];
    _implementation = implementation;
    
    [_mapView addSubview:implementation];
    
    [implementation setRegion:region];
    [implementation attachPinchGestureRecognizer];
    
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
    
    [_mainNavigationBar setTitle:@"$Arbitrary.Dollars"];
//    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObject: [UIColor colorWithRed:3.0/255 green:172.0/255 blue:175.0/255 alpha:1.0] forKey: NSForegroundColorAttributeName] ];
    
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"Logo"] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(blah) forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0, 0, 32, 32)];
    self.mainNavigationBar.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)parseArrayOfLots:(NSArray *)arrayOfLots
{
    _lotCount = [arrayOfLots count];
//    
//    NSArray *indexPaths = [NSArray arrayWithObject:[NSIndexPath indexPathWithIndex:0]];
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.parkingLotTableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
//    });
}


#pragma MapView Delegate
- (MKOverlayRenderer*) mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    if([overlay isKindOfClass:[FPParkingLotData class]])
    {
        return ((FPParkingLotData*)overlay).rendererForLot;
    }
    
    return nil;
}

- (void) mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
//    _mapView.lastZoomLevel = [_mapView getZoomLevel];
}

- (void) mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
//    NSArray* views = [_parkingLotDataObjectsIDsToPolygons allValues];
//    
//    if([_mapView getZoomLevel] <= 16.0)
//    {
//        for(FPParkingLotData* lot in views)
//        {
//            if(lot.polygonIsDrawn)
//            {
//                [_mapView removeOverlay:lot];
//                [_mapView addAnnotation:lot];
//                lot.polygonIsDrawn = NO;
//                lot.annotationIsDrawn = YES;
//            }
//        }
//    }
//    else
//    {
//        for(FPParkingLotData* lot in views)
//        {
//            if(lot.annotationIsDrawn)
//            {
//                [_mapView removeAnnotation:lot];
//                [_mapView addOverlay:lot];
//                lot.polygonIsDrawn = YES;
//                lot.annotationIsDrawn = NO;
//            }
//        }
//    }
}

#pragma TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView  numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"Returning count of %d", _lotCount);
    return 2;
//    return [[_parkingLotDataObjectsIDsToPolygons allValues] count];
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
    
//    [parkingLotCell.parkingLotName setText: lotForCell.parkingLotName];
//    [parkingLotCell.parkingLotDetails setText: lotForCell.parkingLotDocumentID];
    [parkingLotCell.textLabel setText:lotForCell.parkingLotName];
    
    return parkingLotCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* allLots = [_parkingLotDataObjectsIDsToPolygons allValues];
    FPParkingLotData* lotForCell = [allLots objectAtIndex:indexPath.row];
    
    lotForCell.rendererForLot.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.7];
    [_mapView setNeedsDisplay];
    
    [self performSegueWithIdentifier:showLotDetailView sender:lotForCell];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* allLots = [_parkingLotDataObjectsIDsToPolygons allValues];
    FPParkingLotData* lotForCell = [allLots objectAtIndex:indexPath.row];
    
    lotForCell.rendererForLot.fillColor = [[UIColor yellowColor] colorWithAlphaComponent:0.5];
    [_mapView setNeedsDisplay];
    
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if([segue.identifier isEqualToString:@"showLotDetailView"])
    {
        FPLotDetailViewController* dest = [segue destinationViewController];
        dest.main = self;
    }
}


@end
