//
//  CAppDelegate.m
//  BAB
//
//  Created by GaoAng on 14-4-8.
//  Copyright (c) 2014年 selfcom. All rights reserved.
//

#import "CAppDelegate.h"
#import "CMainViewController.h"
#import "BABNavigationController.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
//#import "WeiboApi.h"
#import "WeiboSDK.h"
#import <QZoneConnection/ISSQZoneApp.h>
#import "WXApi.h"
//#import <i>
@implementation CAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor clearColor];
	CMainViewController *listViewController = [[CMainViewController alloc] init];
    BABNavigationController *navigationController = [[BABNavigationController alloc] initWithRootViewController:listViewController];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    
    
    [self setupRemoteNotification];
    [self initShareSDK];
    UIDevice *device = [UIDevice currentDevice];
    float sysVersion = [device.systemVersion floatValue];
    if (sysVersion >= 9.0f) {
        NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:4];
        UIApplicationShortcutItem * item = [[UIApplicationShortcutItem alloc]initWithType:[NSString stringWithFormat:@"%d",1] localizedTitle:@"fadsfasdfadsfadsafdaf" localizedSubtitle:nil icon:
                                            [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd] userInfo:nil];
        
        [arr addObject:item];
        
        UIApplicationShortcutItem * item1 = [[UIApplicationShortcutItem alloc]initWithType:[NSString stringWithFormat:@"%d",1] localizedTitle:@"fadsfasdfadsfadsafdaf" localizedSubtitle:nil icon:
                                             [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd] userInfo:nil];
        
        [arr addObject:item1];
        
        UIApplicationShortcutItem * item2 = [[UIApplicationShortcutItem alloc]initWithType:[NSString stringWithFormat:@"%d",1] localizedTitle:@"fadsfasdfadsfadsafdaf" localizedSubtitle:nil icon:
                                             [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd] userInfo:nil];
        
        [arr addObject:item2];
        
        UIApplicationShortcutItem * item3 = [[UIApplicationShortcutItem alloc]initWithType:[NSString stringWithFormat:@"%d",1] localizedTitle:@"fadsfasdfadsfadsafdaf" localizedSubtitle:nil icon:
                                             [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd] userInfo:nil];
        
        [arr addObject:item3];
        
        UIApplicationShortcutItem * item4 = [[UIApplicationShortcutItem alloc]initWithType:[NSString stringWithFormat:@"%d",1] localizedTitle:@"fadsfasdfadsfadsafdaf" localizedSubtitle:nil icon:
                                             [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd] userInfo:nil];
        
        [arr addObject:item4];
        
        [UIApplication sharedApplication].shortcutItems = arr;
    }
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setHidden:YES];
//    [[UINavigationBar appearance] setBackgroundImage:[self imageFromColor:[UIColor colorWithWhite:255/255 alpha:0.1f] withSize:self.window.frame.size] forBarPosition:UIBarPositionTop barMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setBackgroundColor:[UIColor blackColor]];
    return YES;
}

- (UIImage *)imageFromColor:(UIColor *)color withSize:(CGSize)size{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context) {
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextFillRect(context, rect);
    }
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

-(void)initShareSDK{
    //注册 ShareSDK
    [ShareSDK registerApp:@"c25ece047a3c"];
    //    [ShareSDK ssoEnabled:YES];
    
    //    //添加新浪微博应用  redirectUri 需要和opnen.sina.com 中 应用信息-高级信息-授权回调页面：（URL）  一致。
    [ShareSDK connectSinaWeiboWithAppKey:@""
                               appSecret:@""
                             redirectUri:@"http://www.spotmau.cn/oauth/sinawb_callback/oauth/sinawb_callback"
                             weiboSDKCls:[WeiboSDK class]];
    
    //qq分享
    [ShareSDK connectQQWithQZoneAppKey:@"1104933944" //1104933944    KEY:F4NASIB9fypB8jpS
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    //QQ 登录。
    [ShareSDK connectQZoneWithAppKey:@"1104933944"
                           appSecret:@"F4NASIB9fypB8jpS"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    //以前申请的QQ空间具有网页权限，可以进行网页授权。新申请的QQ空间应用是不具有网页授权权限，只能是SSO授权。
    id<ISSQZoneApp> app =(id<ISSQZoneApp>)[ShareSDK getClientWithType:ShareTypeQQSpace];
    [app setIsAllowWebAuthorize:YES];
    
    /**
     连接微信应用以使用相关功能，此应用需要引用WeChatConnection.framework和微信官方SDK
     http://open.weixin.qq.com上注册应用，并将相关信息填写以下字段
     **/
    [ShareSDK connectWeChatWithAppId:@""
                           appSecret:@""
                           wechatCls:[WXApi class]];
}

/**
 *  远程推送消息相关
 */
- (void)setupRemoteNotification{
    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    if (badge > 0) {
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    }
    
    NSString *token = [Utility getApnsTokenStrored];
    if (token.length <= 0) {
        //    DDLogInfo(@"Registering for push notifications...");
        if ([[UIApplication sharedApplication] respondsToSelector: @selector(registerForRemoteNotifications)]) {
            // iOS 8
            UIUserNotificationType notificationTypes =
            UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
            UIUserNotificationSettings *userNotificationSettings =
            [UIUserNotificationSettings settingsForTypes: notificationTypes categories: nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings: userNotificationSettings];
            
            [[UIApplication sharedApplication] registerForRemoteNotifications];
        }else{
            // iOS 8 以下系统
            UIRemoteNotificationType remoteNotificationType =
            UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound;
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes: remoteNotificationType];
        }
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString *deviceTokenString = [NSString stringWithFormat: @"%@", deviceToken];
    [Utility saveApnsToken:deviceTokenString];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
