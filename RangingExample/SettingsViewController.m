//
//  SettingsViewController.m
//  NearablesTouristLocationApplication
//
//  Created by Toireasa Moley on 20/02/2016.
//  Copyright © 2016 Estimote. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize museumSwitch;
@synthesize cityHallSwitch;

- (IBAction)logoutClick:(id)sender {
    
        
        NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
        [standardDefaults setObject:@"out" forKey:@"loggedin"];
        NSLog(@"should be logged out");
        
        
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    
    self.museumSwitch.on = ([[standardDefaults stringForKey:@"museumSwitchKey"]
                             
                             isEqualToString:@"On"]) ? (YES) : (NO);
    
    self.cityHallSwitch.on = ([[standardDefaults stringForKey:@"cityhallSwitchKey"]
                             
                             isEqualToString:@"On"]) ? (YES) : (NO);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)switchChanged:(UISwitch *)sender {
    
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    
    if (sender.on == 0) {
        
        [standardDefaults setObject:@"Off" forKey:@"museumSwitchKey"];
        
    } else if (sender.on == 1) {
        
        [standardDefaults setObject:@"On" forKey:@"museumSwitchKey"];
        
    }
    
    [standardDefaults synchronize];
    
}

- (IBAction)cityhallSwitchChanged:(UISwitch *)sender {
    
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    
    if (sender.on == 0) {
        
        [standardDefaults setObject:@"Off" forKey:@"cityhallSwitchKey"];
        
    } else if (sender.on == 1) {
        
        [standardDefaults setObject:@"On" forKey:@"cityhallSwitchKey"];
        
    }
    
    [standardDefaults synchronize];
    

}
@end
