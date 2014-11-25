//
//  accountCredit.m
//  FastPassParking
//
//  Created by Kyle Mera on 10/29/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "accountCredit.h"

@implementation accountCredit

- (id) initWithJson:(NSObject*)jsonObject{
    self = [super init];
    if (self && jsonObject) {
        self.dbId = [jsonObject valueForKey:@"id"];
        self.userId = [jsonObject valueForKey:@"userId"];
        self.amount = [jsonObject valueForKey:@"amount"];
        self.dateTimeAdded = [jsonObject valueForKey:@"dateTimeAdded"];
        self.lastFourOfCreditCard = [jsonObject valueForKey:@"lastFourOfCreditCard"];
    }
    return self;
}

+ (NSMutableDictionary*) serializeToJson:(accountCredit*)object {
    
    NSMutableDictionary* wrapper;
    if(object) {
        wrapper = [[NSMutableDictionary alloc] init];
        NSMutableDictionary* newObject = [[NSMutableDictionary alloc] init];
        [newObject setObject:object.dbId forKey:@"id"];
        [newObject setObject:object.userId forKey:@"userId"];
        [newObject setObject:object.amount forKey:@"amount"];
        [newObject setObject:object.dateTimeAdded forKey:@"dateTimeAdded"];
        [newObject setObject:object.lastFourOfCreditCard forKey:@"lastFourOfCreditCard"];
        
        [wrapper setObject:newObject forKey:@"accountCredit"];
    }
    
    return wrapper;
}

@end
