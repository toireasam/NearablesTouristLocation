//  SignupViewController.m

#import "SignupViewController.h"
#import "Parse/Parse.h"
#import "AJWValidator.h"

@interface SignupViewController ()

@end

@implementation SignupViewController

@synthesize passwordTxt;
@synthesize usernameTxt;
@synthesize emailTxt;
@synthesize promptLblGeneral;
@synthesize promptLblPassword;
@synthesize promptLblUsername;
@synthesize promptLblEmail;
@synthesize loginBtn;
@synthesize signUpBtn;
@synthesize login;
AJWValidator *validator;
NSString *errorMsg;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Create password validator
    validator = [AJWValidator validatorWithType:AJWValidatorTypeString];
    [validator addValidationToEnsureMinimumLength:6 invalidMessage:NSLocalizedString(@"Min length is 6 characters!", nil)];
    [self setValidator:validator];
    
    loginBtn.userInteractionEnabled = NO;
    signUpBtn.userInteractionEnabled = NO;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    loginBtn.hidden = YES;
    login.hidden = YES;
    
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
    self.passwordTxt.backgroundColor = [UIColor whiteColor];
    promptLblPassword.hidden = YES;
}

- (void)handleInvalid
{
    UIColor *invalidRed = [UIColor colorWithRed:0.89 green:0.18 blue:0.16 alpha:1];
    self.passwordTxt.backgroundColor = [invalidRed colorWithAlphaComponent:0.3];
    self.promptLblPassword.text = [validator.errorMessages componentsJoinedByString:@" 💣\n"];
    promptLblPassword.hidden = NO;
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
        // Verify credentials are valid and if so create new parse user
        [self sendToParse:passwordTxt.text andUsername:usernameTxt.text andEmail:emailTxt.text];
    }
}

-(BOOL)validateCredentials
{
    // Check password validation
    [validator validate:self.passwordTxt.text];
    
    // Check email is present
    if(emailTxt.text.length > 0)
    {
        // Check email and username validation
        BOOL isValidEmail = [self validateEmail:emailTxt.text];
        BOOL isValid = [self validateUsername];
        promptLblEmail.hidden = NO;
        
        if(validator.isValid && isValid && isValidEmail)
        {
            return TRUE;
        }
        else
        {
            return FALSE;
        }
    }
    else
    {
        // No email, validate username only
        promptLblEmail.hidden = YES;
        BOOL isValid = [self validateUsername];
        if(validator.isValid && isValid)
        {
            return TRUE;
        }
        else
        {
            return FALSE;
        }
    }
}

-(BOOL)validateUsername
{
    // Ensure username is present
    if(usernameTxt.text.length == 0)
    {
        UIColor *invalidRed = [UIColor colorWithRed:0.89 green:0.18 blue:0.16 alpha:1];
        self.usernameTxt.backgroundColor = [invalidRed colorWithAlphaComponent:0.3];
        promptLblUsername.text = [NSString stringWithFormat:NSLocalizedString(@"Field is required", nil)];
        return FALSE;
    }
    else
    {
        promptLblUsername.text = @"";
        self.usernameTxt.backgroundColor = [UIColor whiteColor];
        return TRUE;
    }
}

-(void)sendToParse:(NSString *)password andUsername:(NSString *)username andEmail:(NSString *)email

{
    PFUser *pfUser = [PFUser user];
    pfUser.username = self.usernameTxt.text;
    pfUser.password = self.passwordTxt.text;
    if(emailTxt.text.length > 0)
    {
        pfUser.email = email;
    }
    
    __weak typeof(self) weakSelf = self;
    
    [pfUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (!error)
        {
            weakSelf.promptLblGeneral
            .textColor = [UIColor whiteColor];
            weakSelf.promptLblGeneral.text = [NSString stringWithFormat:NSLocalizedString(@"Signup sucessful!", nil)];
            weakSelf.promptLblGeneral.hidden = NO;
            loginBtn.hidden = NO;
            login.hidden = NO;
            
        }
        else
        {
            weakSelf.promptLblGeneral.textColor = [UIColor redColor];
            UIColor *invalidRed = [UIColor colorWithRed:0.89 green:0.18 blue:0.16 alpha:1];
            errorMsg = [error userInfo][@"error"];
            if ([errorMsg rangeOfString:@"username"].location == NSNotFound) {
                weakSelf.promptLblGeneral.text = [NSString stringWithFormat:NSLocalizedString(@"the email address entered has already been taken", nil)];
                emailTxt.backgroundColor = [invalidRed colorWithAlphaComponent:0.3];
            }
            else
            {
                weakSelf.promptLblGeneral.text = [NSString stringWithFormat:NSLocalizedString(@"the username entered has already been taken", nil)];
                usernameTxt.backgroundColor = [invalidRed colorWithAlphaComponent:0.3];
            }
            
            weakSelf.promptLblGeneral.hidden = NO;
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
        self.emailTxt.backgroundColor = [UIColor whiteColor];
    }
    else
    {
        promptLblEmail.text = [NSString stringWithFormat:NSLocalizedString(@"Invalid email", nil)];
        UIColor *invalidRed = [UIColor colorWithRed:0.89 green:0.18 blue:0.16 alpha:1];
        self.emailTxt.backgroundColor = [invalidRed colorWithAlphaComponent:0.3];
    }
    
    return isValid;
}

- (IBAction)loginBtnClick:(id)sender {
    
    // Dismiss login screen
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dismissKeyboard {
    [usernameTxt resignFirstResponder];
    [passwordTxt resignFirstResponder];
    [emailTxt resignFirstResponder];
}

@end

