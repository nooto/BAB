//
//  CMenuView.m
//  BAB
//
//  Created by GaoAng on 2020/1/31.
//  Copyright © 2020 selfcom. All rights reserved.
//
#import "CMenuView.h"
#import "CMenuItemCell.h"
#import "CScreenTestViewController.h"
#import "CDeviceInfoViewController.h"
#import "CDeviceIDViewController.h"
#import "Tool.h"
#define ContentViewWidth SCREEN_W/3*2
@interface CMenuView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *mBackGroundView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSMutableArray *arrDataSource;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation CMenuView
- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.mBackGroundView];
        [self addSubview:self.contentView];
        self.hidden = YES;
        [self.contentView addSubview:self.tableView];
    }
    return self;
}


-(NSArray*)arrDataSource{
    if (!_arrDataSource) {
        _arrDataSource = [[NSMutableArray alloc] initWithCapacity:1];
//        [_arrDataSource addObject:@{@"itemName":@"做个决定", @"icon":@""}];
        [_arrDataSource addObject:@{@"itemName":@"屏幕测试", @"icon":@""}];
        [_arrDataSource addObject:@{@"itemName":@"设备动态", @"icon":@""}];
        [_arrDataSource addObject:@{@"itemName":@"标识符", @"icon":@""}];
        [_arrDataSource addObject:@{@"itemName":@"清除缓存", @"icon":@""}];
    }
    return _arrDataSource;
    
}

- (UIView*)mBackGroundView{
    if (!_mBackGroundView) {
        _mBackGroundView = [UIView new];
        [_mBackGroundView setBackgroundColor:[UIColor blackColor]];
        [_mBackGroundView setFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
        _mBackGroundView.alpha = 0.0f;
    }
    return _mBackGroundView;
}

- (UIView*)contentView{
    if (!_contentView) {
        _contentView = [UIView new];
        [_contentView setBackgroundColor:[UIColor whiteColor]];
        [_contentView setFrame:CGRectMake(-ContentViewWidth, 0, ContentViewWidth, SCREEN_H)];
    }
    return _contentView;
}

- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:_contentView.bounds style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.scrollEnabled = NO;
        _tableView.estimatedRowHeight = _tableView.rowHeight = MarginH(55.0F);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [self tableHeaderViewWithWidth:CGRectGetWidth(_tableView.bounds)];
    }
    return _tableView;
}

- (UIView*)tableHeaderViewWithWidth:(CGFloat)width{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, SCREEN_H*(1-0.718f))];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
    imageView.image = [UIImage imageNamed:[Tool GetAppIconName]];
    imageView.center = CGPointMake(width/2, CGRectGetHeight(headerView.frame)/2+20);
    imageView.layer.cornerRadius = 10.f;
    imageView.layer.masksToBounds = YES;
    [headerView addSubview:imageView];
    
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.arrDataSource.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CMenuItemCell *cell = (CMenuItemCell*)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CMenuItemCell class])];
    if (![cell isKindOfClass:[CMenuItemCell class]]) {
        cell = [[CMenuItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CMenuItemCell class])];
    }
    [cell setDict:self.arrDataSource[indexPath.row]];
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CMenuItemCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *text = cell.dict[@"itemName"];
    if ([text isEqualToString:@"做个决定"]) {
        
    }
    else if ([text isEqualToString:@"屏幕测试"]) {
        CScreenTestViewController *vc = [[CScreenTestViewController alloc] init];
        [vc setTitle:text];
        [ROOTNAV pushViewController:vc animated:YES];
    }
    else if ([text isEqualToString:@"设备动态"]) {
        CDeviceInfoViewController *vc = [[CDeviceInfoViewController alloc] init];
        [vc setTitle:text];
        [ROOTNAV pushViewController:vc animated:YES];
    }
    else if ([text isEqualToString:@"标识符"]) {
        CDeviceIDViewController *vc = [[CDeviceIDViewController alloc] init];
        [vc setTitle:text];
        [ROOTNAV pushViewController:vc animated:YES];
    }
    else if ([text isEqualToString:@"清除缓存"]) {
        [self cleanCache];
    }

    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self showMenuView:NO];
}


-(void)showMenuView:(BOOL)show{
    if (show) {
        self.hidden = NO;
        [UIView animateWithDuration:0.3f animations:^{
            _mBackGroundView.alpha = 0.5f;
            [_contentView setFrame:CGRectMake(0, CGRectGetMinY(_contentView.frame), CGRectGetWidth(_contentView.frame), CGRectGetHeight(_contentView.frame))];
        }];
    }
    else{
        [UIView animateWithDuration:0.3f animations:^{
            _mBackGroundView.alpha = 0.0f;
            [_contentView setFrame:CGRectMake(-CGRectGetWidth(_contentView.frame), CGRectGetMinY(_contentView.frame), CGRectGetWidth(_contentView.frame), CGRectGetHeight(_contentView.frame))];
        }completion:^(BOOL finished) {
            self.hidden = YES;
        }];
    }
}


-(void)cleanCache{
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dbPath = [document stringByAppendingPathComponent:@"BAB"];
    NSString *totleStr =  [Tool getCacheSizeWithFilePath:dbPath];
    
    if ([totleStr containsString:@"0.00"]) {
        NSString *title = NSLocalizedString(@"提示", nil);
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:[NSString stringWithFormat:@"\r\n无需清理缓存数据！"] preferredStyle:UIAlertControllerStyleAlert];
        
        // Create the actions.
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }];
        
        // Add the actions.
        [alertController addAction:cancelAction];
        [ROOTNAV presentViewController:alertController animated:YES completion:nil];
        return;
    }
    
    [Tool clearCacheWithFilePath:dbPath];
    
    NSString *title = NSLocalizedString(@"提示", nil);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:[NSString stringWithFormat:@"\r\n成功清除%@缓存数据！",totleStr] preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [ROOTNAV presentViewController:alertController animated:YES completion:nil];

    
}
@end
