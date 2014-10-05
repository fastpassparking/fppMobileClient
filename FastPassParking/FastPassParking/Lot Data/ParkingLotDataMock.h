//
//  ParkingLotDataMock.h
//  FastPassParking
//
//  Created by Ivan Lugo on 10/5/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface ParkingLotDataMock : MKPolygon

@property (nonatomic, strong) NSString* parkingLotName;
@property (nonatomic, strong) NSString* parkingLotDocumentID;

@property (nonatomic, strong) MKPolygonRenderer* rendererForLot;



+ (ParkingLotDataMock*) createPolygonWithCoordinates:(CLLocationCoordinate2D*)coords andCount:(NSUInteger)count;
- (UITableViewCell*) createTableViewCellForTableView:(UITableView*)tableView;

@end