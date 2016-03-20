//
//  FurtherInformationControllerViewController.m
//  NearablesTouristLocationApplication
//
//  Created by Toireasa Moley on 17/02/2016.
//  Copyright © 2016 Estimote. All rights reserved.
//

#import "FurtherInfoViewController.h"

@interface FurtherInfoViewController ()
@end

@implementation FurtherInfoViewController
@synthesize touristLocationNameTxt;
@synthesize touristLocationNameLbl;
@synthesize touristLocationInfoLbl;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"correct place follow");
   NSLog(touristLocationNameTxt);
    
    // check what language
    [[NSLocale preferredLanguages] objectAtIndex:0];
    NSLog(@"language tag");
    //sv-GB
    // if its sv-GB pull from the swedish parse db
    NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSString *swedish = @"sv-GB";
    NSLog([[NSLocale preferredLanguages] objectAtIndex:0]);
    
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
                NSLog(@"%@",object);                touristLocationNameLbl.text = object[@"TouristLocationName"];
                
              //  NSString *touristLocationName = object[@"TouristLocationName"];
                
       

               
                
               // touristLocationNameLbl.text =  [NSString stringWithFormat:NSLocalizedString(@"" +touristLocationName, nil)];
                if([language isEqualToString:swedish])
                    
                {
                    
                     touristLocationInfoLbl.text = object[@"InformationSpanish"];
                    
                }
                
                else
                    
                {
                          touristLocationInfoLbl.text = object[@"Information"];
                    
                    
                }
                

                
                
                

                
            }
        }
        else
        {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);            
        }
        
}];
    
 
        // Don't populate with info
       query = [PFQuery queryWithClassName:@"TouristLocations"];
    [query whereKey:@"TouristLocationName" equalTo:touristLocationNameTxt];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
         {
             if(!error)
             {
                 PFFile *file = [object objectForKey:@"LocationImage"];
                 // file has not been downloaded yet, we just have a handle on this file
                 // Tell the PFImageView about your file
                 self.holder.file = file;
                 
                 // Now tell PFImageView to download the file asynchronously
                 [self.holder loadInBackground];
             }
         }];
    
//    
//    // Do any additional setup after loading the view.
//        PFQuery *query = [PFQuery queryWithClassName:@"TouristLocations"];
////    
//    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
//        
//        NSLog(@"Retrieved data");
//        
//        if (!error) {
////            PFFile *file = [object objectForKey:@"LocationImage"];
////            
////            self.test.file = file;
////            
//            [self.holder loadInBackground];
//            
//            self.holder.file = [object objectForKey:@"LocationImage"];
//            [self.holder loadInBackground];
//        }
//    }];
    
    
   
 
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
