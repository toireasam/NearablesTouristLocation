//  TouristLocationViewController.h

#import "InsideAttractionViewController.h"

@interface TouristLocationViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

- (void)displayBeaconsForCategories:(CLBeacon *)nearestBeacon;

@end
