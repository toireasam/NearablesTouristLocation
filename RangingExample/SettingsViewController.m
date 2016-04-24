//  SettingsViewController.m

#import "SettingsViewController.h"
#import "LoginViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

@synthesize museumSwitch;
@synthesize cityHallSwitch;
@synthesize logoutBtn;
@synthesize logout;

- (IBAction)logoutClick:(id)sender {
    
    [self setUserDefaults];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *viewController = (LoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"loginScreen"];
    [viewController setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:viewController animated:NO completion:nil];
    
}

-(void)setUserDefaults
{
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    [standardDefaults setObject:@"out" forKey:@"loggedin"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getUserCategoryDefaults];
    
    logout.userInteractionEnabled = NO;
}

-(void)getUserCategoryDefaults
{
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    
    self.museumSwitch.on = ([[standardDefaults stringForKey:@"museumSwitchKey"]
                             
                             isEqualToString:@"On"]) ? (YES) : (NO);
    
    self.cityHallSwitch.on = ([[standardDefaults stringForKey:@"cityhallSwitchKey"]
                               
                               isEqualToString:@"On"]) ? (YES) : (NO);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)museumSwitchChanged:(UISwitch *)sender {
    
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    
    if (sender.on == 0) {
        
        [standardDefaults setObject:@"Off" forKey:@"museumSwitchKey"];
        
    } else if (sender.on == 1) {
        
        [standardDefaults setObject:@"On" forKey:@"museumSwitchKey"];
        
    }
    
    [standardDefaults synchronize];
}

- (IBAction)cityhallSwitchChanged:(UISwitch *)sender {
    
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    
    if (sender.on == 0) {
        
        [standardDefaults setObject:@"Off" forKey:@"cityhallSwitchKey"];
        
    } else if (sender.on == 1) {
        
        [standardDefaults setObject:@"On" forKey:@"cityhallSwitchKey"];
        
    }
    
    [standardDefaults synchronize];
}

@end
