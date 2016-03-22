#import "TouristLocationViewController.h"

// 1. Add an import
#import <EstimoteSDK/EstimoteSDK.h>



// 2. Add the ESTBeaconManagerDelegate protocol
@interface TouristLocationViewController () <ESTBeaconManagerDelegate>
// 3. Add properties to hold the beacon manager and the beacon region
@property (nonatomic) ESTBeaconManager *beaconManager;
@property (nonatomic) CLBeaconRegion *beaconRegion;
@property (nonatomic) NSDictionary *placesByBeacons;

@end

@implementation TouristLocationViewController
NSMutableArray *tableData;
NSString *categorySelected;
- (void)viewDidLoad {
    [super viewDidLoad];
    tableData = [[NSMutableArray alloc]init];
    // 4. Instantiate the beacon manager & set its delegate
    NSLog(@"in the view");
    self.beaconManager = [ESTBeaconManager new];
    
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
    
    
    self.beaconManager.delegate = self;
    // 5. Instantiate the beacon region
    self.beaconRegion = [[CLBeaconRegion alloc]
                         initWithProximityUUID:[[NSUUID alloc]
                                                initWithUUIDString:@"8492E75F-4FD6-469D-B132-043FE94921D8"]
                         identifier:@"ranged region"];
    // 6. We need to request this authorization for every beacon manager
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


- (void)beaconManager:(id)manager didRangeBeacons:(NSArray *)beacons
             inRegion:(CLBeaconRegion *)region {
    NSLog(@"RAN");
    
    
    //    NSString *deviceId = [region.proximityUUID UUIDString];
    //    NSString *deviceMajor = [region.major UUIDS
    //
    //    NSLog(deviceId);
    
    CLBeacon *nearestBeacon = beacons.firstObject;
    if (nearestBeacon) {
        NSArray *places = [self placesNearBeacon:nearestBeacon];
        // TODO: update the UI here
         NSLog(@"%@", places);
       
    }
  
    NSString *beaconUUID =[NSString stringWithFormat:@"%@%@",nearestBeacon.proximityUUID,nearestBeacon.minor];
    NSLog(beaconUUID);
    NSString *beaconMinor = [NSString stringWithFormat:@"%@",nearestBeacon.minor];
  
  
   NSString *beaconName = [self identifyBeacon:beaconMinor];
    //[self identifyBeacon:minor];
   

    
    if (![tableData containsObject:beaconName]) {
         [tableData addObject: beaconName];
    }
    
  
    
    [self.tableView reloadData];
   
    
    
    
    
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


- (void)beaconManager:(id)manager didFailWithError:(nonnull NSError *)error
{
    NSLog(@"error");
}


- (void)beaconManager:(id)manager didStartMonitoringForRegion:(nonnull CLBeaconRegion *)region
{
    NSLog(@"hello");
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
    //how can I get the text of the cell here?
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    selectedPath = cell.textLabel.text;
//    NSLog(selectedPath);
    
    NSString  *selectedPath = cell.textLabel.text;
    NSLog(selectedPath);
    
    NSLog(@"%ld", (long)indexPath.row); // you can see selected row number in your console;
    categorySelected = selectedPath;
    NSLog(@"decription is");
    NSLog(categorySelected);
    [self performSegueWithIdentifier:@"inside" sender:tableView];
  
    
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"inside"]) {
        ViewController *nextVC = (ViewController *)[segue destinationViewController];
        
        nextVC.insideCategory = categorySelected;
    }
}


@end

