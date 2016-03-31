//
//  FurtherInformationControllerViewController.h
//  NearablesTouristLocationApplication
//
//  Created by Toireasa Moley on 17/02/2016.
//  Copyright © 2016 Estimote. All rights reserved.
//

#import "ViewController.h"
#import "Parse/Parse.h"
#import <PARSEUI/PFImageView.h>
#import <PARSEUI/PFImageView.h>
#import "iCarousel.h"

@interface FurtherInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *touristLocationInfoLbl;
@property (weak, nonatomic) IBOutlet UILabel *touristLocationNameLbl;
@property (nonatomic, strong) NSString *touristLocationNameTxt;
@property (weak, nonatomic) IBOutlet PFImageView *holder;
@property (weak, nonatomic) IBOutlet iCarousel *carousel;





@end
