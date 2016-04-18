
//  NearablesParseManager.h

#import <Foundation/Foundation.h>
#import <EstimoteSDK/EstimoteSDK.h>

@interface NearablesParseManager : NSObject

- (NSString *)getArtefactName:(NSString *)identifier;
- (NSString *)getArtefactCategory:(NSString *)identifier;

@end
