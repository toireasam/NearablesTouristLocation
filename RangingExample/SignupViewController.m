//
//  SignupViewController.m
//  bAdventurous
//
//  Created by Toireasa Moley on 09/04/2016.
//  Copyright © 2016 Estimote. All rights reserved.
//

#import "SignupViewController.h"
#import "Parse/Parse.h"
#import "AJWValidator.h"

@interface SignupViewController ()

@end

@implementation SignupViewController

@synthesize passwordFieldEditTxt;
@synthesize usernameFieldEditTxt;
@synthesize promptlbl;
@synthesize loginBtn;
@synthesize emailFieldEditTxt;
AJWValidator *validator;
@synthesize promptLblUsername;
@synthesize promptLblEmail;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    loginBtn.hidden = YES;
    validator = [AJWValidator validatorWithType:AJWValidatorTypeString];
    [validator addValidationToEnsureMinimumLength:6 invalidMessage:NSLocalizedString(@"Min length is 6 characters!", nil)];
    [self setValidator:validator];
    
}

- (void)setValidator:(AJWValidator *)validator
{
    validator = validator;
    
    __typeof__(self) __weak weakSelf = self;
    
    validator.validatorStateChangedHandler = ^(AJWValidatorState newState) {
        
        switch (newState) {
            case AJWValidatorValidationStateValid: {
                [weakSelf handleValid];
                break;
            }
            case AJWValidatorValidationStateInvalid: {
                [weakSelf handleInvalid];
                break;
            }
            case AJWValidatorValidationStateWaitingForRemote: {
                [weakSelf handleWaiting];
                break;
            }
        }
    };
}
- (void)handleValid
{
    UIColor *validGreen = [UIColor colorWithRed:0.27 green:0.63 blue:0.27 alpha:1];
    self.passwordFieldEditTxt.backgroundColor = [validGreen colorWithAlphaComponent:0.3];
    self.promptlbl.text = NSLocalizedString(@"No errors 😃", nil);
    self.promptlbl.textColor = validGreen;
}

- (void)handleInvalid
{
    UIColor *invalidRed = [UIColor colorWithRed:0.89 green:0.18 blue:0.16 alpha:1];
    self.passwordFieldEditTxt.backgroundColor = [invalidRed colorWithAlphaComponent:0.3];
    self.promptlbl.text = [validator.errorMessages componentsJoinedByString:@" 💣\n"];
    self.passwordFieldEditTxt.textColor = invalidRed;
}

- (void)handleWaiting
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (IBAction)signUpBtnClick:(id)sender {
    
    BOOL validCredentials = [self validateCredentials];
    
    if(validCredentials)
    {
        [self sendToParse:passwordFieldEditTxt.text andUsername:usernameFieldEditTxt.text andEmail:emailFieldEditTxt.text];
    }
 

  
   

}

-(BOOL)validateCredentials
{
    [validator validate:self.passwordFieldEditTxt.text];
    // validate username
    // check email is present
    if(emailFieldEditTxt.text.length > 0)
    {
        BOOL isValidEmail = [self validateEmail:emailFieldEditTxt.text];
        BOOL isValid = [self validateUsername];
        promptLblEmail.hidden = NO;
        if(validator.isValid && isValid && isValidEmail)
        {
            NSLog(@"Valid");
            return TRUE;
            
        }
        else
        {
            NSLog(@"Invalid");
            return FALSE;
        }
    }
    else
    {   promptLblEmail.hidden = YES;
        BOOL isValid = [self validateUsername];
        if(validator.isValid && isValid)
        {
            NSLog(@"Valid 2 ");
            return TRUE;
            
        }
        else
        {
            NSLog(@"Invalid 2");
            return FALSE;
        }
        
        
    }
}

-(BOOL)validateUsername
{
    if(usernameFieldEditTxt.text.length == 0)
    {
      
        UIColor *invalidRed = [UIColor colorWithRed:0.89 green:0.18 blue:0.16 alpha:1];
        self.usernameFieldEditTxt.backgroundColor = [invalidRed colorWithAlphaComponent:0.3];
        promptLblUsername.text = @"Field is required";
        self.usernameFieldEditTxt.textColor = invalidRed;
        return FALSE;
        
    }
    else
    {
        promptLblUsername.text = @"";
        UIColor *validGreen = [UIColor colorWithRed:0.27 green:0.63 blue:0.27 alpha:1];
        self.usernameFieldEditTxt.backgroundColor = [validGreen colorWithAlphaComponent:0.3];
        return TRUE;
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
            UIColor *invalidRed = [UIColor colorWithRed:0.89 green:0.18 blue:0.16 alpha:1];
            usernameFieldEditTxt.backgroundColor = [invalidRed colorWithAlphaComponent:0.3];
            weakSelf.promptlbl.text = [error userInfo][@"error"];
            weakSelf.promptlbl.hidden = NO;
            
        }
    }];
}


-(BOOL)validateEmail:(NSString *)email

{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL isValid = [emailTest evaluateWithObject:email];
    if(isValid)
    {

        promptLblEmail.text = @"";
    
        
        UIColor *validGreen = [UIColor colorWithRed:0.27 green:0.63 blue:0.27 alpha:1];
        self.emailFieldEditTxt.backgroundColor = [validGreen colorWithAlphaComponent:0.3];
        

 
        

          }
    else
    {
       
             promptLblEmail.text = @"Invalid email";
       UIColor *invalidRed = [UIColor colorWithRed:0.89 green:0.18 blue:0.16 alpha:1];
        self.emailFieldEditTxt.backgroundColor = [invalidRed colorWithAlphaComponent:0.3];
        self.emailFieldEditTxt.textColor = invalidRed;
        

        
    }
    return isValid;
}

- (IBAction)loginBtnClick:(id)sender {
    
    // Dismiss login screen
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

