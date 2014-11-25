//
//  httpRequestHandler.h
//  FastPassParking
//
//  Created by Kyle Mera on 10/30/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BASE_URL @"107.203.220.120"
extern NSString *const SERVER_BASE_URL;

@interface HttpRequestHandler : NSObject

@property (nonatomic, strong) void(^completionHandler)(NSData *data, NSURLResponse *response, NSError *error);

+ (void) httpGetRequest:(NSString*) endUrl withCompletionHandler:(void(^)(NSData*, NSURLResponse*, NSError*)) handler;
+ (void) httpPostRequest:(NSString*) endUrl withObjectBody:(NSMutableDictionary*) object withCompletionHandler:(void(^)(NSData*, NSURLResponse*, NSError*)) handler;
+ (void) httpPutRequest:(NSString*) endUrl withObjectBody:(NSMutableDictionary*) object withCompletionHandler:(void(^)(NSData*, NSURLResponse*, NSError*)) handler;
+ (NSString *) createSHA512:(NSString *)source;

@end
