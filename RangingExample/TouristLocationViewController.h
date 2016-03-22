#import "ViewController.h"

@interface TouristLocationViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

- (NSString *)identifyBeacon:(NSString *)minor;
@end
