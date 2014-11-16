//
//  errorObject.h
//  FastPassParking
//
//  Created by Kerl on 11/13/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface errorObject : NSObject

@property(nonatomic,copy) NSString* errorMessage;

// Constructor
- (id) initWithJson:(NSObject*) jsonObject;

@end
