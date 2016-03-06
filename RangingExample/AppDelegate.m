//
//  AppDelegate.m
//  RangingExample
//
//  Created by Marcin Klimek on 24/12/14.
//  Copyright (c) 2014 Estimote. All rights reserved.
//

#import "AppDelegate.h"
#import "Parse/Parse.h"
#import <EstimoteSDK/EstimoteSDK.h>

@interface AppDelegate () <ESTBeaconManagerDelegate>
@property (nonatomic) ESTBeaconManager *beaconManager;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    

    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [Parse enableLocalDatastore];
    
    
    // Initialize Parse.
    [Parse setApplicationId:@"ZoFHgn6IfSnsuYTSkvZOkecTejs8Wa00dpEWU6go"
                  clientKey:@"RcYERJZfY2fDRpmz48rs7i6DpLWshMtuMliLA5qP"];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    // Override point for customization after application launch.
    // 4. Instantiate the beacon manager & set its delegate
    self.beaconManager = [ESTBeaconManager new];
    self.beaconManager.delegate = self;
    // add this below:
    [self.beaconManager requestAlwaysAuthorization];
    
    // add this below:
    [self.beaconManager startMonitoringForRegion:[[CLBeaconRegion alloc]
                                                  initWithProximityUUID:[[NSUUID alloc]
                                                                         initWithUUIDString:@"4f62633A-92C3-C253-6EC3-A213C6BF7"]
                                                  major:1 minor:1 identifier:@"monitored region"]];
    
    [[UIApplication sharedApplication]
     registerUserNotificationSettings:[UIUserNotificationSettings
                                       settingsForTypes:UIUserNotificationTypeAlert
                                       categories:nil]];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)beaconManager:(id)manager didEnterRegion:(CLBeaconRegion *)region {
    UILocalNotification *notification = [UILocalNotification new];
    notification.alertBody =
    @"Welcome to the Ulster Museum!";
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

@end
