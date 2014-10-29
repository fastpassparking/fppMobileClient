//
//  ViewController.m
//  FastPassParking
//
//  Created by Ivan Lugo on 9/21/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "ViewController.h"
#import "User.h"
#import "userHandler.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"Ivan overwrote the test.");
    int height2 = [UIScreen mainScreen].bounds.size.height;
    test_height.text = [NSString stringWithFormat:@"%d",height2];
    
    
    NSURL* url = [NSURL URLWithString:[@"http://107.203.220.120" stringByAppendingPathComponent:@"User"]];
    NSMutableDictionary* userWrapper = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* newUser = [[NSMutableDictionary alloc] init];
    NSString* email = @"thisisanotheremail@stuff.com";
    NSString* password = @"asupersecurepasswordAGAINBITCH";
//    NSString* arbitraryData = @"84uq9wdjisauhdih23874h273he7qhwd7qw6hre";
    [newUser setObject:email forKey:@"email"];
    [newUser setObject:password forKey:@"password"];
//    [newUser setObject:arbitraryData forKey:@"arbitraryStuff"];
    [userWrapper setObject:newUser forKey:@"user"];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:userWrapper
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:NULL];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    request.HTTPBody = jsonData;
    
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSLog(@"Finished. user is:");
        NSString* stringFromData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", stringFromData);
    }];
    
    [task resume];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)checkSignIn:(id)sender{
    
    NSString* loginText = [SignInScreen_UserName text];
    NSString* passwordText = [SignInScreen_Password text];
    
    userHandler* checkingUser = [[userHandler alloc] init];
    
    [checkingUser initWithBaseURL];
    
    [checkingUser authenticateLogin:loginText withLoginPassword:passwordText];
    
}

@end
