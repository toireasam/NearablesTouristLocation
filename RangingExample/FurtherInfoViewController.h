//
//  FurtherInformationControllerViewController.h
//  NearablesTouristLocationApplication
//
//  Created by Toireasa Moley on 17/02/2016.
//  Copyright © 2016 Estimote. All rights reserved.
//

#import "ViewController.h"
#import "Parse/Parse.h"

@interface FurtherInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *touristLocationInfoLbl;
@property (weak, nonatomic) IBOutlet UILabel *touristLocationNameLbl;
@property (nonatomic, strong) NSString *touristLocationNameTxt;
@end
