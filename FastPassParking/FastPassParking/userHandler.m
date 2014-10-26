//
//  userHandler.m
//  FastPassParking
//
//  Created by Alex Gordon on 10/26/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "userHandler.h"

#define BASE_URL @"107.203.220.120"
@interface userHandler ()

@end

@implementation userHandler

-(void) initWithBaseURL
{
    _kBaseURL = BASE_URL;
}


-(void) authenticateLogin{
    
    NSURL* url = [NSURL URLWithString:[self.kBaseURL stringByAppendingPathComponent:@"User"]];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    
    
    
    
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
