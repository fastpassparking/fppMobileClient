//
//  httpRequestHandler.m
//  FastPassParking
//
//  Created by Kyle Mera on 10/30/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "HttpRequestHandler.h"
#import "errorObject.h"
#import <CommonCrypto/CommonDigest.h>

// Set the server's base url in a place that the entire app can reach
NSString *const SERVER_BASE_URL = BASE_URL;

@implementation HttpRequestHandler

+ (void) httpGetRequest:(NSString*) endUrl withCompletionHandler:(void(^)(NSData*, NSURLResponse*, NSError*)) handler {
    
    if([endUrl characterAtIndex:0] != '/') {
        endUrl = [NSString stringWithFormat:@"/%@", endUrl];
    }
    
    NSURL* url = [[NSURL alloc] initWithScheme:@"http" host:SERVER_BASE_URL path:endUrl];
    NSLog(@"Making GET request at url: ");
    NSLog(@"%@",[url description]);
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
        
        if(httpResponse.statusCode != 200) {
            NSLog(@"%@",[NSString stringWithFormat:@"GET Error code: %ld", (long)httpResponse.statusCode]);
            errorObject* errorOb = [[errorObject alloc] initWithJson:[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]];
            NSLog(@"%@", errorOb.errorMessage);
        } else {
            NSLog(@"GET successful");
        }
        
        handler(data, response, error);
    }];
    
    [dataTask resume];
    
}
+ (void) httpPostRequest:(NSString*) endUrl withObjectBody:(NSMutableDictionary*) object withCompletionHandler:(void(^)(NSData*, NSURLResponse*, NSError*)) handler {
    
    if([endUrl characterAtIndex:0] != '/') {
        endUrl = [NSString stringWithFormat:@"/%@", endUrl];
    }
    
    NSURL* url = [[NSURL alloc] initWithScheme:@"http" host:SERVER_BASE_URL path:endUrl];
    NSLog(@"Making POST request at url: ");
    NSLog(@"%@",[url description]);
    //NSLog(@"body: %@", [object description]);
    
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
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
        
        if(httpResponse.statusCode != 200) {
            NSLog(@"%@",[NSString stringWithFormat:@"POST Error code %ld", (long)httpResponse.statusCode]);
            errorObject* errorOb = [[errorObject alloc] initWithJson:[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]];
            NSLog(@"%@",errorOb.errorMessage);
        } else {
            NSLog(@"POST successful");
        }
        
        handler(data, response, error);
    }];
    
    [task resume];
    
}
+ (void) httpPutRequest:(NSString*) endUrl withObjectBody:(NSObject*) object withCompletionHandler:(void(^)(NSData *data, NSURLResponse *response, NSError *error)) handler {
    
    
    if([endUrl characterAtIndex:0] != '/') {
        endUrl = [NSString stringWithFormat:@"/%@", endUrl];
    }
    
    NSURL* url = [[NSURL alloc] initWithScheme:@"http" host:SERVER_BASE_URL path:endUrl];
    NSLog(@"Making PUT request at url: ");
    NSLog(@"%@",[url description]);
    //NSLog(@"body: %@", [object description]);
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:NULL];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"PUT";
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    request.HTTPBody = jsonData;
    
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
        
        if(httpResponse.statusCode != 200) {
            NSLog(@"%@",[NSString stringWithFormat:@"PUT Error code %ld", (long)httpResponse.statusCode]);
            errorObject* errorOb = [[errorObject alloc] initWithJson:[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]];
            NSLog(@"%@",errorOb.errorMessage);
        } else {
            NSLog(@"PUT successful");
        }
        
        handler(data, response, error);
    }];
    
    [task resume];
}

+ (NSString *) createSHA512:(NSString *)source {
    
    const char *s = [source cStringUsingEncoding:NSASCIIStringEncoding];
    
    NSData *keyData = [NSData dataWithBytes:s length:strlen(s)];
    
    uint8_t digest[CC_SHA512_DIGEST_LENGTH] = {0};
    
    CC_SHA512(keyData.bytes, keyData.length, digest);
    
    NSData *out = [NSData dataWithBytes:digest length:CC_SHA512_DIGEST_LENGTH];
    
    return NSDataToHex(out);
}

static inline char itoh(int i) {
    if (i > 9) return 'A' + (i - 10);
    return '0' + i;
}

NSString* NSDataToHex(NSData *data) {
    NSUInteger i, len;
    unsigned char *buf, *bytes;
    
    len = data.length;
    bytes = data.bytes;
    buf = malloc(len*2);
    
    for (i=0; i<len; i++) {
        buf[i*2] = itoh((bytes[i] >> 4) & 0xF);
        buf[i*2+1] = itoh(bytes[i] & 0xF);
    }
    
    return [[NSString alloc] initWithBytesNoCopy:buf
                                          length:len*2
                                        encoding:NSASCIIStringEncoding
                                    freeWhenDone:YES];
}

@end
