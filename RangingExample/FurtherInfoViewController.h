//
//  FurtherInformationControllerViewController.h
//  NearablesTouristLocationApplication
//
//  Created by Toireasa Moley on 17/02/2016.
//  Copyright © 2016 Estimote. All rights reserved.
//

#import "InsideAttractionViewController.h"
#import "Parse/Parse.h"
#import <PARSEUI/PFImageView.h>
#import <PARSEUI/PFImageView.h>
#import "iCarousel.h"
#import "TouristLocationPainting.h"

@interface FurtherInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *touristLocationInfoLbl;
@property (weak, nonatomic) IBOutlet UILabel *touristLocationNameLbl;
@property (nonatomic, strong) NSString *touristLocationNameTxt;
@property (weak, nonatomic) IBOutlet PFImageView *holder;
@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@property (nonatomic, strong) TouristLocationPainting *locationPainting;





@end
