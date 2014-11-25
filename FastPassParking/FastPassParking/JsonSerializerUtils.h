//
//  JsonSerializerUtils.h
//  FastPassParking
//
//  Created by Kyle Mera on 11/13/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonSerializerUtils : NSObject

+ (NSDictionary*) setObject:(NSObject*) object forKey:(NSString*) string forDictionary:(NSMutableDictionary*) dictionary;
+ (NSDate*) getDateFromString:(NSString*) string;

@end
