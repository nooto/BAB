//
//  UIBaseViewController.m
//  BAB
//
//  Created by GaoAng on 15/11/2.
//  Copyright © 2015年 selfcom. All rights reserved.
//

#import "UIBaseViewController.h"
#import "EHCustomNavBar.h"
//#import "CThemeManager.h"

@implementation UIBaseViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview:self.mNavBarView];
    self.navigationController.navigationBar.hidden = YES;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTheme) name:themeTypeChange object:nil];
}

-(void)updateTheme{

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self.view bringSubviewToFront:self.mNavBarView];
}
-(void)setTitle:(NSString *)title{
    [super setTitle:title];
    [self.mNavBarView setTitle:title];
}

-(EHCustomNavBar*)mNavBarView{
    if (!_mNavBarView) {
        _mNavBarView = [[EHCustomNavBar alloc] initWithdelegate:self];
    }
    return _mNavBarView;
}

- (void)backBtnPressed:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addRightButton:(UIButton *)button{
    if (button) {
        [self.mNavBarView addSubview:button];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        button.titleLabel.font = self.mNavBarView.mTextLabel.font;
        button.center = CGPointMake(SCREEN_W - MarginW(20) - CGRectGetWidth(button.frame)/2, self.mNavBarView.mTextLabel.center.y);
    }
}

-(void)hiddeBackButton{
    self.mNavBarView.mLeftButton.hidden = YES;
}
-(void)setBackButtonImage:(UIImage *)image{
    [self.mNavBarView.mLeftButton setImage:image forState:UIControlStateNormal];
    [self.mNavBarView.mLeftButton setImage:image forState:UIControlStateHighlighted];
    [self.mNavBarView.mLeftButton setImage:image forState:UIControlStateSelected];
    [self.mNavBarView.mLeftButton setImage:image forState:UIControlStateDisabled];
}

-(void)setBackButtonText:(NSString *)text{
    [self.mNavBarView.mLeftButton setTitle:text forState:UIControlStateNormal];
}

- (void)debugView:(UIView*)view{
    view.layer.cornerRadius = 10;
    view.layer.borderColor = [UIColor redColor].CGColor;
    view.layer.borderWidth = 5.f;
}

@end
