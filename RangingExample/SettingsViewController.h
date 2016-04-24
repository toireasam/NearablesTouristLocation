//  SettingsViewController.h

#import "InsideAttractionViewController.h"

@interface SettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISwitch *museumSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *cityHallSwitch;
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;
@property (weak, nonatomic) IBOutlet UITextField *logout;

@end
