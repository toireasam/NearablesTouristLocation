//
//  SignupViewController.m
//  bAdventurous
//
//  Created by Toireasa Moley on 09/04/2016.
//  Copyright © 2016 Estimote. All rights reserved.
//

#import "SignupViewController.h"
#import "Parse/Parse.h"

@interface SignupViewController ()

@end

@implementation SignupViewController
@synthesize passwordFieldEditTxt;
@synthesize usernameFieldEditTxt;
@synthesize promptlbl;
@synthesize loginBtn;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    loginBtn.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)signUpBtnClick:(id)sender {
    
    PFUser *pfUser = [PFUser user];
    pfUser.username = self.usernameFieldEditTxt.text;
    pfUser.password = self.passwordFieldEditTxt.text;
    
    __weak typeof(self) weakSelf = self;
    [pfUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            weakSelf.promptlbl
            .textColor = [UIColor greenColor];
            weakSelf.promptlbl.text = @"Signup successful!";
            weakSelf.promptlbl.hidden = NO;
                loginBtn.hidden = NO;
        } else {
            weakSelf.promptlbl.textColor = [UIColor redColor];
            weakSelf.promptlbl.text = [error userInfo][@"error"];
            weakSelf.promptlbl.hidden = NO;
        }
    }];
    
}

- (IBAction)loginBtnClick:(id)sender {
    
    // Dismiss login screen
    [self dismissViewControllerAnimated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
