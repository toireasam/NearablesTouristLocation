//
//  NearablesParseManager.m
//  NearablesTouristLocationApplication
//
//  Created by Toireasa Moley on 07/04/2016.
//  Copyright © 2016 Estimote. All rights reserved.
//

#import "NearablesParseManager.h"

@implementation NearablesParseManager
NSDictionary *placesByBeacons;
NSArray *places;

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

-(void)setPlacesbyNearable
{
    placesByBeacons = @{
                        @"f220399a8e348d6e": @{
                                @"0": @0,
                                @"500": @500,
                                },
                        @"0d7f92edbe655539": @{
                                @"0": @0,
                                @"500": @500
                                }
                        };
    
}

-(NSArray *)getPlacesByNearable:(ESTNearable *)nearestBeacon
{
    if (nearestBeacon) {
        places = [self placesNearBeacon:nearestBeacon];
    }
    return places;
}


- (NSString *)identifierNearablType:(NSString *)identifier
{
    if([identifier  isEqual: @"6e3972e4eacf21c7"])
    {
        return @"The Scream";
    }
    
    else if([identifier  isEqual: @"71fe18a348f33406"])
    {
        return @"Guernica";
    }
    else if([identifier  isEqual: @"5d80738722997275"])
    {
        return @"Starry Night";
    }
    else if([identifier  isEqual: @"c2aab0fa802b664b"])
    {
        return @"The Mona Lisa";
    }
    else
    {
        return @"unknown";
    }
}


- (NSString *)identifierNearablCategoru:(NSString *)identifier
{
    if([identifier  isEqual: @"6e3972e4eacf21c7"])
    {
        return @"museum";
    }
    
    else if([identifier  isEqual: @"71fe18a348f33406"])
    {
        return @"museum";
    }
    else if([identifier  isEqual: @"5d80738722997275"])
    {
        return @"museum";
    }
    else if([identifier  isEqual: @"c2aab0fa802b664b"])
    {
        return @"museum";
    }
    else if([identifier  isEqual: @"5583e7200f965302"])
    {
        return @"cityhall";
    }
    else if([identifier  isEqual: @"dd9221e73d2f7685"])
    {
        return @"cityhall";
    }
    else if([identifier  isEqual: @"c578903794d5544c"])
    {
        return @"cityhall";
    }
//    else if([identifier  isEqual: @"f16239a0d1b611d6"])
//    {
//        return @"notset";
//    }
//    else if([identifier  isEqual: @"f220399a8e348d6e"])
//    {
//        return @"notset";
//    }
//    else if([identifier  isEqual: @"6fbc24ddb773152e"])
//    {
//        return @"notset";
//    }
//    else if([identifier  isEqual: @"99973753c6ee560a"])
//    {
//        return @"notset";
//    }
    else
    {
        return @"unknown";
    }
}

- (NSArray *)placesNearBeacon:(ESTNearable *)beacon {
    NSString *beaconKey = beacon.identifier;
    NSDictionary *places = [placesByBeacons objectForKey:beaconKey];
    NSArray *sortedPlaces = [places keysSortedByValueUsingComparator:
                             ^NSComparisonResult(id obj1, id obj2) {
                                 return [obj1 compare:obj2];
                             }];
    return sortedPlaces;
}



@end
