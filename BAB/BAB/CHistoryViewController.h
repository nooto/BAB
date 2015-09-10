//
//  CHistoryViewController.h
//  BAB
//
//  Created by GaoAng on 14-4-17.
//  Copyright (c) 2014年 selfcom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMainViewController.h"
#import "CHistoryViewCell.h"
#import <iAd/iAd.h>
@interface CHistoryViewController : UIViewController <UITableViewDataSource , UITableViewDelegate, ADBannerViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *listView;

@property (nonatomic, strong) NSMutableArray *arrHistory;
//@property (nonatomic, strong) IBOutlet UIView  *emptyView;

//@property (nonatomic, strong) IBOutlet ADBannerView *bannerView;
@end
