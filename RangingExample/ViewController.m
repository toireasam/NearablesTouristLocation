//
//  ViewController.m
//  RangingExample
//
//  Created by Marcin Klimek on 24/12/14.
//  Copyright (c) 2014 Estimote. All rights reserved.
//

#import "ViewController.h"
#import <EstimoteSDK/EstimoteSDK.h>
#import "ParseCheck.h"
#import "FurtherInfoViewController.h"
#import "SettingsViewController.h"


@interface ESTTableViewCell : UITableViewCell
@end
@implementation ESTTableViewCell
NSString *locationNameString;
NSString *museumsOn;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
    }
    return self;
}
@end

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, ESTNearableManagerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *nearablesArray;
@property (nonatomic, strong) ESTNearableManager *nearableManager;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.title = @"Ranged Estimote Nearables";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[ESTTableViewCell class] forCellReuseIdentifier:@"CellIdentifier"];
    
    [self.view addSubview:self.tableView];
    
    /*
    * Initialize nearables manager and start ranging
    * devices around with any possible type. When nearables are ranged
    * propper delegate method is invoke. Delegate method updates
    * nearables array and reload table view.
    */
    self.nearableManager = [ESTNearableManager new];
    self.nearableManager.delegate = self;
    [self.nearableManager startRangingForType:ESTNearableTypeAll];
    
  
    
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([[standardDefaults stringForKey:@"museumSwitchKey"] isEqual: @"On"]) {
        
        // Do Something
        NSLog(@"museums are on");
        museumsOn = @"true";
    }
    
    
    else {
        
        // Do Something Else
        NSLog(@"museums are off");
        museumsOn = @"false";
    }

}

#pragma mark - ESTNearableManager delegate
NSMutableArray *objectNames;
- (void)nearableManager:(ESTNearableManager *)manager
      didRangeNearables:(NSArray *)nearables
               withType:(ESTNearableType)type
{
    /*
     * Update local nearables array and reload table view
     */
    self.nearablesArray = nearables;
   
    
    // loop to check if any museums

     objectNames = [[NSMutableArray alloc] init];
    int i;
    for (i = 0; i < [self.nearablesArray count]; i++) {
 
       // ...do something useful with myArrayElement
             ESTNearable *nearable = [self.nearablesArray objectAtIndex:i];
                NSString *shouldBe = [self identifierNearablCategoru:nearable.identifier];
        if([shouldBe  isEqual:@"museum" ] && [museumsOn isEqual:@"false"])
        {
            NSLog(@"shouldnt add this object to array");
            
  // dont
     

        }
        else
        {
           [objectNames addObject:nearable];
            NSLog(@"trying to add in array");
       
            NSLog(@"array: %@",objectNames);
        }
            }

    [self.tableView reloadData];
}


#pragma mark - UITableView delegate and data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [objectNames count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    ESTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    
    /*
     * Fill the table with beacon data.
     */
    
    ESTNearable *nearable = [objectNames objectAtIndex:indexPath.row];
    
    // Check if the nearable is in parse
    NSString *shouldBe = [self identifierNearablType:nearable.identifier];

    cell.textLabel.text = shouldBe;
    
   // cell.detailTextLabel.text = [NSString stringWithFormat:@"Type: %@ / RSSI: %zd", [ESTNearableDefinitions nameForType:nearable.type], nearable.rssi];
    
    cell.imageView.image = [[UIImage alloc] init];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;

    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 60, 30, 30, 30)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView setImage:[self imageForNearableType:nearable.type]];
    [cell.contentView addSubview:imageView];
    

    shouldBe = [shouldBe stringByAppendingString:@"top"]; //str is now "hello world"
    int index = indexPath.row;
    if (index == 0) // Top row
    {
           cell.textLabel.text = shouldBe;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

#pragma mark - Utility methods

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


- (NSString *)identifierNearablType:(NSString *)identifier
{
    if([identifier  isEqual: @"66e0c67afa889a0b"])
    {
        return @"The Scream";        
    }
    
    else if([identifier  isEqual: @"2d0159fcfa96b7b3"])
    {
        return @"Guernica";
    }
    else if([identifier  isEqual: @"d082874074797782"])
    {
        return @"Ulster museum";
    }
    else if([identifier  isEqual: @"0d7f92edbe655539"])
    {
        return @"Starry Night";
    }
    else if([identifier  isEqual: @"f220399a8e348d6e"])
    {
        return @"The Mona Lisa";
    }
    else
    {
     return @"unknown";
    }
}

- (NSString *)identifierNearablCategoru:(NSString *)identifier
{
    if([identifier  isEqual: @"66e0c67afa889a0b"])
    {
        return @"museum";
    }
    
    else if([identifier  isEqual: @"2d0159fcfa96b7b3"])
    {
        return @"museum";
    }
    else if([identifier  isEqual: @"d082874074797782"])
    {
        return @"museum";
    }
    else if([identifier  isEqual: @"0d7f92edbe655539"])
    {
        return @"museum";
    }
    else if([identifier  isEqual: @"f220399a8e348d6e"])
    {
        return @"museum";
    }
    else
    {
        return @"museum";
    }
}
NSString *selectedPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //how can I get the text of the cell here?
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    selectedPath = cell.textLabel.text;
    NSLog(selectedPath);
    
    NSLog(@"%ld", (long)indexPath.row); // you can see selected row number in your console;
    [self performSegueWithIdentifier:@"push" sender:tableView];

    
 
   }

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"push"]) {
        FurtherInfoViewController *nextVC = (FurtherInfoViewController *)[segue destinationViewController];
        
        nextVC.touristLocationNameTxt = selectedPath;
    }
}


@end
