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
NSString *japanese = @"ja-GB";

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
        return @"TouristLocationsSwedish";
    }
    else if([currentLanguage isEqualToString:japanese])
    {
        return @"TouristLocationsJapanese";
    }
    else
    {
        return @"TouristLocations";
    }
}
@end
