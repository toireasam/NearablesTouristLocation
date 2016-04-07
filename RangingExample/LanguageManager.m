//
//  LanguageManager.m
//  NearablesTouristLocationApplication
//
//  Created by Toireasa Moley on 07/04/2016.
//  Copyright © 2016 Estimote. All rights reserved.
//

#import "LanguageManager.h"

@implementation LanguageManager
NSString *currentLanguage;
NSString *swedish = @"sv-GB";

- (id)init
{
    self = [super init];
    if (self)
    {
        
        currentLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
        
    }
    return self;
}

-(NSString *)presentCurrentLanguage
{
    if([currentLanguage isEqualToString:swedish])
    {
        return @"TouristLocationsSpanish";
    }
    else
    {
        return @"TouristLocations";
    }
}
@end
