//
//  AppDelegate.h
//  FastPassParking
//
//  Created by Ivan Lugo on 9/21/14.
//  Copyright (c) 2014 FastPassParking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "user.h"
#import "vehicle.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) user* loggedInUser;
@property (strong, nonatomic) vehicle* selectedVehicle;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end
