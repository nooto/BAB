//
//  UIBaseViewController.m
//  BAB
//
//  Created by GaoAng on 15/11/2.
//  Copyright © 2015年 selfcom. All rights reserved.
//

#import "UIBaseViewController.h"
#import "EHCustomNavBar.h"
@implementation UIBaseViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview:self.mNavBarView];
    self.navigationController.navigationBar.hidden = YES;
    
//    UIImageView *mbgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    [mbgView setImage:[UIImage imageNamed:@"bg"]];
//    self.view = mbgView;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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

@end
