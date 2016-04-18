//
//  FurtherInformationControllerViewController.m
//  NearablesTouristLocationApplication
//
//  Created by Toireasa Moley on 17/02/2016.
//  Copyright © 2016 Estimote. All rights reserved.
//

#import "FurtherInfoViewController.h"
#import "TouristLocationPainting.h"
#import "LanguageManager.h"
#import "iCarousel.h"

@interface FurtherInfoViewController ()
@end

@implementation FurtherInfoViewController
@synthesize touristLocationNameTxt;
@synthesize touristLocationNameLbl;
@synthesize touristLocationInfoLbl;
NSMutableArray *imagesOfAttraction;
@synthesize locationPainting;
LanguageManager *languageManager;
NSString *currentLanguage;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    languageManager = [[LanguageManager alloc]init];
    currentLanguage = languageManager.presentCurrentLanguage;
    
    [self getLocationInfoAndDisplay];
    [self getLocationImagesAndDisplay];

    //configure carousel
    _carousel.type = iCarouselTypeCoverFlow2;

}

-(void)getLocationImagesAndDisplay
{
    imagesOfAttraction = [NSMutableArray array];
    
    PFQuery *query = [PFQuery queryWithClassName:@"InsideTouristLocation"];
    [query whereKey:@"InsideTouristLocationArtefact" equalTo:locationPainting.touristLocationName];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded. The first 100 objects are available in objects
            [imagesOfAttraction addObjectsFromArray:objects];
            [_carousel reloadData];
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}

-(void)getLocationInfoAndDisplay
{
    PFQuery *query = [PFQuery queryWithClassName:currentLanguage];
    [query whereKey:@"InsideTouristLocationArtefact" equalTo:locationPainting.touristLocationName];
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
                touristLocationNameLbl.text = object[@"TouristLocationName"];
                touristLocationInfoLbl.text = object[@"Information"];
            }
        }
        else
        {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
    }];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
      [imagesOfAttraction removeAllObjects];
}

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return [imagesOfAttraction count];
}

-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view {
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300.0f, 300.0f)];
 
    }
    
    PFObject *eachObject = [imagesOfAttraction objectAtIndex:index];
    PFFile *theImage = [eachObject objectForKey:@"ArtefactImage"];
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

@end
