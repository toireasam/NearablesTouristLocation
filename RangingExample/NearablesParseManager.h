//
//  NearablesParseManager.h
//  NearablesTouristLocationApplication
//
//  Created by Toireasa Moley on 07/04/2016.
//  Copyright © 2016 Estimote. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EstimoteSDK/EstimoteSDK.h>

@interface NearablesParseManager : NSObject
- (NSString *)identifierNearablType:(NSString *)identifier;
-(NSArray *)getPlacesByNearable:(ESTNearable *)nearestBeacon;
-(void)setPlacesbyNearable;
- (NSString *)identifierNearablCategoru:(NSString *)identifier;
@end
