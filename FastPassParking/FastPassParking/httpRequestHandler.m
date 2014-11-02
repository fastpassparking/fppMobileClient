//
//  httpRequestHandler.m
//  FastPassParking
//
//  Created by Kerl on 10/30/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "HttpRequestHandler.h"

// Set the server's base url in a place that the entire app can reach
NSString *const SERVER_BASE_URL = BASE_URL;

@implementation HttpRequestHandler

+ (void) httpGetRequest:(NSString*) endUrl withCompletionHandler:(void(^)(NSData*, NSURLResponse*, NSError*)) handler {
    
    NSURL* url = [NSURL URLWithString:[SERVER_BASE_URL stringByAppendingPathComponent:endUrl]];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        handler(data, response, error);
    }];
    
    [dataTask resume];
    
}
+ (void) httpPostRequest:(NSString*) endUrl withObjectBody:(NSMutableDictionary*) object withCompletionHandler:(void(^)(NSData*, NSURLResponse*, NSError*)) handler {
    
    NSURL* url = [NSURL URLWithString:[SERVER_BASE_URL stringByAppendingPathComponent:endUrl]];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:NULL];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    request.HTTPBody = jsonData;
    
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        handler(data, response, error);
    }];
    
    [task resume];
    
}
+ (void) httpPutRequest:(NSString*) endUrl withObjectBody:(NSObject*) object withCompletionHandler:(void(^)(NSData *data, NSURLResponse *response, NSError *error)) handler {
    
}

@end
