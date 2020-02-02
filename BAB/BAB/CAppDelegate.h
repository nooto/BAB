//
//  CAppDelegate.h
//  BAB
//
//  Created by GaoAng on 14-4-8.
//  Copyright (c) 2014年 selfcom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BABNavigationController.h"

//#define ROOTNAV ((CAppDelegate *)([UIApplication sharedApplication].delegate)).rootNav


@interface CAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) BABNavigationController *rootNav;
@end
