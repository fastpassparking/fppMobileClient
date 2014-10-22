//
//  FPParkingLot.h
//  FastPassParking
//
//  Created by Darin Doria on 10/14/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FPParkingLot : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *



// init
- (instancetype) initWithDictionary:(NSDictionary*)dictionary;

@end
