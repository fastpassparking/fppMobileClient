//
//  parkingPayment.m
//  FastPassParking
//
//  Created by Kerl on 10/29/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "parkingPayment.h"

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
        [newParkingPayment setObject:parkingPaymentObject.timeInitiated forKey:@"timeInitiated"];
        [newParkingPayment setObject:parkingPaymentObject.amountOfTime forKey:@"amountOfTime"];
        [newParkingPayment setObject:parkingPaymentObject.paymentAmount forKey:@"paymentAmount"];
        [newParkingPayment setObject:parkingPaymentObject.lastFourOfCreditCard forKey:@"lastFourOfCreditCard"];
        [newParkingPayment setObject:[NSNumber numberWithBool:parkingPaymentObject.fromAccountCredit] forKey:@"fromAccountCredit"];

        [parkingPaymentWrapper setObject:newParkingPayment forKey:@"parkingPayment"];
    }
    
    return parkingPaymentWrapper;
}

@end
