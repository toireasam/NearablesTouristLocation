//
//  ViewController.h
//  RangingExample
//
//  Created by Marcin Klimek on 24/12/14.
//  Copyright (c) 2014 Estimote. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ViewController : UIViewController

+(void)RecieveParseDetails:(NSMutableArray *)locationNameArray andTheIdentifier:(NSMutableArray *)rssiArray;
-(void)checkIn;
@end

