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
NSString *touristLocationAdmin;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      self.promptLbl.hidden = YES;
    // Tab the view to dismiss keyboard
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
    __weak typeof(self) weakSelf = self;
    [PFUser logInWithUsernameInBackground:self.usernameFieldTxt.text
                                 password:self.passwordFieldTxt.text
                                    block:^(PFUser *pfUser, NSError *error)
     {
               NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
         if (pfUser && !error) {
             // Proceed to next screen after successful login.
          
             weakSelf.promptLbl.hidden = YES;
             
             // check if admin
             NSString *athleteId = [[PFUser currentUser] objectForKey:@"Admin"];
             // get the location admin is associated with
             touristLocationAdmin = [[PFUser currentUser] objectForKey:@"TouristLocationName"];
             
             //NSLog(@"The athlete id is %@", athleteId);
             NSLog(athleteId);
             
           
             
             
             if([athleteId isEqual: @"yes"])
             {
                 
                 
                 NSLog(@"The athlete id is %@", athleteId);
                 // go to admin
                 NSLog(@"should move to admin screeen");
                 [self performSegueWithIdentifier:@"admin" sender:self];
                 NSLog(touristLocationAdmin);
                 
                 
             }
             else
             {
                 // they are a customer
                 NSLog(@"The athlete id is %@", athleteId);
           
                 
                 [standardDefaults setObject:@"in" forKey:@"loggedin"];
                                
                 // Send notification
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccessful" object:self];
                 
                 // Dismiss login screen
                 [self dismissViewControllerAnimated:YES completion:nil];
                 
                 // go to customer
                 NSLog(@"should move to customer screeen");
                 //[weakSelf performSegueWithIdentifier:@"test" sender:self];
                 [self performSegueWithIdentifier:@"test" sender:self];
           
                 
                
//                 // lets try sending to parse and this saves the data
//                 PFObject *newPlayer = [PFObject objectWithClassName:@"Players"];
                 
    //             PFQuery *query = [PFQuery queryWithClassName:@"Players];
     //            PFObject *object = [query getObjectWithId:@"Dl0dWVJWNt"];
//                 
//                 /*[newPlayer addObjectsFromArray:self.songsArrray forKey:@"songs"];
//                  here i got the exception, if i uncomment it*/
//
   //                                [[objects object] setObject:name forKey:@"Name"];
//                 [newPlayer setObject:@"toireasa" forKey:@"playerName"];
//                 [newPlayer setObject:@"testing" forKey:@"playerDescription"];
//                 [newPlayer setObject:@"random" forKey:@"playerPassword"];
//                 
//                 NSString *objectId = [newPlayer objectId];
//                 [[NSUserDefaults standardUserDefaults]setObject:objectId forKey:@"id"];
//                 
//                 [newPlayer saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                     if (!error) {
//                         NSLog(@"yahoo!!! saved data");
//                     }
//                     else {
//                         NSLog(@"oh shit... data is not saved");
//                     }
  //               }];

                 
             }
//
//             if(athleteId == false)
//             {
//                 // go to customer
//                    NSLog(@"should move to customer screeen");
//                     //[weakSelf performSegueWithIdentifier:@"test" sender:self];
//                     [self performSegueWithIdentifier:@"test" sender:self];
//             }
//             else
//             {
//                 // go to admin
//                    NSLog(@"should move to admin screeen");
//                     [weakSelf performSegueWithIdentifier:@"test2" sender:self];
//             }
         
             
         } else {
             // The login failed. Show error.
             weakSelf.promptLbl.textColor = [UIColor redColor];
             weakSelf.promptLbl.text = [error userInfo][@"error"];
             weakSelf.promptLbl.hidden = NO;
         }
     }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"admin"]) {
        AdminViewController *nextVC = (AdminViewController *)[segue destinationViewController];
        
        
              NSLog(@"tourist location admin is");
              NSLog(touristLocationAdmin);
        nextVC.touristLocationNameTxt = touristLocationAdmin;
        nextVC.touirstLocationNameEditField = touristLocationAdmin;
  
    }
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
