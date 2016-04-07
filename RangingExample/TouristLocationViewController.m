#import "TouristLocationViewController.h"
#import <EstimoteSDK/EstimoteSDK.h>
#import "BeaconParseManager.h"


@interface TouristLocationViewController () <ESTBeaconManagerDelegate>

@property (nonatomic) ESTBeaconManager *beaconManager;
@property (nonatomic) CLBeaconRegion *beaconRegion;

@end

@implementation TouristLocationViewController

NSMutableArray *tableData;
NSString *touristLocationOutsideSelected;
BeaconParseManager *beaconParseManager;


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
        [tableData addObject: beaconName];
    }
    
    [self.tableView reloadData];
}

- (void)beaconManager:(id)manager didRangeBeacons:(NSArray *)beacons
             inRegion:(CLBeaconRegion *)region {
    
  CLBeacon *nearestBeacon = beacons.firstObject;
    
  [beaconParseManager getBeaconPlaces:nearestBeacon];
    
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

