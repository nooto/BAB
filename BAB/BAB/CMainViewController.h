//
//  CMainViewController.h
//  BAB
//
//  Created by GaoAng on 14-4-8.
//  Copyright (c) 2014年 selfcom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RFDatePickerView.h"
#import "CHistoryViewController.h"
#import <iAd/iAd.h>
#import "BABData.h"
#import "UIBaseViewController.h"
#import "TTTAttributedLabel.h"
@interface CMainViewController : UIBaseViewController <RFDatePickerViewDelegate, UIGestureRecognizerDelegate, ADBannerViewDelegate>
{
	BOOL bannerIsVisible;
}

@property (nonatomic, strong) IBOutlet UIButton *clearnButton;
@property (nonatomic, strong) IBOutlet UIButton *calculateButton;

@property (nonatomic, strong) RFDatePickerView *datePickerView;
@property (nonatomic, strong) IBOutlet UITextField *pmjeTextField;
@property (nonatomic, strong) IBOutlet UITextField *yllTextField;

@property (nonatomic, strong) IBOutlet UITextField *txrqTextField;
@property (nonatomic, strong) IBOutlet UIButton   *txrqButton;
@property (nonatomic, strong) IBOutlet UITextField *dqrqTextField;
@property (nonatomic, strong) IBOutlet UIButton   *dqrqButton;

@property (nonatomic, strong) TTTAttributedLabel *resultLabel;
@property (nonatomic, strong) IBOutlet UITextField *tztsTextField;
@property (nonatomic, strong) IBOutlet UITextField *jxtsTextField;
@property (nonatomic, strong) IBOutlet UITextField *txlxTextField;
@property (nonatomic, strong) IBOutlet UITextField *txjeTextField;

@property (nonatomic, strong) IBOutlet ADBannerView *bannerView;

@property (nonatomic, weak) IBOutlet UIImageView *mBgView;
@property (nonatomic, strong) 	CBABData* babData;
@property (nonatomic, strong) NSMutableArray *arrHistory;
@end
