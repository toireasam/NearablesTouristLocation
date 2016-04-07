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
    if([identifier  isEqual: @"66e0c67afa889a0b"])
    {
        return @"The Scream";
    }
    
    else if([identifier  isEqual: @"2d0159fcfa96b7b3"])
    {
        return @"Guernica";
    }
    else if([identifier  isEqual: @"d082874074797782"])
    {
        return @"Ulster museum";
    }
    else if([identifier  isEqual: @"0d7f92edbe655539"])
    {
        return @"Starry Night";
    }
    else if([identifier  isEqual: @"f220399a8e348d6e"])
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
    if([identifier  isEqual: @"66e0c67afa889a0b"])
    {
        return @"museum";
    }
    
    else if([identifier  isEqual: @"2d0159fcfa96b7b3"])
    {
        return @"museum";
    }
    else if([identifier  isEqual: @"d082874074797782"])
    {
        return @"museum";
    }
    else if([identifier  isEqual: @"0d7f92edbe655539"])
    {
        return @"museum";
    }
    else if([identifier  isEqual: @"f220399a8e348d6e"])
    {
        return @"museum";
    }
    else
    {
        return @"museum";
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
