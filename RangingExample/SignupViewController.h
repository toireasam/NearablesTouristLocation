//  SignupViewController.h

#import <UIKit/UIKit.h>

@interface SignupViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameTxt;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxt;
@property (weak, nonatomic) IBOutlet UITextField *emailTxt;
@property (weak, nonatomic) IBOutlet UILabel *promptLblGeneral;
@property (weak, nonatomic) IBOutlet UILabel *promptLblUsername;
@property (weak, nonatomic) IBOutlet UILabel *promptLblPassword;
@property (weak, nonatomic) IBOutlet UILabel *promptLblEmail;
@property (weak, nonatomic) IBOutlet UITextField *signUpBtn;
@property (weak, nonatomic) IBOutlet UITextField *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *login;

@end
