//
//  FPMainViewController.m
//  FastPassParking
//
//  Created by Ivan Lugo on 10/5/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "FPMainViewController.h"

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

    
    
    // View initializing properties
    CLLocationCoordinate2D ucfCampusCenter = CLLocationCoordinate2DMake(28.602428, -81.20006);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.005, 0.005);
    MKCoordinateRegion region = MKCoordinateRegionMake(ucfCampusCenter, span);
    
    [_mapView setRegion:region];
    _parkingLotDataObjectsIDsToPolygons = [NSMutableDictionary dictionary];
    
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
    
    ParkingLotDataMock* newPoly = [ParkingLotDataMock createPolygonWithCoordinates:polygonVertices andCount:5];
    MKPolygonRenderer* renderer = [[MKPolygonRenderer alloc] initWithPolygon:newPoly];
    renderer.lineWidth = 2.0;
    renderer.strokeColor = [UIColor blackColor];
    renderer.fillColor = [[UIColor yellowColor] colorWithAlphaComponent:0.5];
    newPoly.rendererForLot = renderer;
    newPoly.parkingLotName = @"Lot C";
    
    [_mapView addOverlay:newPoly];
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
    
    ParkingLotDataMock* newPoly2 = [ParkingLotDataMock createPolygonWithCoordinates:polygonVertices andCount:8];
    MKPolygonRenderer* renderer2 = [[MKPolygonRenderer alloc] initWithPolygon:newPoly2];
    renderer2.lineWidth = 2.0;
    renderer2.strokeColor = [UIColor blackColor];
    renderer2.fillColor = [[UIColor yellowColor] colorWithAlphaComponent:0.5];
    newPoly2.rendererForLot = renderer2;
    newPoly2.parkingLotName = @"Lot D";
    
    [_mapView addOverlay:newPoly2];
    [_parkingLotDataObjectsIDsToPolygons setObject:newPoly2 forKey:newPoly2.parkingLotName];
    
    
    [_parkingLotTableView reloadData];
    
    [_mainNavigationBar setTitle:@"Funds go here"];
    
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
    if([overlay isKindOfClass:[ParkingLotDataMock class]])
    {
        return ((ParkingLotDataMock*)overlay).rendererForLot;
    }
    
    return nil;
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
    ParkingLotDataMock* lotForCell = [allLots objectAtIndex:indexPath.row];
    
    return [lotForCell createTableViewCellForTableView:tableView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* allLots = [_parkingLotDataObjectsIDsToPolygons allValues];
    ParkingLotDataMock* lotForCell = [allLots objectAtIndex:indexPath.row];
    
    lotForCell.rendererForLot.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.7];
    [_mapView setNeedsDisplay];
    
    [self performSegueWithIdentifier:showLotDetailView sender:lotForCell];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* allLots = [_parkingLotDataObjectsIDsToPolygons allValues];
    ParkingLotDataMock* lotForCell = [allLots objectAtIndex:indexPath.row];
    
    lotForCell.rendererForLot.fillColor = [[UIColor yellowColor] colorWithAlphaComponent:0.5];
    [_mapView setNeedsDisplay];
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
