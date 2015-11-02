//
//  TWMessageViewCell.m
//  spud-ios
//
//  Created by Terry Worona on 8/15/13.
//  Copyright (c) 2013 Terry Worona. All rights reserved.
//

#import "TWMessageViewCell.h"
@interface TWMessageViewCell()
@property (nonatomic, strong)  UILabel *pmje;
@property (nonatomic, strong)  UILabel *yll;
@property (nonatomic, strong)  UILabel *dqrq;
@property (nonatomic, strong)  UILabel *txrq;
@property (nonatomic, strong)  UILabel *tzts;

@property (nonatomic, strong)  UILabel *jxts;
@property (nonatomic, strong)  UILabel *txlx;
@property (nonatomic, strong)  UILabel *txje;

@property (nonatomic, strong)  UILabel *jssj;

@property (nonatomic, strong)  UIView *bgView;
@end

@implementation TWMessageViewCell

-(id)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
        bgView.backgroundColor = Color_gray_343F52;
        bgView.layer.cornerRadius = 15.0f;
//        bgView.layer.borderWidth = 1.0f;
//        bgView.layer.borderColor = Color_greed_normal.CGColor;
        [self.contentView addSubview:bgView];
        
        //---1
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(MarginW(20), MarginH(20), SCREEN_W/2- MarginW(20), 25)];
        [label setText:@"票面金额"];
        [label setFont:Font14];
        [label setTextColor:Color_white_80];
        [self.contentView addSubview:label];
        
        UILabel *Textlabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_W/2, MarginH(20), SCREEN_W/2- MarginW(20), 25)];
        Textlabel.center = CGPointMake(Textlabel.center.x, label.center.y);
        [Textlabel setText:@"测试文字"];
        [Textlabel setFont:Font14];
        [Textlabel setTextColor:Color_white_50];
        [self.contentView addSubview:Textlabel];
        self.pmje = Textlabel;

        //----2
        label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(label.frame), CGRectGetMaxY(label.frame), CGRectGetWidth(label.frame), CGRectGetHeight(label.frame))];
        [label setText:@"月利率"];
        [label setFont:Font14];
        [label setTextColor:Color_white_80];
        [self.contentView addSubview:label];
        
        Textlabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(Textlabel.frame), MarginH(20), CGRectGetWidth(Textlabel.frame), CGRectGetHeight(Textlabel.frame))];
        Textlabel.center = CGPointMake(Textlabel.center.x, label.center.y);
        [Textlabel setText:@"测试文字"];
        [Textlabel setFont:Font14];
        [Textlabel setTextColor:Color_white_50];
        [self.contentView addSubview:Textlabel];
        self.yll = Textlabel;
        
        //----3
        label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(label.frame), CGRectGetMaxY(label.frame), CGRectGetWidth(label.frame), CGRectGetHeight(label.frame))];
        [label setText:@"贴现日期"];
        [label setFont:Font14];
        [label setTextColor:Color_white_80];
        [self.contentView addSubview:label];
        
        Textlabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(Textlabel.frame), MarginH(20), CGRectGetWidth(Textlabel.frame), CGRectGetHeight(Textlabel.frame))];
        Textlabel.center = CGPointMake(Textlabel.center.x, label.center.y);
        [Textlabel setText:@"测试文字"];
        [Textlabel setFont:Font14];
        [Textlabel setTextColor:Color_white_50];
        [self.contentView addSubview:Textlabel];
        self.txrq = Textlabel;

        //----4
        label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(label.frame), CGRectGetMaxY(label.frame), CGRectGetWidth(label.frame), CGRectGetHeight(label.frame))];
        [label setText:@"到期日期"];
        [label setFont:Font14];
        [label setTextColor:Color_white_80];
        [self.contentView addSubview:label];
        
        Textlabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(Textlabel.frame), MarginH(20), CGRectGetWidth(Textlabel.frame), CGRectGetHeight(Textlabel.frame))];
        Textlabel.center = CGPointMake(Textlabel.center.x, label.center.y);
        [Textlabel setText:@"测试文字"];
        [Textlabel setFont:Font14];
        [Textlabel setTextColor:Color_white_50];
        [self.contentView addSubview:Textlabel];
        self.dqrq = Textlabel;

        //----5
        label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(label.frame), CGRectGetMaxY(label.frame), CGRectGetWidth(label.frame), CGRectGetHeight(label.frame))];
        [label setText:@"调整天数"];
        [label setFont:Font14];
        [label setTextColor:Color_white_80];
        [self.contentView addSubview:label];
        
        Textlabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(Textlabel.frame), MarginH(20), CGRectGetWidth(Textlabel.frame), CGRectGetHeight(Textlabel.frame))];
        Textlabel.center = CGPointMake(Textlabel.center.x, label.center.y);
        [Textlabel setText:@"测试文字"];
        [Textlabel setFont:Font14];
        [Textlabel setTextColor:Color_white_50];
        [self.contentView addSubview:Textlabel];
        self.tzts = Textlabel;

        //----6
        label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(label.frame), CGRectGetMaxY(label.frame), CGRectGetWidth(label.frame), CGRectGetHeight(label.frame))];
        [label setText:@"计息天数"];
        [label setFont:Font14];
        [label setTextColor:Color_white_80];
        [self.contentView addSubview:label];
        
        Textlabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(Textlabel.frame), MarginH(20), CGRectGetWidth(Textlabel.frame), CGRectGetHeight(Textlabel.frame))];
        Textlabel.center = CGPointMake(Textlabel.center.x, label.center.y);
        [Textlabel setText:@"测试文字"];
        [Textlabel setFont:Font14];
        [Textlabel setTextColor:Color_white_50];
        [self.contentView addSubview:Textlabel];
        self.jxts = Textlabel;
        
        //----7
        label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(label.frame), CGRectGetMaxY(label.frame), CGRectGetWidth(label.frame), CGRectGetHeight(label.frame))];
        [label setText:@"贴现利息"];
        [label setFont:Font14];
        [label setTextColor:Color_white_80];
        [self.contentView addSubview:label];
        
        Textlabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(Textlabel.frame), MarginH(20), CGRectGetWidth(Textlabel.frame), CGRectGetHeight(Textlabel.frame))];
        Textlabel.center = CGPointMake(Textlabel.center.x, label.center.y);
        [Textlabel setText:@"测试文字"];
        [Textlabel setFont:Font14];
        [Textlabel setTextColor:Color_white_50];
        [self.contentView addSubview:Textlabel];
        self.txlx = Textlabel;
        
        //----8
        label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(label.frame), CGRectGetMaxY(label.frame), CGRectGetWidth(label.frame), CGRectGetHeight(label.frame))];
        [label setText:@"贴现日期"];
        [label setFont:Font14];
        [label setTextColor:Color_white_80];
        [self.contentView addSubview:label];
        
        Textlabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(Textlabel.frame), MarginH(20), CGRectGetWidth(Textlabel.frame), CGRectGetHeight(Textlabel.frame))];
        Textlabel.center = CGPointMake(Textlabel.center.x, label.center.y);
        [Textlabel setText:@"测试文字"];
        [Textlabel setFont:Font14];
        [Textlabel setTextColor:Color_white_50];
        [self.contentView addSubview:Textlabel];
        self.txrq = Textlabel;
        
        //----9
        label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(label.frame), CGRectGetMaxY(label.frame), CGRectGetWidth(label.frame), CGRectGetHeight(label.frame))];
        [label setText:@"测计息时间"];
        [label setFont:Font14];
        [label setTextColor:Color_white_80];
        [self.contentView addSubview:label];
        
        Textlabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(Textlabel.frame), MarginH(20), CGRectGetWidth(Textlabel.frame), CGRectGetHeight(Textlabel.frame))];
        Textlabel.center = CGPointMake(Textlabel.center.x, label.center.y);
        [Textlabel setText:@"测试文字"];
        [Textlabel setFont:Font14];
        [Textlabel setTextColor:Color_white_50];
        [self.contentView addSubview:Textlabel];
        self.jssj = Textlabel;

    }
    return self;
}
// Nothing to do here

-(void)setMCurBabData:(CBABData *)data{
    _mCurBabData = data;
    
    [self.pmje setText:[NSString stringWithFormat:@"%@万元",data.pmje]];
    [self.yll setText:[NSString stringWithFormat:@"%@‰",data.yll]];
    [self.txrq setText:data.txrqstr];
    [self.dqrq setText:data.dqrqstr];
    [self.tzts setText:data.tzts? [NSString stringWithFormat:@"%@天",data.tzts]: @"无"];
    
    [self.jxts setText:[NSString stringWithFormat:@"%@ 天",data.jxts]];
    [self.txlx setText:[NSString stringWithFormat:@"%@ 元",data.txlx]];
    [self.txje setText:[NSString stringWithFormat:@"%@ 元",data.txje]];
    
    [self.jssj setText:data.jssj];

}

@end
