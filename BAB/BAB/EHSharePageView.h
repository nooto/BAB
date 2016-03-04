//
//  EHSharePageView.h
//  EHouse
//
//  Created by GaoAng on 15/5/13.
//  Copyright (c) 2015年 wondershare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMainViewController.h"

@class EHSharePageView;
@protocol EHSharePageViewdDelegate <NSObject>

@optional
-(void)sharePageViewDidFinshShare:(BOOL)issuccess withMessage:(NSString*)message;
-(void)sharePageViewWillPopWindow:(EHSharePageView*)sharePage;
@end



@interface EHSharePageView : UIView
@property (nonatomic, strong) UIImage *mShareImage;
@property (nonatomic, copy) NSString *mShareContent;

- (id)initWithFrame:(CGRect)frame withDelegate:(id)delegate;
-(void)showSharePageView:(BOOL)show;
@end
