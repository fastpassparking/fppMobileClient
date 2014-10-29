//
//  userHandler.m
//  FastPassParking
//
//  Created by Alex Gordon on 10/26/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "userHandler.h"
#import "user.h"

#define BASE_URL @"http://107.203.220.120"
#define User @"User";

@interface userHandler ()

@end

@implementation userHandler

-(void) initWithBaseURL
{
    _kBaseURL = BASE_URL;
}


-(void) authenticateLogin:(NSString*) loginName withLoginPassword:(NSString*) loginPassword{
    
    NSURL* url = [NSURL URLWithString:[[[self.kBaseURL stringByAppendingPathComponent:@"User"] stringByAppendingPathComponent:@"login?email="] stringByAppendingFormat:@"%@&password=%@",loginName,loginPassword]];

    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if(error == nil){
            
            NSLog(@"Connected");
            user* currentUser = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            
        }
        
        else{
            NSLog(@"Failed");
        }
    }];
    
    [dataTask resume];
    
    
    
    
    
    
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
