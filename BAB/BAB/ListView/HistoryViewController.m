//
//  HistoryViewController.m
//  EHouse
//
//  Created by GaoAng on 15/10/23.
//  Copyright © 2015年 wondershare. All rights reserved.
//

#import "HistoryViewController.h"
#import "TWMessageViewCell.h"
#import "TWSpringyFlowLayout.h"
#import "UtilityHelper.h"
#import "EHSysProperty.h"
#import "EHSysScreen.h"
#import "EHDataMgrModule.h"
// Strings
NSString * const kTWMessageViewControllerCellIdentifier = @"kTWMessageViewControllerCellIdentifier";
// Numerics
CGFloat const kTWMessageViewControllerCellPadding = 10;
CGFloat const kTWMessageViewControllerCellHeight = 240;

@interface HistoryViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ADBannerViewDelegate>
@property (nonatomic, strong) UICollectionView  *mCollectionView;
@property (nonatomic, strong) ADBannerView *mBannerView;
@property (nonatomic, strong) NSArray *mSourceDatas;

@property (nonatomic, assign) APPType  mAppType;
@end

@implementation HistoryViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"记录";
    self.mNavBarView.backgroundColor = [UIColor clearColor];
    self.mAppType = [Utility AppType];
    self.mAppType = APP_CHARGE;
    
    UIImageView *mBgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [mBgView setImage:[UIImage imageNamed:@"bg"]];
    [self.view addSubview:mBgView];
    
    [self.view addSubview:self.mCollectionView];
    
    __weak typeof(self.view )weaskSuperView = self.view;
    if (self.mAppType == APP_FREE) {
        [self.view addSubview:self.mBannerView];
        [self.mCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weaskSuperView.mas_left);
            make.right.equalTo(weaskSuperView.mas_right);
            make.top.equalTo(weaskSuperView.mas_top).offset(NAVBAR_H);
            make.bottom.equalTo(self.mBannerView.mas_top).offset(-10);
        }];
        
        [self.mBannerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weaskSuperView.mas_left);
            make.right.equalTo(weaskSuperView.mas_right);
            make.bottom.equalTo(weaskSuperView.mas_bottom);
            make.top.equalTo(weaskSuperView.mas_bottom).offset(-45);
        }];
    }
    else if (self.mAppType == APP_CHARGE){
        [self.mCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weaskSuperView.mas_left);
            make.right.equalTo(weaskSuperView.mas_right);
            make.top.equalTo(weaskSuperView.mas_top).offset(NAVBAR_H);
            make.bottom.equalTo(weaskSuperView.mas_bottom);
        }];
        
    }
}


-(NSArray*)mSourceDatas{
    if (!_mSourceDatas) {
        _mSourceDatas = [[NSArray alloc] initWithArray:[DBHelper babdataFromDB]];
    }
    return _mSourceDatas;
}
-(UICollectionView*)mCollectionView{
    if (!_mCollectionView) {
        _mCollectionView  = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVBAR_H+10, SCREEN_W, SCREEN_H - NAVBAR_H-20) collectionViewLayout:[[TWSpringyFlowLayout alloc] init]];
        _mCollectionView.backgroundColor = [UIColor clearColor];
        [_mCollectionView registerClass:[TWMessageViewCell class] forCellWithReuseIdentifier:kTWMessageViewControllerCellIdentifier];
        _mCollectionView.delegate = self;
        _mCollectionView.dataSource = self;
    }
    return _mCollectionView;
}
-(ADBannerView*)mBannerView{
    if (!_mBannerView) {
        _mBannerView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
        [_mBannerView setFrame:CGRectMake(0, SCREEN_H - 45, SCREEN_W, 45)];
        _mBannerView.delegate = self;
        _mBannerView.alpha = .0f;
    }
    return _mBannerView;
}

#pragma mark  ADBannerView
- (void)bannerViewWillLoadAd:(ADBannerView *)banner{
//    self.mBannerView.alpha = 1.0f;
    //    [self.mBannerView setFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds) - 44, CGRectGetWidth(self.view.bounds), 50)];
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    [UIView animateWithDuration:.25f animations:^{
        self.mBannerView.alpha = 1.f;
    }];}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    [UIView animateWithDuration:.25f animations:^{
        self.mBannerView.alpha = .0f;
    }];
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


#pragma mark - UICollectionView DataSource & Delegate methods
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.mSourceDatas.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TWMessageViewCell *cell = (TWMessageViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kTWMessageViewControllerCellIdentifier forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    if (indexPath.item >= 0 && indexPath.item < self.mSourceDatas.count) {
        [cell setMCurBabData:[self.mSourceDatas objectAtIndex:indexPath.item]];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.bounds.size.width - (kTWMessageViewControllerCellPadding*2), kTWMessageViewControllerCellHeight);
}
@end
