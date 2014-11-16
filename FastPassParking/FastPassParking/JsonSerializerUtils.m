//
//  JsonSerializerUtils.m
//  FastPassParking
//
//  Created by Kerl on 11/13/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "JsonSerializerUtils.h"

@implementation JsonSerializerUtils

+ (NSDictionary*) setObject:(NSObject*) object forKey:(NSString*) string forDictionary:(NSMutableDictionary*) dictionary{
    
    if(object != nil) {
        [dictionary setObject:object forKey:string];
    }
    
    return dictionary;
}

@end
