//
//  EHPromptView.m
//  EHouse
//
//  Created by user on 15/4/2.
//  Copyright (c) 2015年 wondershare. All rights reserved.
//

//#define SCREEN_W  [UIApplication sharedApplication].keyWindow.bounds.size.width
//#define SCREEN_H  [UIApplication sharedApplication].keyWindow.bounds.size.height

#import "EHPromptView.h"
#import "EHSysScreen.h"
@interface EHPromptView ()
@property (nonatomic, strong) UILabel *mTipLabel;
@property (nonatomic, copy) void(^finished)();
@end

@implementation EHPromptView
-(id)initWithPromptString:(NSString *)PromptText image:(NSString *)name complete:(void (^)())finish{
    self = [super initWithFrame:CGRectMake(SCREEN_W/4, SCREEN_H/3, SCREEN_W/2, SCREEN_H/4)];
    if (self) {
        UIImage *image = [UIImage imageNamed:name];
//        UIButton *imageView = [[UIButton alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame) - image.size.width)/2, (CGRectGetHeight(self.frame)-image.size.height)/2, image.size.width, image.size.height)];
        CGFloat imageWidht = 80;
        UIButton *imageView = [[UIButton alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame) - imageWidht)/2, (CGRectGetHeight(self.frame)-imageWidht)/2, imageWidht, imageWidht)];
        [imageView setImage:image forState:UIControlStateHighlighted];
        [imageView setImage:image forState:UIControlStateNormal];
        //        imageView.center =CGPointMake(self.center.x, self.center.y-image.size.height/2);
        [imageView addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:imageView];
        
        _mTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame)+20, CGRectGetWidth(self.frame), 30)];
        _mTipLabel.text = PromptText.length > 0 ? PromptText : @"暂无数据";
        _mTipLabel.textColor = [UIColor colorWithWhite:1 alpha:0.5f];
        _mTipLabel.font = [UIFont systemFontOfSize:16];
        _mTipLabel.textAlignment = NSTextAlignmentCenter;
        [_mTipLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_mTipLabel];
        
        //        self.backgroundColor = ColorFromHex(0xF8F8F8);
        self.backgroundColor = [UIColor clearColor];
        self.hidden = YES;
        self.finished = finish;
    }
    return self;
}

-(id)initWithPromptString:(NSString*)PromptText complete:(void (^)())finish{
   return    [self initWithPromptString:PromptText image:@"prompt" complete:finish];
}
-(void)tapAction:(UIButton*)sender{
    if (self.finished) {
        self.finished();
    }
}

-(void)show:(BOOL)show{
    self.hidden = !show;
    if (!self.hidden) {
        self.transform = CGAffineTransformMakeScale(0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:nil];
    }
}

@end
