//
//  AppDelegate.m
//  Checklists
//
//  Created by baizihan on 3/10/15.
//  Copyright (c) 2015 柏梓涵个人作品. All rights reserved.
//

#import "AppDelegate.h"
#import "AllListsViewController.h"
#import "DataModel.h"
@interface AppDelegate ()

@end

@implementation AppDelegate{
    DataModel *_dataModel;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _dataModel = [[DataModel alloc]init];
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    AllListsViewController *controller = navigationController.viewControllers[0];
    controller.dataModel = _dataModel;
    
    return YES;
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    NSLog(@"Notification:%@",notification);
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

-(void)saveData{
    [_dataModel saveChecklists];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self saveData];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveData];
}

@end
