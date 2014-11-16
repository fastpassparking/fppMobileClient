//
//  user.m
//  FastPassParking
//
//  Created by Alex Gordon on 10/26/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import "user.h"
#import "JsonSerializerUtils.h"

@interface user ()

@end

@implementation user

- (id) initWithJson:(NSObject*)jsonObject{
    self = [super init];
    if (self && jsonObject) {
        self.dbId = [jsonObject valueForKey:@"_id"];
        self.firstName = [jsonObject valueForKey:@"firstName"];
        self.lastName = [jsonObject valueForKey:@"lastName"];
        self.email = [jsonObject valueForKey:@"email"];
        self.password = [jsonObject valueForKey:@"password"];
        self.phoneNumber = [jsonObject valueForKey:@"phoneNumber"];
        self.availableCredit = [jsonObject valueForKey:@"availableCredit"];
    }
    return self;
}

+ (NSMutableDictionary*) serializeToJson:(user*)userObject {
    
    NSMutableDictionary* userWrapper;
    if(userObject) {
        userWrapper = [[NSMutableDictionary alloc] init];
        NSMutableDictionary* newUser = [[NSMutableDictionary alloc] init];
        [JsonSerializerUtils setObject:userObject.dbId forKey:@"_id" forDictionary:newUser];
        [newUser setObject:userObject.firstName forKey:@"firstName"];
        [newUser setObject:userObject.lastName forKey:@"lastName"];
        [newUser setObject:userObject.email forKey:@"email"];
        [newUser setObject:userObject.password forKey:@"password"];
        [newUser setObject:userObject.phoneNumber forKey:@"phoneNumber"];
        [JsonSerializerUtils setObject:userObject.availableCredit forKey:@"availableCredit" forDictionary:newUser];
        
        [userWrapper setObject:newUser forKey:@"user"];
    }
    
    return userWrapper;
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
