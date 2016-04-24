//  TouristLocationViewController.m

#import "TouristLocationViewController.h"
#import <EstimoteSDK/EstimoteSDK.h>
#import "BeaconParseManager.h"
#import "TouristLocation.h"

@interface TouristLocationViewController () <ESTBeaconManagerDelegate>

@property (nonatomic) ESTBeaconManager *beaconManager;
@property (nonatomic) CLBeaconRegion *beaconRegion;

@end

@implementation TouristLocationViewController

NSMutableArray *tableData;
NSString *touristLocationOutsideSelected;
BeaconParseManager *beaconParseManager;
TouristLocation *touristLocation;

- (void)viewDidLoad {
    [super viewDidLoad];
    tableData = [[NSMutableArray alloc]init];
    beaconParseManager = [[BeaconParseManager alloc]init];
    
    self.beaconManager = [ESTBeaconManager new];
    self.beaconManager.delegate = self;
    self.beaconRegion = [[CLBeaconRegion alloc]
                         initWithProximityUUID:[[NSUUID alloc]
                                                initWithUUIDString:@"8492E75F-4FD6-469D-B132-043FE94921D8"]
                         identifier:@"ranged region"];
    [self.beaconManager requestAlwaysAuthorization];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.beaconManager stopRangingBeaconsInRegion:self.beaconRegion];
}

- (void)displayBeaconsForCategories:(CLBeacon *)nearestBeacon{
    
    NSString *beaconMinor = [NSString stringWithFormat:@"%@",nearestBeacon.minor];
    NSString *beaconName = [beaconParseManager identifyBeacon:beaconMinor];
    NSString *beaconCategory = [beaconParseManager getBeaconCategory:beaconMinor];
    
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    
    if (![tableData containsObject:beaconName] && [[standardDefaults stringForKey:beaconCategory] isEqual: @"On"]) {
        
        touristLocation = [[TouristLocation alloc]init];
        touristLocation.touristLocationName = beaconName;
        [tableData addObject: touristLocation.touristLocationName];
    }
    
    [self.tableView reloadData];
}

- (void)beaconManager:(id)manager didRangeBeacons:(NSArray *)beacons
             inRegion:(CLBeaconRegion *)region {
    
    CLBeacon *nearestBeacon = beacons.firstObject;
    
    [self displayBeaconsForCategories:nearestBeacon];
}

- (void)beaconManager:(id)manager didFailWithError:(nonnull NSError *)error
{
    NSLog(@"error");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"TableItemIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:18.0];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString  *selectedPath = cell.textLabel.text;
    touristLocation.touristLocationName = selectedPath;
    [self performSegueWithIdentifier:@"insideTouristAttractionScreen" sender:tableView];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"insideTouristAttractionScreen"]) {
        InsideAttractionViewController *nextVC = (InsideAttractionViewController *)[segue destinationViewController];
        
        nextVC.touristLocationName = touristLocation.touristLocationName;
    }
}

@end

