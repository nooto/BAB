//
//  TWMessageViewCell.m
//  spud-ios
//
//  Created by Terry Worona on 8/15/13.
//  Copyright (c) 2013 Terry Worona. All rights reserved.
//

#import "TWMessageViewCell.h"
#import "CThemeManager.h"

@interface TWMessageViewCell()
@property (nonatomic, strong)  UILabel *timeLabel;;
@property (nonatomic, strong)  UIView *bgView;

@property (nonatomic, strong)  UILabel *pmje;
@property (nonatomic, strong)  UILabel *yll;
@property (nonatomic, strong)  UILabel *dqrq;
@property (nonatomic, strong)  UILabel *txrq;
@property (nonatomic, strong)  UILabel *tzts;

@property (nonatomic, strong)  UILabel *jxts;
@property (nonatomic, strong)  UILabel *txlx;
@property (nonatomic, strong)  UILabel *txje;
@end

@implementation TWMessageViewCell

-(id)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(MarginW(20), MarginH(10), SCREEN_W- MarginW(20)*4, 25)];
        [timeLabel setFont:Font13];
        [timeLabel setTextColor:[ThemeManager mainTextColor]];
        [self.contentView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(timeLabel.frame), CGRectGetWidth(frame) - 20, CGRectGetHeight(frame) - CGRectGetMaxY(timeLabel.frame))];
        bgView.center = CGPointMake(self.center.x-10, bgView.center.y);
        bgView.backgroundColor = [ThemeManager backGroundSubColor];
        bgView.layer.cornerRadius = 15.0f;
        [self.contentView addSubview:bgView];
        self.bgView = bgView;
        
//        //---1
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(MarginW(20), CGRectGetMinY(bgView.frame)+5, 60, 24)];
        [label setText:@"票面金额:"];
        label.textAlignment = NSTextAlignmentRight;
        [label setFont:Font13];
        [label setTextColor:[ThemeManager buttonTitleColor]];
        [self.contentView addSubview:label];

        UILabel *Textlabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame)+ 10, MarginH(20), SCREEN_W/2- MarginW(20), 25)];
        Textlabel.center = CGPointMake(Textlabel.center.x, label.center.y);
        [Textlabel setText:@"测试文字"];
        [Textlabel setFont:Font13];
        [Textlabel setTextColor:[ThemeManager buttonTitleColor]];
        [self.contentView addSubview:Textlabel];
        self.pmje = Textlabel;

        //----2
        label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(label.frame), CGRectGetMaxY(label.frame), CGRectGetWidth(label.frame), CGRectGetHeight(label.frame))];
        [label setText:@"月利率:"];
        label.textAlignment = NSTextAlignmentRight;
        [label setFont:Font13];
        [label setTextColor:[ThemeManager buttonTitleColor]];
        [self.contentView addSubview:label];
        
        Textlabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(Textlabel.frame), MarginH(20), CGRectGetWidth(Textlabel.frame), CGRectGetHeight(Textlabel.frame))];
        Textlabel.center = CGPointMake(Textlabel.center.x, label.center.y);
        [Textlabel setText:@"测试文字"];
        [Textlabel setFont:Font13];
        [Textlabel setTextColor:[ThemeManager buttonTitleColor]];
        [self.contentView addSubview:Textlabel];
        self.yll = Textlabel;
        
        //----3
        label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(label.frame), CGRectGetMaxY(label.frame), CGRectGetWidth(label.frame), CGRectGetHeight(label.frame))];
        [label setText:@"贴现日期:"];
        label.textAlignment = NSTextAlignmentRight;
        [label setFont:Font13];
        [label setTextColor:[ThemeManager buttonTitleColor]];
        [self.contentView addSubview:label];
        
        Textlabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(Textlabel.frame), MarginH(20), CGRectGetWidth(Textlabel.frame), CGRectGetHeight(Textlabel.frame))];
        Textlabel.center = CGPointMake(Textlabel.center.x, label.center.y);
        [Textlabel setText:@"测试文字"];
        [Textlabel setFont:Font13];
        [Textlabel setTextColor:[ThemeManager buttonTitleColor]];
        [self.contentView addSubview:Textlabel];
        self.txrq = Textlabel;

        //----4
        label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(label.frame), CGRectGetMaxY(label.frame), CGRectGetWidth(label.frame), CGRectGetHeight(label.frame))];
        [label setText:@"到期日期:"];
        label.textAlignment = NSTextAlignmentRight;
        [label setFont:Font13];
        [label setTextColor:[ThemeManager buttonTitleColor]];
        [self.contentView addSubview:label];
        
        Textlabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(Textlabel.frame), MarginH(20), CGRectGetWidth(Textlabel.frame), CGRectGetHeight(Textlabel.frame))];
        Textlabel.center = CGPointMake(Textlabel.center.x, label.center.y);
        [Textlabel setText:@"测试文字"];
        [Textlabel setFont:Font13];
        [Textlabel setTextColor:[ThemeManager buttonTitleColor]];
        [self.contentView addSubview:Textlabel];
        self.dqrq = Textlabel;

        //----5
        label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(label.frame), CGRectGetMaxY(label.frame), CGRectGetWidth(label.frame), CGRectGetHeight(label.frame))];
        [label setText:@"调整天数:"];
        label.textAlignment = NSTextAlignmentRight;
        [label setFont:Font13];
        [label setTextColor:[ThemeManager buttonTitleColor]];
        [self.contentView addSubview:label];
        
        Textlabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(Textlabel.frame), MarginH(20), CGRectGetWidth(Textlabel.frame), CGRectGetHeight(Textlabel.frame))];
        Textlabel.center = CGPointMake(Textlabel.center.x, label.center.y);
        [Textlabel setText:@"测试文字"];
        [Textlabel setFont:Font13];
        [Textlabel setTextColor:[ThemeManager buttonTitleColor]];
        [self.contentView addSubview:Textlabel];
        self.tzts = Textlabel;

        //----6
        label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(label.frame), CGRectGetMaxY(label.frame), CGRectGetWidth(label.frame), CGRectGetHeight(label.frame))];
        [label setText:@"计息天数:"];
        label.textAlignment = NSTextAlignmentRight;
        [label setFont:Font13];
        [label setTextColor:[ThemeManager buttonTitleColor]];
        [self.contentView addSubview:label];
        
        Textlabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(Textlabel.frame), MarginH(20), CGRectGetWidth(Textlabel.frame), CGRectGetHeight(Textlabel.frame))];
        Textlabel.center = CGPointMake(Textlabel.center.x, label.center.y);
        [Textlabel setText:@"测试文字"];
        [Textlabel setFont:Font13];
        [Textlabel setTextColor:[ThemeManager buttonTitleColor]];
        [self.contentView addSubview:Textlabel];
        self.jxts = Textlabel;
        
        //----7
        label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(label.frame), CGRectGetMaxY(label.frame), CGRectGetWidth(label.frame), CGRectGetHeight(label.frame))];
        [label setText:@"贴现利息:"];
        label.textAlignment = NSTextAlignmentRight;
        [label setFont:Font13];
        [label setTextColor:[ThemeManager buttonTitleColor]];
        [self.contentView addSubview:label];
        
        Textlabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(Textlabel.frame), MarginH(20), CGRectGetWidth(Textlabel.frame), CGRectGetHeight(Textlabel.frame))];
        Textlabel.center = CGPointMake(Textlabel.center.x, label.center.y);
        [Textlabel setText:@"测试文字"];
        [Textlabel setFont:Font13];
        [Textlabel setTextColor:[ThemeManager buttonTitleColor]];
        [self.contentView addSubview:Textlabel];
        self.txlx = Textlabel;
        
        //----8
        label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(label.frame), CGRectGetMaxY(label.frame), CGRectGetWidth(label.frame), CGRectGetHeight(label.frame))];
        [label setText:@"贴现金额:"];
        label.textAlignment = NSTextAlignmentRight;
        [label setFont:Font13];
        [label setTextColor:[ThemeManager buttonTitleColor]];
        [self.contentView addSubview:label];
        
        Textlabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(Textlabel.frame), MarginH(20), CGRectGetWidth(Textlabel.frame), CGRectGetHeight(Textlabel.frame))];
        Textlabel.center = CGPointMake(Textlabel.center.x, label.center.y);
        [Textlabel setText:@"测试文字"];
        [Textlabel setFont:Font13];
        [Textlabel setTextColor:[ThemeManager buttonTitleColor]];
        [self.contentView addSubview:Textlabel];
        self.txje = Textlabel;
    }
    return self;
}
// Nothing to do here

-(void)setMCurBabData:(CBABData *)data{
    _mCurBabData = data;
    
    [self.timeLabel setText:data.jssj];
    [self.pmje setText:[NSString stringWithFormat:@"%@万元",data.pmje]];
    [self.yll setText:[NSString stringWithFormat:@"%@‰",data.yll]];
    [self.txrq setText:data.txrqstr];
    [self.dqrq setText:data.dqrqstr];
    [self.tzts setText:data.tzts? [NSString stringWithFormat:@"%@天",data.tzts]: @"无"];
    
    [self.jxts setText:[NSString stringWithFormat:@"%@ 天",data.jxts]];
    [self.txlx setText:[NSString stringWithFormat:@"%@ 元",data.txlx]];
    [self.txje setText:[NSString stringWithFormat:@"%@ 元",data.txje]];
}

@end
