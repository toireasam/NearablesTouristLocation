//
//  SettingsViewController.h
//  NearablesTouristLocationApplication
//
//  Created by Toireasa Moley on 20/02/2016.
//  Copyright © 2016 Estimote. All rights reserved.
//

#import "InsideAttractionViewController.h"

@interface SettingsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISwitch *museumSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *cityHallSwitch;
- (IBAction)switchChanged:(UISwitch *)sender;
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;





@end
