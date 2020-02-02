//
//  UIBaseViewController.h
//  BAB
//
//  Created by GaoAng on 15/11/2.
//  Copyright © 2015年 selfcom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHCustomNavBar.h"
#import "CThemeManager.h"

@interface UIBaseViewController : UIViewController
/**
 *  自定义导航栏实现。
 *
 */
@property (nonatomic, strong) EHCustomNavBar *mNavBarView;
- (void)backBtnPressed:(UIButton *)sender;

- (void)addRightButton:(UIButton*)button;
-(void)hiddeBackButton;
-(void)setBackButtonImage:(UIImage*)image;
-(void)setBackButtonText:(NSString*)text;


- (void)updateTheme;
- (void)debugView:(UIView*)view;
@end
