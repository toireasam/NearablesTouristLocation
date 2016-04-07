//
//  LoginViewController.m
//  NearablesTouristLocationApplication
//
//  Created by Toireasa Moley on 07/03/2016.
//  Copyright © 2016 Estimote. All rights reserved.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"
#import "AdminViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.promptLbl.hidden = YES;
    
    UITapGestureRecognizer *tapViewGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnView)];
    [self.view addGestureRecognizer:tapViewGR];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didTapOnView {
    [self.usernameFieldTxt resignFirstResponder];
    [self.passwordFieldTxt resignFirstResponder];
}

- (IBAction)signup:(id)sender {
    PFUser *pfUser = [PFUser user];
    pfUser.username = self.usernameFieldTxt.text;
    pfUser.password = self.passwordFieldTxt.text;
    
    __weak typeof(self) weakSelf = self;
    [pfUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            weakSelf.promptLbl.textColor = [UIColor greenColor];
            weakSelf.promptLbl.text = @"Signup successful!";
            weakSelf.promptLbl.hidden = NO;
        } else {
            weakSelf.promptLbl.textColor = [UIColor redColor];
            weakSelf.promptLbl.text = [error userInfo][@"error"];
            weakSelf.promptLbl.hidden = NO;
        }
    }];
}

- (IBAction)login:(id)sender {
    
    [self checkCredentials];
}

-(void)checkCredentials
{
    __weak typeof(self) weakSelf = self;
    [PFUser logInWithUsernameInBackground:self.usernameFieldTxt.text
                                 password:self.passwordFieldTxt.text
                                    block:^(PFUser *pfUser, NSError *error)
     {
         if (pfUser && !error) {
             
             // Proceed to next screen after successful login.
             
             weakSelf.promptLbl.hidden = YES;
             
             // Check if admin
             NSString *accessLevels = [[PFUser currentUser] objectForKey:@"Admin"];
             
             
             if([accessLevels isEqual: @"no"])
             {
                 
                 // They are a tourist but not an admin
                 
                 [self setUserDefaults:@"in"];
                 
                 // Send notification
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccessful" object:self];
                 
                 // Dismiss login screen
                 [self dismissViewControllerAnimated:YES completion:nil];
             }
             
         } else {
             // The login failed. Show error.
             weakSelf.promptLbl.textColor = [UIColor redColor];
             weakSelf.promptLbl.text = [error userInfo][@"error"];
             weakSelf.promptLbl.hidden = NO;
         }
     }];
}

-(void)setUserDefaults:(NSString *)loggedInStatus
{
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    [standardDefaults setObject:loggedInStatus forKey:@"loggedin"];    
}

@end
