//
//  BeaconManager.h
//  NearablesTouristLocationApplication
//
//  Created by Toireasa Moley on 07/04/2016.
//  Copyright © 2016 Estimote. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <EstimoteSDK/EstimoteSDK.h>


@interface BeaconParseManager : NSObject <ESTBeaconManagerDelegate>
- (NSString *)getBeaconCategory:(NSString *)minor;
- (NSString *)identifyBeacon:(NSString *)minor;
@property (nonatomic) NSDictionary *placesByBeacons;
-(void)getBeaconPlaces:(CLBeacon *)beacon;
@end
