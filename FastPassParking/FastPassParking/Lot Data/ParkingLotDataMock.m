//
//  ParkingLotDataMock.m
//  FastPassParking
//
//  Created by Ivan Lugo on 10/5/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "ParkingLotDataMock.h"

@implementation ParkingLotDataMock

+ (ParkingLotDataMock*) createPolygonWithCoordinates:(CLLocationCoordinate2D *)coords andCount:(NSUInteger)count
{
    return [ParkingLotDataMock polygonWithCoordinates:coords count:count];
}

- (UITableViewCell*) createTableViewCellForTableView:(UITableView *)tableView
{
    static NSString *cellIdentifier = @"parkingLot";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"parkingLot"];

    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = _parkingLotName;
    
    return cell;
}


@end
