//
//  CHistoryViewController.m
//  BAB
//
//  Created by GaoAng on 14-4-17.
//  Copyright (c) 2014年 selfcom. All rights reserved.
//

#define ScreenWidth                      [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                     [[UIScreen mainScreen] bounds].size.height
#import "EHDataMgrModule.h"
#import "CHistoryViewController.h"
#import "EHPromptView.h"
@interface CHistoryViewController ()
@property (nonatomic, weak) UIImageView  *mBgView;
@property (nonatomic, strong) EHPromptView *mPromptView;
@property (nonatomic, strong) ADBannerView *mBannerView;
@property (nonatomic, assign) APPType  mAppType;
@end

@implementation CHistoryViewController
@synthesize listView,arrHistory;
//@synthesize emptyView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.mAppType = [Utility AppType];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    UILabel *t = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width/4, 44)];
    t.font = [UIFont systemFontOfSize:20];
    t.textColor = [UIColor colorWithWhite:1 alpha:0.8f];
    t.backgroundColor = [UIColor clearColor];
    t.textAlignment = NSTextAlignmentCenter;
    t.text = @"记录";
    self.navigationItem.titleView = t;
    
	UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"返回"
															 style:UIBarButtonItemStylePlain
															target:self
															action:@selector(cancelAction:)];
	[left setTintColor:[UIColor colorWithWhite:1 alpha:0.8f]];
    self.navigationItem.leftBarButtonItem =left;
	
	
	UIBarButtonItem *right =  [[UIBarButtonItem alloc] initWithTitle:@"清空" style:UIBarButtonItemStylePlain target:self action:@selector(clearHistory:)];
	[right setTintColor:[UIColor colorWithWhite:1 alpha:0.8f]];
	self.navigationItem.rightBarButtonItem =right;
	
    [self.arrHistory addObjectsFromArray:[DBHelper babdataFromDB]];

    [self.listView setBackgroundColor:[UIColor clearColor]];
    self.listView.rowHeight = 300;
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.mPromptView];
    __weak typeof(self.view )weaskSuperView = self.view;

    //有广告
    if (self.mAppType == APP_FREE) {
        [self.view addSubview:self.mBannerView];
        [self.mBannerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weaskSuperView).width.offset(0);
            make.right.equalTo(weaskSuperView).with.offset(0);
            make.top.equalTo(weaskSuperView).with.offset(NAVBAR_H);
            make.bottom.equalTo(_mBannerView.mas_top).with.offset(-20);
        }];
        
        [self.mBannerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weaskSuperView);
            make.right.equalTo(weaskSuperView);
            make.bottom.equalTo(weaskSuperView);
            make.top.equalTo(weaskSuperView).with.offset(-45);
        }];
    }
    //无广告
    else if (self.mAppType == APP_CHARGE){
        [self.mBannerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weaskSuperView);
            make.right.equalTo(weaskSuperView);
            make.top.equalTo(weaskSuperView).with.offset(NAVBAR_H);
            make.bottom.equalTo(weaskSuperView);
        }];
    }
    
}


-(NSMutableArray*)arrHistory{
    if (!arrHistory) {
        arrHistory = [NSMutableArray array];
    }
    return arrHistory;
}

-(ADBannerView*)mBannerView{
    if (!_mBannerView) {
        _mBannerView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
        [_mBannerView setFrame:CGRectMake(0, SCREEN_H - 45, SCREEN_W, 45)];
    }
    return _mBannerView;
}
-(EHPromptView*)mPromptView{
    if (!_mPromptView) {
        _mPromptView = [[EHPromptView alloc] initWithPromptString:@"还没有数据哦..." image:@"ic_failed" complete:^{
        }];
    }
    return _mPromptView;
}


-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
//	adView.delegate = self;
//	UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]
//										   initWithTarget:self
//										   action:@selector(handleSwipeLeft)];
//	swipeLeft.direction = UISwipeGestureRecognizerDirectionRight;

	if ([self.arrHistory count] > 0) {
//		[self.listView addGestureRecognizer:swipeLeft];
//		[self.emptyView setHidden:YES];
	}
	else{
	}
}

-(void)cancelAction:(id)sender{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)clearHistory:(id)sender{
	[self.arrHistory removeAllObjects];
    [DBHelper deleteDB];
	[self.listView reloadData];
	
//	[self.emptyView setHidden:NO];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  ADBannerView
//- (void)bannerViewWillLoadAd:(ADBannerView *)banner{
//    [self.listView setFrame:CGRectMake(0, self.listView.frame.origin.x, ScreenWidth, ScreenHeight - 44)];
//    [self.emptyView setFrame:self.listView.frame];
//    [self.bannerView setFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds) - 44, CGRectGetWidth(self.view.bounds), 50)];
//}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner{
    NSLog(@"bannerViewDidLoadAd");
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    NSLog(@"didFailToReceiveAdWithError");
}

// 用户点击广告是响应，返回值BOOL指定广告是否打开 // 参数willLeaveApplication是指是否用其他的程序打开该广告 // 一般在该函数内让当前View停止，以及准备全画面表示广告 -
-(BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave {
    NSLog(@"bannerViewActionShouldBegin:willLeaveApplication: is called.");
    return YES;
}
// 全画面的广告表示完了后，调用该接口 // 该接口被调用之后，当前程序一般会作为后台程序运行 // 该接口中需要回复之前被中断的处理（如果有的话）
- (void)bannerViewActionDidFinish:(ADBannerView *)banner {
    NSLog(@"bannerViewActionDidFinish: is called.");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.mPromptView.hidden = arrHistory.count > 0 ? YES : NO;
    self.mPromptView.hidden =  NO;
    return [arrHistory count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
	CHistoryViewCell *cell =(CHistoryViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CHistoryViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
		[cell.textLabel setBackgroundColor:[UIColor clearColor]];
		[cell.textLabel setFont:[UIFont systemFontOfSize:16.0f]];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setBackgroundView:nil];
        [cell setBackgroundColor:[UIColor clearColor]];
    }
    
    if (indexPath.row >= 0 && indexPath.row < [arrHistory count]) {
        CBABData *data = (CBABData*)[arrHistory objectAtIndex:indexPath.row];
        [cell setMBABData:data];
    }
    
    return cell;
}
@end
