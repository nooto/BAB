//
//  CHistoryViewCell.m
//  BAB
//
//  Created by GaoAng on 14-4-17.
//  Copyright (c) 2014年 selfcom. All rights reserved.
//

#import "CHistoryViewCell.h"

@implementation CHistoryViewCell
@synthesize yll, txje, txlx, txrq, dqrq, pmje, tzts, jxts, jssj,bgView;

- (void)awakeFromNib
{
    // Initialization code
	bgView.layer.cornerRadius = 20.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
