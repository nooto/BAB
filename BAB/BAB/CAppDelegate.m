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
@implementation CAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
	CMainViewController *listViewController = [[CMainViewController alloc] initWithNibName:@"CMainViewController" bundle:[NSBundle mainBundle]];
    BABNavigationController *navigationController = [[BABNavigationController alloc] initWithRootViewController:listViewController];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setBackgroundImage:[self imageFromColor:[UIColor colorWithWhite:255/255 alpha:0.1f] withSize:self.window.frame.size] forBarPosition:UIBarPositionTop barMetrics:UIBarMetricsDefault];

//    [[UINavigationBar appearance] setBarTintColor:[UIColor clearColor]];
//    [[UINavigationBar appearance] setTintColor:[UIColor clearColor]];
//    [[UINavigationBar appearance] setBackgroundColor:[UIColor clearColor]];
    
//     UIImageView *imageView = (UIImageView *)[nav.navigationBar viewWithTag:100];
//    if (imageView == nil)
//    {
//        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top_bar"]];
//        [imageView setFrame:CGRectMake(0, -20, SCREEN_W, NAVBAR_H)];
//        [imageView setTag:100];
//        [nav.navigationBar insertSubview:imageView atIndex:0];
//    }
//    
//    if ([UINavigationBar instancesRespondToSelector:@selector(setShadowImage:)])
//    {
//        [[UINavigationBar appearance] setShadowImage:[EHCommonMethod imageFromColor:[UIColor clearColor] withSize:CGSizeMake(SCREEN_W, 1)]];
//    }

    
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
