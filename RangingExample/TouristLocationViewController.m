#import "TouristLocationViewController.h"

// 1. Add an import
#import <EstimoteSDK/EstimoteSDK.h>



// 2. Add the ESTBeaconManagerDelegate protocol
@interface TouristLocationViewController () <ESTBeaconManagerDelegate>

@property (nonatomic) ESTBeaconManager *beaconManager;
@property (nonatomic) CLBeaconRegion *beaconRegion;
@property (nonatomic) NSDictionary *placesByBeacons;

@end

@implementation TouristLocationViewController
NSMutableArray *tableData;
NSString *touristLocationOutsideSelected;

- (void)viewDidLoad {
    [super viewDidLoad];
    tableData = [[NSMutableArray alloc]init];

    self.beaconManager = [ESTBeaconManager new];
    
    [self setBeaconPlaces];
    
    self.beaconManager.delegate = self;
    self.beaconRegion = [[CLBeaconRegion alloc]
                         initWithProximityUUID:[[NSUUID alloc]
                                                initWithUUIDString:@"8492E75F-4FD6-469D-B132-043FE94921D8"]
                         identifier:@"ranged region"];
    [self.beaconManager requestAlwaysAuthorization];
    
    
    
    
}

-(void)setBeaconPlaces
{
    self.placesByBeacons = @{
                             @"437:10261": @{
                                     @"cup": @50, // read as: it's 50 meters from
                                     // "Heavenly Sandwiches" to the beacon with
                                     // major 6574 and minor 54631
                                     @"Green & Green Salads": @150,
                                     @"Mini Panini": @325
                                     },
                             @"10108:11891": @{
                                     @"urban": @25000,
                                     @"seat": @1100,
                                     @"stickers": @23330
                                     }
                             
                             };
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.beaconManager stopRangingBeaconsInRegion:self.beaconRegion];
}

-(void)getBeaconPlaces:(CLBeacon *)beacon
{
    if (beacon) {
        NSArray *places = [self placesNearBeacon:beacon];
        // TODO: update the UI here
        NSLog(@"%@", places);
        
    }
}

-(void)displayBeaconsForCategories:(NSString *)beaconMinor and:(NSString *)beaconName
{
    
    // should get the category from parse and check if it's on
    NSString *beaconCategory = [self getBeaconCategory:beaconMinor];
    
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    
    if (![tableData containsObject:beaconName] && [[standardDefaults stringForKey:beaconCategory] isEqual: @"On"]) {
        [tableData addObject: beaconName];
    }
    
    
    
    [self.tableView reloadData];
}


- (void)beaconManager:(id)manager didRangeBeacons:(NSArray *)beacons
             inRegion:(CLBeaconRegion *)region {
   
  
  CLBeacon *nearestBeacon = beacons.firstObject;
    
        [self getBeaconPlaces:nearestBeacon];
    

    NSString *beaconMinor = [NSString stringWithFormat:@"%@",nearestBeacon.minor];
    NSString *beaconName = [self identifyBeacon:beaconMinor];

    [self displayBeaconsForCategories:beaconMinor and:beaconName];
   
    
    
    
    
}

- (NSString *)identifyBeacon:(NSString *)minor
{
    if([minor isEqualToString:@"10261"])
    {
        return @"Ulster Museum";
    }
    
    else if([minor isEqualToString:@"17204"])
    {
        return @"Belfast City Hall";
    }
    
    else
    {
        NSLog(@"%d", [minor integerValue]);
        return @"unknown";
    }
}




- (NSString *)getBeaconCategory:(NSString *)minor
{
    if([minor isEqualToString:@"10261"])
    {
        return @"museumSwitchKey";
    }
    
    else if([minor isEqualToString:@"17204"])
    {
        return @"cityhallSwitchKey";
    }
    
    else
    {
        NSLog(@"%d", [minor integerValue]);
        return @"unknown";
    }
}


- (void)beaconManager:(id)manager didFailWithError:(nonnull NSError *)error
{
    NSLog(@"error");
}


- (NSArray *)placesNearBeacon:(CLBeacon *)beacon {
    NSString *beaconKey = [NSString stringWithFormat:@"%@:%@",
                           beacon.major, beacon.minor];
    NSDictionary *places = [self.placesByBeacons objectForKey:beaconKey];
    NSArray *sortedPlaces = [places keysSortedByValueUsingComparator:
                             ^NSComparisonResult(id obj1, id obj2) {
                                 return [obj1 compare:obj2];
                             }];
    return sortedPlaces;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString  *selectedPath = cell.textLabel.text;
    touristLocationOutsideSelected = selectedPath;
    [self performSegueWithIdentifier:@"insideTouristAttraction" sender:tableView];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"insideTouristAttraction"]) {
        ViewController *nextVC = (ViewController *)[segue destinationViewController];
        
        nextVC.insideCategory = touristLocationOutsideSelected;
    }
}


@end

