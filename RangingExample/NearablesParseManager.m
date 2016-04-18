//  NearablesParseManager.m

#import "NearablesParseManager.h"

@implementation NearablesParseManager

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (NSString *)getArtefactName:(NSString *)identifier
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
    else if([identifier  isEqual: @"5583e7200f965302"])
    {
        return @"Welcome info - city hall";
    }
    else
    {
        return @"unknown";
    }
}

- (NSString *)getArtefactCategory:(NSString *)identifier
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
    else
    {
        return @"unknown";
    }
}

@end
