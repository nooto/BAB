//
//  EHCustomNavBar.m
//  EHouse
//
//  Created by GaoAng on 15/9/16.
//  Copyright (c) 2015年 wondershare. All rights reserved.
//

#import "EHCustomNavBar.h"
#import "UILabel+AutoSize.h"
#import "CThemeManager.h"
//#import "UtilityHelper.h"
@interface EHCustomNavBar ()
//@property (nonatomic, assign) id<EHSceneTitleViewDelegate> m_delegate;

@end
@implementation EHCustomNavBar

-(id)initWithdelegate:(id)delegate{
    if (self = [super initWithFrame:CGRectMake(0, 0, SCREEN_W, NAVBAR_H)]) {
        self.m_delegate = delegate;
        [self setUpView];
    }
    return self;
}

-(void)setUpView{
//    self.backgroundColor = [UIColor redColor];
    _mImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [_mImageView setImage:[Utility imageFromColor:[ThemeManager navBarBackgroudColor] withSize:CGSizeMake(SCREEN_W, NAVBAR_H)]];
    [self addSubview:_mImageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame) - 20)];
    [self addSubview:titleLabel];
    titleLabel.center = CGPointMake(SCREEN_W/2, CGRectGetHeight(self.bounds)/2 + 10);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = Font17Bold;
    titleLabel.textColor = [ThemeManager navBarTitleColor];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
//    titleLabel.text = [RootViewController getSceneTitle];
    self.mTextLabel = titleLabel;
    
    EHNavButton* leftButton =  [[EHNavButton alloc] initWithFrame:CGRectMake(0, 0, NAVBAR_H*2, NAVBAR_H)];
    [leftButton setImage:[UIImage imageNamed:@"btn_login_back_normal"] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"btn_login_back_pressed"] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(leftButonAction:) forControlEvents:UIControlEventTouchUpInside];
    leftButton.titleLabel.font = _mTextLabel.font;
    [leftButton setTitleColor:[ThemeManager navBarLeftButtonTitleColor] forState:UIControlStateNormal];
    [self addSubview:leftButton];
    self.mLeftButton = leftButton;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    [self.mTextLabel setText:title];
    self.mTextLabel.center = CGPointMake(SCREEN_W/2, CGRectGetHeight(self.bounds)/2 + 10);
}
-(void)leftButonAction:(UIButton*)sender{
    if (_m_delegate && [_m_delegate respondsToSelector:@selector(backBtnPressed:)]) {
        [_m_delegate backBtnPressed:sender];
    }
}

@end
