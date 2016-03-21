//
//  AdminViewController.h
//  NearablesTouristLocationApplication
//
//  Created by Toireasa Moley on 19/03/2016.
//  Copyright © 2016 Estimote. All rights reserved.
//

#import "ViewController.h"

@interface AdminViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIImagePickerController *ipc;
    UIPopoverController *popover;
}

@property (weak, nonatomic) IBOutlet UILabel *touristLocationNameEdit;
@property (nonatomic, strong) NSString *touristLocationNameTxt;
@property (weak, nonatomic) IBOutlet UITextField *touirstLocationNameEditField;
@property (weak, nonatomic) IBOutlet UIButton *UpdateLocationInfoBtn;
@property (weak, nonatomic) IBOutlet UITextField *touirstLocationInfoEditField;

@property (weak, nonatomic) IBOutlet UIButton *btnGallery;
@property (weak, nonatomic) IBOutlet UIButton *btnCamera;
@property (weak, nonatomic) IBOutlet UIImageView *ivPickedImage;



@end
