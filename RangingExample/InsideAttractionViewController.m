//
//  ViewController.m
//  RangingExample
//
//  Created by Marcin Klimek on 24/12/14.
//  Copyright (c) 2014 Estimote. All rights reserved.
//

#import "InsideAttractionViewController.h"
#import <EstimoteSDK/EstimoteSDK.h>
#import "FurtherInfoViewController.h"
#import "SettingsViewController.h"
#import "TouristLocationPainting.h"
#import "NearablesParseManager.h"


@interface ESTTableViewCell : UITableViewCell
@end
@implementation ESTTableViewCell
NSString *locationNameString;
NSString *museumsOn;
NSArray *places;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
    }
    return self;
}
@end

@interface InsideAttractionViewController () <UITableViewDelegate, UITableViewDataSource, ESTNearableManagerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *nearablesArray;
@property (nonatomic, strong) ESTNearableManager *nearableManager;
@property (nonatomic) NSDictionary *placesByBeacons;



@end

@implementation InsideAttractionViewController
@synthesize insideCategory;

TouristLocationPainting *locationPainting;
NearablesParseManager *nearablesParseManager;


-(void)viewWillAppear:(BOOL)animated
{
    [insideTouristAttractionBeacons removeAllObjects];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    locationPainting = [[TouristLocationPainting alloc]init];
    
    nearablesParseManager = [[NearablesParseManager alloc]init];

    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[ESTTableViewCell class] forCellReuseIdentifier:@"CellIdentifier"];
    
    [self.view addSubview:self.tableView];
    
    self.nearableManager = [ESTNearableManager new];
    self.nearableManager.delegate = self;
    [self.nearableManager startRangingForType:ESTNearableTypeAll];
    [nearablesParseManager setPlacesbyNearable];

}

-(void)getUserDefaults
{
    
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([[standardDefaults stringForKey:@"museumSwitchKey"] isEqual: @"On"]) {
        
        museumsOn = @"true";
    }
    
    else
    {
        museumsOn = @"false";
    }
    
}

-(void)getRelevantNearables
{
    insideTouristAttractionBeacons = [[NSMutableArray alloc] init];
    int i;
    for (i = 0; i < [self.nearablesArray count]; i++) {
        
        ESTNearable *nearable = [self.nearablesArray objectAtIndex:i];
        locationPainting.touristLocationCategory = [nearablesParseManager identifierNearablCategoru:nearable.identifier];
        if([locationPainting.touristLocationCategory  isEqual:@"museum" ] && [insideCategory isEqual:@"Ulster Museum"])
        {
             [insideTouristAttractionBeacons addObject:nearable];
            
        }
        else if([locationPainting.touristLocationCategory  isEqual:@"cityhall" ] && [insideCategory isEqual:@"Belfast City Hall"])
        {

         [insideTouristAttractionBeacons addObject:nearable];
        
        }
        else
        {
            // don't add to array

        }
        
    }
    
    [self.tableView reloadData];
}

#pragma mark - ESTNearableManager delegate
NSMutableArray *insideTouristAttractionBeacons;
- (void)nearableManager:(ESTNearableManager *)manager
      didRangeNearables:(NSArray *)nearables
               withType:(ESTNearableType)type
{
    
    ESTNearable *nearestBeacon = nearables.firstObject;

    places = [nearablesParseManager getPlacesByNearable:nearestBeacon];
    
    self.nearablesArray = nearables;
    
    [self getRelevantNearables];
    
}


#pragma mark - UITableView delegate and data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [insideTouristAttractionBeacons count];
}

- (UIImage *)imageForNearableType:(ESTNearableType)type
{
    switch (type)
    {
        case ESTNearableTypeBag:
            return [UIImage imageNamed:@"museum"];
            break;
        case ESTNearableTypeBike:
            return [UIImage imageNamed:@"museum"];
            break;
        case ESTNearableTypeCar:
            return [UIImage imageNamed:@"museum"];
            break;
        case ESTNearableTypeFridge:
            return [UIImage imageNamed:@"museum"];
            break;
        case ESTNearableTypeBed:
            return [UIImage imageNamed:@"museum"];
            break;
        case ESTNearableTypeChair:
            return [UIImage imageNamed:@"museum"];
            break;
        case ESTNearableTypeShoe:
            return [UIImage imageNamed:@"museum"];
            break;
        case ESTNearableTypeDoor:
            return [UIImage imageNamed:@"museum"];
            break;
        case ESTNearableTypeDog:
            return [UIImage imageNamed:@"museum"];
            break;
        default:
            return [UIImage imageNamed:@"museum"];
            break;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ESTNearable *nearable = [insideTouristAttractionBeacons objectAtIndex:indexPath.row];
    ESTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    
    // Check if the nearable is in parse
    locationPainting.touristLocationName = [nearablesParseManager identifierNearablType:nearable.identifier];

    NSString *place = [places objectAtIndex:indexPath.row];
   // DONT DELETE shouldBe = [shouldBe stringByAppendingString:place];
    cell.textLabel.text = locationPainting.touristLocationName;
    
    cell.imageView.image = [[UIImage alloc] init];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;

    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 60, 30, 30, 30)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView setImage:[self imageForNearableType:nearable.type]];
    [cell.contentView addSubview:imageView];
    
    if (indexPath.row == 0) // Top row
    {
        cell.textLabel.text = locationPainting.touristLocationName;
        [cell.textLabel setTextColor:[UIColor redColor]];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

#pragma mark - Utility methods


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    locationPainting.touristLocationName = cell.textLabel.text;
    
    [self performSegueWithIdentifier:@"push" sender:tableView];
 
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"push"]) {
        FurtherInfoViewController *nextVC = (FurtherInfoViewController *)[segue destinationViewController];
        
        nextVC.touristLocationNameTxt = locationPainting.touristLocationName;
        nextVC.locationPainting = locationPainting;
    }
}


@end
