//
//  LoginViewController.m
//  NearablesTouristLocationApplication
//
//  Created by Toireasa Moley on 07/03/2016.
//  Copyright © 2016 Estimote. All rights reserved.
//

#import "LoginViewController.h"
#import "SignupViewController.h"
#import "Parse/Parse.h"
#import "AdminViewController.h"
#import "User.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
User *currentUser;

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
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SignupViewController *viewController = (SignupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"signupScreen"];
    [viewController setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:viewController animated:NO completion:nil];
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
             NSString *userType = [[PFUser currentUser] objectForKey:@"UserType"];
            
             if([userType isEqual: @"Tourist"])
             {
                 weakSelf.promptLbl.hidden = YES;
                 
                 currentUser = [[User alloc]init];
                 currentUser.username = [[PFUser currentUser] objectForKey:@"username"];
                 [self setUsernameDefaults:currentUser.username];
                 
                 
                 [self setLoginStatusDefaults:@"in"];
                 
                 // Send notification
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccessful" object:self];
                 
                 // Dismiss login screen
                 [self dismissViewControllerAnimated:YES completion:nil];
                 
             }
             else
             {
                 // The login failed. Show error.
                 weakSelf.promptLbl.textColor = [UIColor redColor];
                 weakSelf.promptLbl.text = NSLocalizedString(@"invalid login parameters", nil);
                 weakSelf.promptLbl.hidden = NO;
                 
             }
            
             }
             
          else {
             // The login failed. Show error.
             weakSelf.promptLbl.textColor = [UIColor redColor];
             weakSelf.promptLbl.text = NSLocalizedString(@"invalid login parameters", nil);
             weakSelf.promptLbl.hidden = NO;
         }
     }];
}
- (IBAction)forgotPasswordBtnClick:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Email Address", nil)
                                                        message:NSLocalizedString(@"Enter the email for your account:", nil)
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
                                              otherButtonTitles:NSLocalizedString(@"Ok", nil), nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        
        UITextField *emailAddress = [alertView textFieldAtIndex:0];
        
        [PFUser requestPasswordResetForEmailInBackground: emailAddress.text];
        
        UIAlertView *alertViewSuccess = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Success! A reset email was sent to you", nil) message:@""
                                                                  delegate:self
                                                         cancelButtonTitle:NSLocalizedString(@"Ok", nil)
                                                         otherButtonTitles:nil];
        [alertViewSuccess show];
    }
}

-(void)setLoginStatusDefaults:(NSString *)loggedInStatus
{
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    [standardDefaults setObject:loggedInStatus forKey:@"loggedin"];    
}

-(void)setUsernameDefaults:(NSString *)username
{
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    [standardDefaults setObject:username forKey:@"username"];
}

@end
