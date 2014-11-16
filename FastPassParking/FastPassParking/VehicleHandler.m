//
//  VehicleHandler.m
//  FastPassParking
//
//  Created by Kerl on 11/2/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "VehicleHandler.h"

@implementation VehicleHandler

+(void) getVehiclesForUser:(NSString*) userId withCompletionHandler:(void(^)(BOOL, NSArray*)) handler {
    
    NSString* endUrl = @"vehicle?user_id=";
    endUrl = [endUrl  stringByAppendingFormat:@"%@", userId];
    
    [HttpRequestHandler httpGetRequest:endUrl withCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        BOOL wasSuccessful = NO;
        NSArray* returnedObjects = nil;
        if(!error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
            if(httpResponse.statusCode == 200) {
                // Parse the vehicles from json data
                returnedObjects = [self parseVehicles :(NSArray*)[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]];
                
                // Set the completionHandler response
                wasSuccessful = YES;
            } else {
                // Make user aware that
                NSLog(@"Error code: %ld", (long)httpResponse.statusCode);
            }
        } else {
            NSLog(@"Error");
        }
        
        // Return the completion handler to the caller
        handler(wasSuccessful, returnedObjects);
    }];
    
}

+(void) createVehicle:(vehicle*) vehicleObject withUserId:(NSString*) userId withCompletionHandler:(void(^)(BOOL, vehicle*)) handler {
    
    NSString* endUrl = @"vehicle?user_id=";
    endUrl = [endUrl  stringByAppendingFormat:@"%@", userId];
    
    NSMutableDictionary* jsonObject = [vehicle serializeToJson:vehicleObject];
    
    [HttpRequestHandler httpPostRequest:endUrl withObjectBody:jsonObject withCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        BOOL wasSuccessful = NO;
        vehicle* returnedObject = nil;
        if(!error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
            if(httpResponse.statusCode == 200) {
                // Parse the user from json data
                returnedObject = [[vehicle alloc] initWithJson:[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]];
                
                // Set the completionHandler response
                wasSuccessful = YES;
            } else {
                NSLog(@"Error code: %ld", (long)httpResponse.statusCode);
            }
        } else {
            NSLog(@"Error");
        }
        
        // Return the completion handler to the caller
        handler(wasSuccessful, returnedObject);
    }];
    
}

// Method that parses an array of Vehicles
+(NSArray*) parseVehicles:(NSArray*) dictionaryArray {
    NSMutableArray* result = [[NSMutableArray alloc] initWithCapacity:[dictionaryArray count]];
    
    for(NSDictionary* vehicleDic in dictionaryArray) {
        vehicle* newVehicle = [[vehicle alloc] initWithJson:vehicleDic];
        [result addObject:newVehicle];
    }
    
    return result;
}

@end
