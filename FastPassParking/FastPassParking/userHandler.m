//
//  userHandler.m
//  FastPassParking
//
//  Created by Alex Gordon on 10/26/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "UserHandler.h"
#import "HttpRequestHandler.h"
#import "user.h"

@interface UserHandler ()

@end

@implementation UserHandler

+(void) authenticateLogin:(NSString*)loginName withLoginPassword:(NSString*)loginPassword withCompletionHandler:(void(^)(BOOL, user*)) handler{
    
    NSString* endUrl = @"user/login?email=";
    loginPassword = [HttpRequestHandler createSHA512:loginPassword];
    endUrl = [endUrl  stringByAppendingFormat:@"%@&password=%@",loginName,loginPassword];
    
    [HttpRequestHandler httpGetRequest:endUrl withCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        BOOL wasSuccessful = NO;
        user* returnedUser = nil;
        if(!error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
            if(httpResponse.statusCode == 200) {
                // Parse the user from json data
                returnedUser = [[user alloc] initWithJson:[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]];
                
                // Set the completionHandler response
                wasSuccessful = YES;
            } else {
                // Make user aware that
                NSLog(@"Error code: %ld", (long)httpResponse.statusCode);
            }
        } else {
            NSLog(@"Error");
        }
        
        // Return the completion handler to the caller
        handler(wasSuccessful, returnedUser);
    }];
    
}

+(void) createAccount:(user*) userObject withCompletionHandler:(void(^)(BOOL, user*))handler {
    
    NSString* endUrl = @"user";
    userObject.password = [HttpRequestHandler createSHA512:userObject.password];
    NSMutableDictionary* userJsonObject = [user serializeToJson:userObject];
    
    [HttpRequestHandler httpPostRequest:endUrl withObjectBody:userJsonObject withCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        BOOL wasSuccessful = NO;
        user* returnedUser = nil;
        if(!error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
            if(httpResponse.statusCode == 200) {
                // Parse the user from json data
                returnedUser = [[user alloc] initWithJson:[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]];
                
                // Set the completionHandler response
                wasSuccessful = YES;
            } else {
                NSLog(@"Error code: %ld", (long)httpResponse.statusCode);
            }
        } else {
            NSLog(@"Error");
        }
        
        // Return the completion handler to the caller
        handler(wasSuccessful, returnedUser);
    }];
}


/*
<<<<<<< HEAD
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
+(void) updateAccount:(user*) userObject withCompletionHandler:(void(^)(BOOL))handler {
    
    NSString* endUrl = @"user";
    NSMutableDictionary* userJsonObject = [user serializeToJson:userObject];
    
    [HttpRequestHandler httpPutRequest:endUrl withObjectBody:userJsonObject withCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        BOOL wasSuccessful = NO;
        if(!error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
            if(httpResponse.statusCode == 200 || httpResponse.statusCode == 204) {
                
                // Set the completionHandler response
                wasSuccessful = YES;
            } else {
                NSLog(@"Error code: %ld", (long)httpResponse.statusCode);
            }
        } else {
            NSLog(@"Error");
        }
        

    }];


}

=======
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
>>>>>>> kyle-create-account

@end
