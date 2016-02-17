//
//  Parse.h
//  RangingExample
//
//  Created by Toireasa Moley on 16/02/2016.
//  Copyright © 2016 Estimote. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@interface ParseCheck : PFObject
+(void)CheckRSSIInParse:(NSString *)RSSI;

@end
