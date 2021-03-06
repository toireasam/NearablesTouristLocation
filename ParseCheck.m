//
//  Parse.m
//  RangingExample
//
//  Created by Toireasa Moley on 16/02/2016.
//  Copyright © 2016 Estimote. All rights reserved.
//

#import "ParseCheck.h"
#import "ViewController.h"

@implementation ParseCheck



+(void)CheckRSSIInParse:(NSString *)RSSI
{
    PFQuery *query = [PFQuery queryWithClassName:@"TouristLocations"];
    [query whereKey:@"RSSI" equalTo:RSSI];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu nearables.", (unsigned long)objects.count);
            // Do something with the found objects
            if(objects.count == 0)
            {
                // No nearabes were found
                
            }
            NSMutableArray *touristLocations =  [[NSMutableArray alloc] init];
            NSMutableArray *identifiers =  [[NSMutableArray alloc] init];
            for (PFObject *object in objects)
            {
                
                NSLog(@"%@", object.objectId);
                NSLog(@"%@",object);
                NSString *touristLocationName = object[@"TouristLocationName"];
                NSString *RSSI = object[@"RSSI"];
                
                [touristLocations addObject: touristLocationName];
                [identifiers addObject:RSSI];
                
            }
   
        }
        else
        {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            
        }
        
    }];

}
@end

