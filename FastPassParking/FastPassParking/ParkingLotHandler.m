//
//  ParkingLotHandler.m
//  FastPassParking
//
//  Created by Kerl on 11/2/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "ParkingLotHandler.h"
#import "parkingLot.h"
#import "httpRequestHandler.h"

@implementation ParkingLotHandler

+(void) getParkingLotsForBoundingBox:(NSNumber*) minLat withMaxLat:(NSNumber*) maxLat
                         withMinLong:(NSNumber*) minLong withMaxLong:(NSNumber*) maxLong
                         withCompletionHandler:(void(^)(BOOL, NSArray*)) handler {
    
    NSString* endUrl = @"parkingLot/byBoundingBox";
    endUrl = [endUrl  stringByAppendingFormat:@"?minLat=%@&maxLat=%@&minLong=%@&maxLong=%@",minLat,maxLat, minLong, maxLong];
    
    [HttpRequestHandler httpGetRequest:endUrl withCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        BOOL wasSuccessful = NO;
        NSArray* returnedObjects = nil;
        if(!error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
            if(httpResponse.statusCode == 200) {
                // Parse the parkingLots from json data
                returnedObjects = [self parseParkingLots :(NSArray*)[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]];
                
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

// Method that parses an array of Vehicles
+(NSArray*) parseParkingLots:(NSArray*) dictionaryArray {
    NSMutableArray* result = [[NSMutableArray alloc] initWithCapacity:[dictionaryArray count]];
    
    for(NSDictionary* parkingLotDic in dictionaryArray) {
        parkingLot* newLot = [[parkingLot alloc] initWithJson:parkingLotDic];
        [result addObject:newLot];
    }
    
    return result;
}

@end
