//
//  FurtherInformationControllerViewController.m
//  NearablesTouristLocationApplication
//
//  Created by Toireasa Moley on 17/02/2016.
//  Copyright © 2016 Estimote. All rights reserved.
//

#import "FurtherInfoViewController.h"

#import "iCarousel.h"

@interface FurtherInfoViewController ()
@end

@implementation FurtherInfoViewController
@synthesize touristLocationNameTxt;
@synthesize touristLocationNameLbl;
@synthesize touristLocationInfoLbl;
NSMutableArray *items;


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
    
// 
//        // Don't populate with info
//       query = [PFQuery queryWithClassName:@"TouristLocations"];
//    [query whereKey:@"TouristLocationName" equalTo:touristLocationNameTxt];
//        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
//         {
//             if(!error)
//             {
//                 PFFile *file = [object objectForKey:@"LocationImage"];
//                 // file has not been downloaded yet, we just have a handle on this file
//                 // Tell the PFImageView about your file
//                 self.holder.file = file;
//                 
//                 // Now tell PFImageView to download the file asynchronously
//                 [self.holder loadInBackground];
//             }
//         }];
    
    items = [NSMutableArray array];
    
    query = [PFQuery queryWithClassName:@"TestClass"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded. The first 100 objects are available in objects
            [items addObjectsFromArray:objects];
             [_carousel reloadData];
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    //configure carousel
    _carousel.type = iCarouselTypeRotary;
    
    //_carousel.viewpointOffset = CGSizeMake(0.0f, 100.0f);
   // [_carousel setContentOffset:CGSizeMake(0.0f, -60.0f)];

    //configure carousel
    _carousel.type = iCarouselTypeCoverFlow2;


 
    
   
}

-(void)viewDidDisappear:(BOOL)animated
{
      [items removeAllObjects];
}



- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return [items count];
}

-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view {
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300.0f, 300.0f)];
 
    }
    
    PFObject *eachObject = [items objectAtIndex:index];
    PFFile *theImage = [eachObject objectForKey:@"Image"];
    NSData *imageData = [theImage getData];
    UIImage *image = [UIImage imageWithData:imageData];
    
    ((UIImageView *)view).image = image;
    view.contentMode = UIViewContentModeCenter;
    
    return view;
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
