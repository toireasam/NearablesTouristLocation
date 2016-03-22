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
- (void)viewDidLoad {
    [super viewDidLoad];
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
        NSLog(@"%@", places); // TODO: remove after implementing the UI
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



@end

