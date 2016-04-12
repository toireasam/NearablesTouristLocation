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
@synthesize emailFieldEditTxt;

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
    
    if(self.emailFieldEditTxt.text.length <= 0)
        
    {
        // email is null
        if([self validateCredentials:passwordFieldEditTxt.text andUsername:usernameFieldEditTxt.text])
        {
            [self sendToParse:self.usernameFieldEditTxt.text andUsername:self.passwordFieldEditTxt.text andEmail:NULL];
        }
    }
    else
    {
        if([self validateCredentials:passwordFieldEditTxt.text andUsername:usernameFieldEditTxt.text] && [self validateEmail:emailFieldEditTxt.text])
            
        {
            [self sendToParse:self.usernameFieldEditTxt.text andUsername:self.passwordFieldEditTxt.text andEmail:emailFieldEditTxt.text];
        }
    }
}

-(void)sendToParse:(NSString *)password andUsername:(NSString *)username andEmail:(NSString *)email

{
    PFUser *pfUser = [PFUser user];
    pfUser.username = self.usernameFieldEditTxt.text;
    pfUser.password = self.passwordFieldEditTxt.text;
    if(email != NULL)
    {
            pfUser.email = email;
    }

    
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

-(BOOL)validateCredentials:(NSString *)password andUsername:(NSString *)username

{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL isValid = [emailTest evaluateWithObject:emailFieldEditTxt.text];
    
    if(password.length >= 6 && [password rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location != NSNotFound && usernameFieldEditTxt.text.length > 0)
    {
        return TRUE;
    }
    else if(password.length < 6 && [password rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location == NSNotFound && usernameFieldEditTxt.text.length <= 0)
        
    {
        if(emailFieldEditTxt.text.length > 0 && isValid != TRUE)
        {
            promptlbl.text = @"Minimum 6 chars and contain 1 number and username empty and email";

            NSLog(@"Bool value: %d",isValid);
            return FALSE;
            
        }
        else
        {
        promptlbl.text = @"Minimum 6 chars and contain 1 number and username empty a";
        return FALSE;
        }
    }
    else if(usernameFieldEditTxt.text.length <= 0)
    {
        
        promptlbl.text = @"Username empty";
        return FALSE;
    }
    else if(password.length < 6 || [password rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location == NSNotFound)
    {
        promptlbl.text =
        @"Minimum 6 chars and contain 1 number";
        return FALSE;
    }
    return FALSE;
}

-(BOOL)validateEmail:(NSString *)email

{
    NSString *emailRegex = email;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL isValid = [emailTest evaluateWithObject:email];
    if(!isValid)
    {
        NSLog(@"email add");
    }
    else
    {
        NSLog(@"valid");
    }
    return isValid;
}

- (IBAction)loginBtnClick:(id)sender {
    
    // Dismiss login screen
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

