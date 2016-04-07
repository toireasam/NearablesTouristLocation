#import "ViewController.h"

@interface TouristLocationViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

- (void)displayBeaconsForCategories:(CLBeacon *)nearestBeacon;
- (void)beaconManager:(id)manager didRangeBeacons:(NSArray *)beacons;

@end
