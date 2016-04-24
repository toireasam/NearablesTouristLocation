//  AppDelegate.m

#import "AppDelegate.h"
#import <EstimoteSDK/EstimoteSDK.h>
#import "Parse/Parse.h"
#import "ParseUI/PFImageView.h"
#import "LoginViewController.h"

@interface AppDelegate () <ESTBeaconManagerDelegate>

@property (nonatomic) ESTBeaconManager *beaconManager;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [PFImageView class];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    // Key to interact with Parse API
    [Parse enableLocalDatastore];
    [Parse setApplicationId:@"ZoFHgn6IfSnsuYTSkvZOkecTejs8Wa00dpEWU6go"
                  clientKey:@"RcYERJZfY2fDRpmz48rs7i6DpLWshMtuMliLA5qP"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    // Set up the beacon region to monitor
    self.beaconManager = [ESTBeaconManager new];
    self.beaconManager.delegate = self;
    [self.beaconManager requestAlwaysAuthorization];
    [self.beaconManager startMonitoringForRegion:[[CLBeaconRegion alloc]
                                                  initWithProximityUUID:[[NSUUID alloc]
                                                                         initWithUUIDString:@"8492E75F-4FD6-469D-B132-043FE94921D8"]
                                                  major:3059 minor:17204 identifier:@"monitored region"]];
    
    [[UIApplication sharedApplication]
     registerUserNotificationSettings:[UIUserNotificationSettings
                                       settingsForTypes:UIUserNotificationTypeAlert
                                       categories:nil]];
    
    [[UITabBar appearance] setTintColor:[UIColor darkGrayColor]];
    
    // Present login screen if user has not yet logged in
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    if ([[standardDefaults stringForKey:@"loggedin"] isEqual: @"out"])
    {
        [self showLoginScreen:YES];
    }
    
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
    
    // Present notification to user on entry of region
    UILocalNotification *notification = [UILocalNotification new];
    notification.alertBody =
    @"Welcome to the Ulster Museum!";
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

-(void) showLoginScreen:(BOOL)animated
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *viewController = (LoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"loginScreen"];
    [self.window makeKeyAndVisible];
    [self.window.rootViewController presentViewController:viewController
                                                 animated:animated
                                               completion:nil];
}

@end
