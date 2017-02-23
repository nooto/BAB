//
//  CHistoryViewCell.m
//  BAB
//
//  Created by GaoAng on 14-4-17.
//  Copyright (c) 2014年 selfcom. All rights reserved.
//

#import "CHistoryViewCell.h"

@interface CHistoryViewCell ()

@property (nonatomic, strong) IBOutlet UILabel *pmje;
@property (nonatomic, strong) IBOutlet UILabel *yll;
@property (nonatomic, strong) IBOutlet UILabel *dqrq;
@property (nonatomic, strong) IBOutlet UILabel *txrq;
@property (nonatomic, strong) IBOutlet UILabel *tzts;

@property (nonatomic, strong) IBOutlet UILabel *jxts;
@property (nonatomic, strong) IBOutlet UILabel *txlx;
@property (nonatomic, strong) IBOutlet UILabel *txje;

@property (nonatomic, strong) IBOutlet UILabel *jssj;

@property (nonatomic, strong) IBOutlet UIView *bgView;


@end
@implementation CHistoryViewCell
@synthesize yll, txje, txlx, txrq, dqrq, pmje, tzts, jxts, jssj,bgView;

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
	self.bgView.layer.cornerRadius = 20.0f;
    self.yll.textColor = self.txje.textColor = self.txlx.textColor = self.txrq.textColor = self.dqrq.textColor = self.pmje.textColor = tzts.textColor = jxts.textColor = [UIColor colorWithWhite:1 alpha:0.5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



-(void)setMBABData:(CBABData *)mBABData{
    _mBABData = mBABData;
    [pmje setText:[NSString stringWithFormat:@"%@万元",mBABData.pmje]];
    [yll setText:[NSString stringWithFormat:@"%@‰",mBABData.yll]];
    [txrq setText:mBABData.txrqstr];
    [dqrq setText:mBABData.dqrqstr];
    [tzts setText:mBABData.tzts? [NSString stringWithFormat:@"%@天",mBABData.tzts]: @"无"];

    [jxts setText:[NSString stringWithFormat:@"%@ 天",mBABData.jxts]];
    [txlx setText:[NSString stringWithFormat:@"%@ 元",mBABData.txlx]];
    [txje setText:[NSString stringWithFormat:@"%@ 元",mBABData.txje]];

    [jssj setText:mBABData.jssj];
}
@end
