//
//  AdminViewController.m
//  NearablesTouristLocationApplication
//
//  Created by Toireasa Moley on 19/03/2016.
//  Copyright © 2016 Estimote. All rights reserved.
//

#import "AdminViewController.h"

@interface AdminViewController ()

@end

@implementation AdminViewController
@synthesize touristLocationNameEdit;
@synthesize touristLocationNameTxt;
    NSString *objectID;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"from admin screen");
    NSLog(touristLocationNameTxt);
    
    self.touristLocationNameEdit.text = touristLocationNameTxt;
   // self.touirstLocationNameEditField.text = touristLocationNameTxt;

    
    PFQuery *query = [PFQuery queryWithClassName:@"TouristLocations"];
    [query whereKey:@"TouristLocationName" equalTo:touristLocationNameTxt];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            if(objects.count == 0)
            {
                // No beacons were found
                
            }
            for (PFObject *object in objects)
            {
                
                NSLog(@"%@", object.objectId);
                NSLog(@"%@",object);
                objectID = object.objectId;
                _touirstLocationNameEditField.text = object[@"TouristLocationName"];
                
                   _touirstLocationInfoEditField.text = object[@"Information"];
                
                
                
            }
        }
        else
        {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonClickUpdateInfo:(id)sender {
    
    NSLog(@"I am going to look for ");
    NSLog(touristLocationNameTxt);
    
    NSLog(@"I will update this with ");
    NSLog(_touirstLocationNameEditField.text);
    
    
    // lets do it
    PFQuery *query = [PFQuery queryWithClassName:@"TouristLocations"];
    
    // Retrieve the object by id
    [query getObjectInBackgroundWithId:objectID
                                 block:^(PFObject *object, NSError *error) {
                                     // Now let's update it with some new data. In this case, only cheatMode and score
                                     // will get sent to the cloud. playerName hasn't changed.
                                    object[@"Information"] = _touirstLocationInfoEditField.text;
                                    // object[@"score"] = @1338;
                                     [object saveInBackground];
                                 }];
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
