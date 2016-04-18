//  User.h

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (weak,nonatomic) NSString *username;
@property (assign) BOOL isLoggedIn;

@end
