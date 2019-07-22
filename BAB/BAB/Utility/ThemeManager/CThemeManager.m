//
//  CThemeManager.m
//  BAB
//
//  Created by GaoAng on 2017/2/23.
//  Copyright © 2017年 selfcom. All rights reserved.
//

#import "CThemeManager.h"
#import "Font_Color.h"
#import "Utility.h"

#define Color_Back_Ground       ColorFromHex(0xf5f5f5)
#define Color_Main                          ColorFromHex(0xEC6500)
@implementation CThemeManager
__strong static CThemeManager* sharedInstance = nil;

+(CThemeManager*)shareInstance{
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(id)init{
    if (self = [super init]) {
        self.currenType = theme_defalut;
    }
    return self;
}

-(void)setCurrenType:(ThemeType)currenType{
    if (currenType == _currenType) {
        return;
    }

    if (currenType >= theme_other) {
        _currenType = theme_defalut;
        NSLog(@"主题设置超标。。。");
    }
    else{
        _currenType = currenType;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:themeTypeChange object:nil];
}

-(UIImage*)imageNamed:(NSString *)name{
    NSString *imageName = name;
    switch (self.currenType) {
        case theme_white:{
            imageName = [NSString stringWithFormat:@"white_%@",name];
        }
            break;
        case theme_black:{
            imageName = [NSString stringWithFormat:@"black_%@",name];
        }
            break;

        default:
            break;
    }

    return [UIImage imageNamed:imageName];
}
    //背景色
-(UIColor*)backGroundSubColor{
    switch (self.currenType) {
        case theme_defalut:
            return Color_Back_Ground;
            break;

        case theme_white:{
            return Color_black_10;
        }
            break;
        case theme_black:{
            return Color_Back_Ground;
        }
            break;

        default:
            break;
    }

    return Color_Back_Ground;
}
    //背景色
-(UIColor*)backGroundColor{
    switch (self.currenType) {
        case theme_defalut:
            return Color_Back_Ground;
            break;

        case theme_white:{
            return Color_Back_Ground;
        }
            break;
        case theme_black:{
            return Color_Back_Ground;
        }
            break;

        default:
            break;
    }

    return Color_Back_Ground;
}
#pragma mark - 导航栏颜色配置。
//导航栏背景色。
-(UIColor*)navBarBackgroudColor{
    switch (self.currenType) {
        case theme_defalut:
            return [UIColor colorWithWhite:255/255 alpha:0.1f];
            break;

        case theme_white:{
            return Color_Main;
        }
            break;
        case theme_black:{
            return Color_Main;
        }
            break;

        default:
            break;
    }

    return Color_Back_Ground;
}
-(UIColor*)navBarTitleColor{
    switch (self.currenType) {
        case theme_defalut:
            return Color_white_100;
            break;

        case theme_white:{
            return Color_white_100;
        }
            break;
        case theme_black:{
            return Color_Back_Ground;
        }
            break;

        default:
            break;
    }

    return Color_Back_Ground;
}
-(UIColor*)navBarLeftButtonTitleColor{
    switch (self.currenType) {
        case theme_defalut:
            return Color_white_80;
            break;

        case theme_white:{
            return Color_white_80;
        }
            break;
        case theme_black:{
            return Color_Back_Ground;
        }
            break;

        default:
            break;
    }

    return Color_Back_Ground;
}
-(UIColor*)navBarRightButtonTitleColor{
    switch (self.currenType) {
        case theme_defalut:
            return Color_white_80;
            break;

        case theme_white:{
            return Color_white_80;
        }
            break;
        case theme_black:{
            return Color_Back_Ground;
        }
            break;

        default:
            break;
    }

    return Color_Back_Ground;
}

#pragma mark ---====


-(UIImage*)backGroundImage{
    switch (self.currenType) {
        case theme_white:{
            return [Utility imageFromColor:Color_Back_Ground withSize:CGSizeMake(SCREEN_W, SCREEN_H)];
        }
            break;
        case theme_black:{
            return [UIImage imageNamed:@"bg"];
        }
            break;

        default:
            break;
    }
    return [UIImage imageNamed:@"bg"];
}

- (UIColor*)mainTextColor{
    return [UIColor blackColor];

    switch (self.currenType) {
        case theme_white:{
            return [UIColor blackColor];
        }
            break;
        case theme_black:{
            return Color_black_80;
        }
            break;

        default:
            break;
    }
    return Color_white_80;
}

- (UIFont*)mainTextFont{
    return [UIFont systemFontOfSize:15];
}


-(UIColor*)buttonTitleColor{
    switch (self.currenType) {
        case theme_white:{
            return Color_black_60;
        }
            break;
        case theme_black:{
            return Color_black_60;
        }
            break;

        default:
            break;
    }
    return Color_black_60;
}

- (UIColor*)subTextColor{
    switch (self.currenType) {
        case theme_white:{
            return Color_white_60;
        }
            break;
        case theme_black:{
            return Color_black_60;
        }
            break;

        default:
            break;
    }
    return Color_white_60;
}

- (UIFont*)subTextFont{
    return [UIFont systemFontOfSize:13];
}


- (UIColor*)DescripTextColor{
    switch (self.currenType) {
        case theme_white:{
            return Color_white_40;
        }
            break;
        case theme_black:{
            return Color_black_40;
        }
            break;

        default:
            break;
    }
    return Color_white_40;
}


- (UIFont*)DescripTextFont{
    return [UIFont systemFontOfSize:11];
}



@end
