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
CGFloat const kTWMessageViewControllerCellHeight = 260;

@interface HistoryViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView  *mCollectionView;
@property (nonatomic, strong) NSArray *mSourceDatas;
@end

@implementation HistoryViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"记录";
    self.mNavBarView.backgroundColor = [UIColor clearColor];
    
    UIImageView *mBgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [mBgView setImage:[UIImage imageNamed:@"bg"]];
    [self.view addSubview:mBgView];
    
    [self.view addSubview:self.mCollectionView];
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
        
//        _mCollectionView.h
    }
    return _mCollectionView;
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
