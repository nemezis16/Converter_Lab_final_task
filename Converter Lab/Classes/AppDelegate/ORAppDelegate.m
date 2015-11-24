//
//  ORAppDelegate.m
//  Converter Lab
//
//  Created by RomanOsadchuk on 12.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import "ORAppDelegate.h"
#import "ORDatabaseModel.h"

@interface ORAppDelegate ()
@property (nonatomic, strong)ORDatabaseModel* databaseModel;
@end

@implementation ORAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.databaseModel=[ORDatabaseModel new];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:55.0f/255.0f green:71.0/255.0f blue:79.0f/255.0f alpha:1.0f]];
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self.databaseModel saveContext];
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    [self.databaseModel saveContext];
    
}

@end
