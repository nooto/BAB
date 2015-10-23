
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "EHSysProperty.h"
#define APPDelegate ((AppDelegate *)([UIApplication sharedApplication].delegate))

#define APP_CORE_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define CURRENT_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define SYSTEMVerSion [EHSysProperty getSystemVersion]
//#define ColorFromString(x) [EHSysProperty colorFromColorString:x]
#define ColorFromHex(x) [UIColor colorWithRed:(((x>>16)&0xFF) / 255.0f) green:(((x>>8)&0xFF) / 255.0f) blue:(((x)&0xFF) / 255.0f) alpha:1.0]
#define ColorFromHexRGBA(x) [UIColor colorWithRed:(((x>>24)&0xFF) / 255.0f) green:(((x>>16)&0xFF) / 255.0f) blue:(((x>>8)&0xFF) / 255.0f) alpha:(((x)&0xFF) / 255.0f)]


typedef enum
{
    IPHONE,
    IPAD
} DEVICETYPE;

@interface EHSysProperty : NSObject

+ (float)getSystemVersion;
+ (CGSize)getScreenSize;
+ (float)getNavBarHight;

+ (void)getCurrentLocale;
+ (void)getCurrentLocaleLanguage;
+ (void)getCurrentLanguage;

//+ (void)checkAppUpdateWithMiniVersion:(NSString *)iosMiniVersion;

//+ (UIColor *) colorFromColorString:(NSString *)colorString;
+ (UIColor *)colorFromColorString:(NSString *)colorString alpha:(CGFloat)alpha;
+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

+ (CGFloat)adjustGapW:(CGFloat)gap;
+ (CGFloat)adjustGapH:(CGFloat)gap;
+ (NSString *)getHardWardVersion;

@end
