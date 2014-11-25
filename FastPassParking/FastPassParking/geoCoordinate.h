//
//  geoCoordinate.h
//  FastPassParking
//
//  Created by Kyle Mera on 10/29/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface geoCoordinate : NSObject

@property(nonatomic,copy) NSNumber* longitude;
@property(nonatomic,copy) NSNumber* latitude;

// Constructor
- (id) initWithJson:(NSObject*) jsonObject;
// Object to Json
+ (NSMutableDictionary*) serializeToJson:(geoCoordinate*) object;
+ (NSMutableDictionary*) serializeToJsonWithWrapper:(geoCoordinate*) object;

@end
