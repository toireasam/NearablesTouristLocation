//  FurtherInformationControllerViewController.m

#import "FurtherInfoViewController.h"
#import "TouristLocationArtefact.h"
#import "LanguageManager.h"
#import "iCarousel.h"
#import "TouristLocationArtefact.h"

@interface FurtherInfoViewController ()

@end

@implementation FurtherInfoViewController

@synthesize artefactNameTxt;
@synthesize artefactNameLbl;
@synthesize artefactInfoLbl;
NSMutableArray *imagesOfAttraction;
NSString *currentLanguage;
LanguageManager *languageManager;
TouristLocationArtefact *locationArtefact;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    locationArtefact = [[TouristLocationArtefact alloc]init];
    locationArtefact.artefactName = artefactNameTxt;
    
    languageManager = [[LanguageManager alloc]init];
    currentLanguage = languageManager.presentCurrentLanguage;
    
    [self getLocationInfoAndDisplay];
    [self getLocationImagesAndDisplay];
    
    // Configure carousel
    _carousel.type = iCarouselTypeCoverFlow2;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}

-(void)getLocationImagesAndDisplay
{
    imagesOfAttraction = [NSMutableArray array];
    
    PFQuery *query = [PFQuery queryWithClassName:@"InsideTouristLocation"];
    [query whereKey:@"InsideTouristLocationArtefact" equalTo:locationArtefact.artefactName];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded. The first 100 objects are available in objects
            [imagesOfAttraction addObjectsFromArray:objects];
            [_carousel reloadData];
            
        }
        else
        {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

-(void)getLocationInfoAndDisplay
{
    PFQuery *query = [PFQuery queryWithClassName:currentLanguage];
    [query whereKey:@"InsideTouristLocationArtefact" equalTo:locationArtefact.artefactName];
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
                artefactNameLbl.text = object[@"TouristLocationName"];
                artefactInfoLbl.text = object[@"Information"];
                artefactInfoLbl.textColor = [UIColor darkGrayColor];
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
