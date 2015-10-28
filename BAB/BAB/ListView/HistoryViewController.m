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
// Strings
NSString * const kTWMessageViewControllerCellIdentifier = @"kTWMessageViewControllerCellIdentifier";
// Numerics
CGFloat const kTWMessageViewControllerCellPadding = 10;
CGFloat const kTWMessageViewControllerCellHeight = 50;

@interface HistoryViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView  *mCollectionView;
@end

@implementation HistoryViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview:self.mCollectionView];
    self.view.backgroundColor = [UIColor grayColor];
}

-(UICollectionView*)mCollectionView{
    if (!_mCollectionView) {
        _mCollectionView  = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) collectionViewLayout:[[TWSpringyFlowLayout alloc] init]];
        _mCollectionView.backgroundColor = [UIColor clearColor];
        [_mCollectionView registerClass:[TWMessageViewCell class] forCellWithReuseIdentifier:kTWMessageViewControllerCellIdentifier];
        _mCollectionView.delegate = self;
        _mCollectionView.dataSource = self;
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
    return 20;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TWMessageViewCell *cell = (TWMessageViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kTWMessageViewControllerCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.bounds.size.width - (kTWMessageViewControllerCellPadding*2), kTWMessageViewControllerCellHeight);
}
@end
