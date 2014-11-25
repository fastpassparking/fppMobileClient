//
//  parkingPayment.m
//  FastPassParking
//
//  Created by Kyle Mera on 10/29/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "parkingPayment.h"
#import "JsonSerializerUtils.h"

@implementation parkingPayment

- (id) initWithJson:(NSObject*)jsonObject{
    self = [super init];
    if (self && jsonObject) {
        self.timeInitiated = [jsonObject valueForKey:@"timeInitiated"];
        self.amountOfTime = [jsonObject valueForKey:@"amountOfTime"];
        self.paymentAmount = [jsonObject valueForKey:@"paymentAmount"];
        self.lastFourOfCreditCard = [jsonObject valueForKey:@"lastFourOfCreditCard"];
        self.fromAccountCredit = [[jsonObject valueForKey:@"fromAccountCredit"] boolValue];
    }
    return self;
}

+ (NSMutableDictionary*) serializeToJson:(parkingPayment*)parkingPaymentObject {
    
    NSMutableDictionary* parkingPaymentWrapper;
    if(parkingPaymentObject) {
        parkingPaymentWrapper = [[NSMutableDictionary alloc] init];
        NSMutableDictionary* newParkingPayment = [[NSMutableDictionary alloc] init];
        
        // Required properties
        [newParkingPayment setObject:parkingPaymentObject.amountOfTime forKey:@"amountOfTime"];
        [newParkingPayment setObject:parkingPaymentObject.paymentAmount forKey:@"paymentAmount"];
        
        // Optional properties
        [JsonSerializerUtils setObject:parkingPaymentObject.timeInitiated forKey:@"timeInitiated" forDictionary:newParkingPayment];
        [JsonSerializerUtils setObject:parkingPaymentObject.lastFourOfCreditCard forKey:@"lastFourOfCreditCard" forDictionary:newParkingPayment];
        [JsonSerializerUtils setObject:[NSNumber numberWithBool:parkingPaymentObject.fromAccountCredit] forKey:@"fromAccountCredit" forDictionary:newParkingPayment];

        [parkingPaymentWrapper setObject:newParkingPayment forKey:@"parkingPayment"];
    }
    
    return parkingPaymentWrapper;
}

@end
