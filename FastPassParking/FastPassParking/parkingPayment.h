//
//  parkingPayment.h
//  FastPassParking
//
//  Created by Kerl on 10/29/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface parkingPayment : NSObject

@property(nonatomic,copy) NSDate* timeInitiated;
@property(nonatomic,copy) NSNumber* amountOfTime;
@property(nonatomic,copy) NSNumber* paymentAmount;
@property(nonatomic,copy) NSString* lastFourOfCreditCard;
@property (assign) BOOL fromAccountCredit;

// Constructor
- (id) initWithJson:(NSObject*) jsonObject;
// Object to Json
+ (NSMutableDictionary*) serializeToJson:(parkingPayment*) parkingPaymentObject;

@end
