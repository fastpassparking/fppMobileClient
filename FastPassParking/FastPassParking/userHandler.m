//
//  userHandler.m
//  FastPassParking
//
//  Created by Alex Gordon on 10/26/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "userHandler.h"
#import "user.h"
#import "AppDelegate.h"

@interface userHandler ()

@end

@implementation userHandler

-(void) initWithAppDelegate
{
    appDelegate = [[UIApplication sharedApplication] delegate];
}

-(void) authenticateLogin:(NSString*)loginName withLoginPassword:(NSString*)loginPassword withCompletionHandler:(void (^)(BOOL))Finished{
    
    NSString* endUrl = @"user/login?email=";
    endUrl = [endUrl  stringByAppendingFormat:@"%@&password=%@",loginName,loginPassword];

    [httpRequestHandler httpGetRequest:endUrl withCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if(!error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
            if(httpResponse.statusCode == 200) {
                appDelegate->globalUser = [[user alloc] initWithJson:[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]];
                Finished(YES);
            } else {
                NSLog(@"Error code: %ld", (long)httpResponse.statusCode);
            }
        } else {
            NSLog(@"Error");
        }
    }];
    
}

-(void) createAccount:(user*) userObject {
    
    NSString* endUrl = @"user";
    NSMutableDictionary* userJsonObject = [user serializeToJson:userObject];
    
    [httpRequestHandler httpPostRequest:endUrl withObjectBody:userJsonObject withCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if(error == nil) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
            if(httpResponse.statusCode == 200) {
                
            } else {
                NSLog(@"Error code: %ld", (long)httpResponse.statusCode);
            }
        } else {
            NSLog(@"Error");
        }
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
