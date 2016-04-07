//
//  LoginViewController.h
//  NearablesTouristLocationApplication
//
//  Created by Toireasa Moley on 07/03/2016.
//  Copyright © 2016 Estimote. All rights reserved.
//

#import "InsideAttractionViewController.h"

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *signUpBtn;
@property (weak, nonatomic) IBOutlet UITextField *usernameFieldTxt;
@property (weak, nonatomic) IBOutlet UITextField *passwordFieldTxt;
@property (weak, nonatomic) IBOutlet UILabel *promptLbl;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end
