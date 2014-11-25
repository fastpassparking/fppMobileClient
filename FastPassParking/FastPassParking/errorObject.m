//
//  errorObject.m
//  FastPassParking
//
//  Created by Kyle Mera on 11/13/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "errorObject.h"

@implementation errorObject

- (id) initWithJson:(NSObject*)jsonObject{
    self = [super init];
    if (self && jsonObject) {
        self.errorMessage = [jsonObject valueForKey:@"error"];
    }
    return self;
}

@end
