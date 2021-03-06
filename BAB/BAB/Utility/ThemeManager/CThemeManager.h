//
//  CThemeManager.h
//  BAB
//
//  Created by GaoAng on 2017/2/23.
//  Copyright © 2017年 selfcom. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    theme_defalut,
    theme_white,
    theme_black,

    theme_other,
}ThemeType;

#define ThemeManager  [CThemeManager shareInstance]
#define themeTypeChange   @"AppThemeTypeChange"

@interface CThemeManager : NSObject
@property (nonatomic, assign) ThemeType currenType;
+ (CThemeManager*)shareInstance;

- (UIImage*)imageNamed:(NSString *)name;

//导航栏背景色。
-(UIColor*)navBarBackgroudColor;
-(UIColor*)navBarTitleColor;
-(UIColor*)navBarLeftButtonTitleColor;
-(UIColor*)navBarRightButtonTitleColor;

- (UIImage*)backGroundImage;

//背景色
- (UIColor*)backGroundColor;
-(UIColor*)backGroundSubColor;

- (UIColor*)buttonTitleColor;

- (UIColor*)mainTextColor;
- (UIFont*)mainTextFont;

- (UIColor*)subTextColor;
- (UIFont*)subTextFont;

- (UIColor*)DescripTextColor;
- (UIFont*)DescripTextFont;

@end
