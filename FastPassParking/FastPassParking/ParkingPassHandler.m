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

@end
