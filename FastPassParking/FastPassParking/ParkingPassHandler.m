//
//  ParkingPassHandler.m
//  FastPassParking
//
//  Created by Kerl on 11/2/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "ParkingPassHandler.h"
#import "httpRequestHandler.h"

@implementation ParkingPassHandler

+(void) createParkingPass:(parkingPayment*) parkingPaymentObject withLotId:(NSString*) lotId
            withVehicleId:(NSString*) vehicleId
    withCompletionHandler:(void(^)(BOOL, parkingPass*)) handler {
    
    NSString* endUrl = @"parkingPass";
    endUrl = [endUrl  stringByAppendingFormat:@"?lot_id=%@&vehicle_id=%@",lotId,vehicleId];
    
    NSMutableDictionary* paymentJsonObject = [parkingPayment serializeToJson:parkingPaymentObject];
    
    [HttpRequestHandler httpPostRequest:endUrl withObjectBody:paymentJsonObject withCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        BOOL wasSuccessful = NO;
        parkingPass* returnedObject = nil;
        if(!error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
            if(httpResponse.statusCode == 200) {
                // Parse the user from json data
                returnedObject = [[parkingPass alloc] initWithJson:[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]];
                
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

+(void) getParkingPassesForUserId:(NSString*) userId
            withCompletionHandler:(void(^)(BOOL, NSArray*)) handler {
    
    NSString* endUrl = @"parkingPass/byUser?user_id=";
    endUrl = [endUrl  stringByAppendingFormat:@"%@", userId];
    
    [HttpRequestHandler httpGetRequest:endUrl withCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        BOOL wasSuccessful = NO;
        NSArray* returnedObjects = nil;
        if(!error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
            if(httpResponse.statusCode == 200) {
                // Parse the vehicles from json data
                returnedObjects = [self parseParkingPasses:(NSArray*)[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]];
                
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

// Method that parses an array of ParkingPasses
+(NSArray*) parseParkingPasses:(NSArray*) dictionaryArray {
    NSMutableArray* result = [[NSMutableArray alloc] initWithCapacity:[dictionaryArray count]];
    
    for(NSDictionary* passDic in dictionaryArray) {
        parkingPass* newPass = [[parkingPass alloc] initWithJson:passDic];
        [result addObject:newPass];
    }
    
    return result;
}

@end
