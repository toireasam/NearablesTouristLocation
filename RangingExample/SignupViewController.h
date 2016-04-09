//
//  SignupViewController.h
//  bAdventurous
//
//  Created by Toireasa Moley on 09/04/2016.
//  Copyright © 2016 Estimote. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignupViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameFieldEditTxt;
@property (weak, nonatomic) IBOutlet UITextField *passwordFieldEditTxt;
@property (weak, nonatomic) IBOutlet UILabel *promptlbl;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end
