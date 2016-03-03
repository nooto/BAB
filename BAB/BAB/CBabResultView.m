//
//  CBabResultView.m
//  BAB
//
//  Created by GaoAng on 16/3/3.
//  Copyright © 2016年 selfcom. All rights reserved.
//

#import "CBabResultView.h"
#import "TTTAttributedLabel.h"
//@property (nonatomic, strong) NSString*  jxts;
//@property (nonatomic, strong) NSString*  txlx;
//@property (nonatomic, strong) NSString* txje;
//
//@property (nonatomic, strong) NSString* jssj;

@interface CBabResultView ()
@property (nonatomic, strong) TTTAttributedLabel *mJxtsLabel;
@property (nonatomic, strong) TTTAttributedLabel *mTxlxLabel;
@property (nonatomic, strong) TTTAttributedLabel *mTxjeLabel;

@end
@implementation CBabResultView

-(id)init{
    if (self = [super init]) {
        self.layer.cornerRadius = 10.0f;
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.borderWidth = 1.0f;
        self.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.3f];
        
        [self addSubview:self.mJxtsLabel];
        [self addSubview:self.mTxlxLabel];
        [self addSubview:self.mTxjeLabel];
        [self SetupView];
    }
    return self;
}

-(void)SetupView{
    
}

-(TTTAttributedLabel*)mJxtsLabel{
    if (!_mJxtsLabel) {
        _mJxtsLabel = [[TTTAttributedLabel alloc] init];
    }
    return _mJxtsLabel;
}

-(TTTAttributedLabel*)mTxlxLabel{
    if (!_mTxlxLabel) {
        _mTxlxLabel = [[TTTAttributedLabel alloc] init];
    }
    return _mTxlxLabel;
}

-(TTTAttributedLabel*)mTxjeLabel{
    if (!_mTxjeLabel) {
        _mTxjeLabel = [[TTTAttributedLabel alloc] init];
    }
    return _mTxjeLabel;
}


@end
