//
//  BeaconManager.m
//  NearablesTouristLocationApplication
//
//  Created by Toireasa Moley on 07/04/2016.
//  Copyright © 2016 Estimote. All rights reserved.
//

#import "BeaconParseManager.h"
#import <EstimoteSDK/EstimoteSDK.h>

@implementation BeaconParseManager
@synthesize placesByBeacons;

- (id)init
{
    self = [super init];
    if (self)
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
    return self;
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

-(void)getBeaconPlaces:(CLBeacon *)beacon
{
    if (beacon) {
        NSArray *places = [self placesNearBeacon:beacon];
    }
}

@end
