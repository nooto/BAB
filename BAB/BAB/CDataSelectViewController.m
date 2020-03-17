//
//  CDataSelectViewController.m
//  BAB
//
//  Created by GaoAng on 2020/3/17.
//  Copyright © 2020 selfcom. All rights reserved.
//

#import "CDataSelectViewController.h"


@interface CDataSelectViewController ()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *arrDataSource;

@property (nonatomic, copy) void (^didSelected)(NSInteger index);
@end

@implementation CDataSelectViewController
- (id)initWithCompletet:(void (^) (NSInteger index))complete{
    if (self = [super init]) {
        self.didSelected = complete;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择日期";
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.arrDataSource.allKeys.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (![cell isKindOfClass:[UITableViewCell class]]) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = cell.backgroundColor = [UIColor clearColor];
    [cell.textLabel setText:self.arrDataSource[[NSString stringWithFormat:@"%ld",(long)indexPath.row]]];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    return  cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.didSelected) {
        self.didSelected(indexPath.row+1);
    }
    [ROOTNAV popViewControllerAnimated:YES];
}

- (NSDictionary*)arrDataSource{
    if (_arrDataSource == NULL) {
        _arrDataSource = [NSDictionary dictionaryWithObjectsAndKeys:@"一个月",@"0",  @"两个月",@"1", @"三个月",@"2", @"四个月",@"3", @"五个月",@"4",@"半年", @"5", @"七个月", @"6", @"八个月", @"7", @"九个月", @"8", @"十个月", @"9", @"十一个月", @"10", @"一年",@"11",  nil];
    }
    return _arrDataSource;
}
- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVBAR_H, SCREEN_W, SCREEN_H - NAVBAR_H) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.estimatedRowHeight = _tableView.rowHeight = MarginH(55.0F);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4f];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.tableHeaderView = [UIView new];
    }
    return _tableView;
}

@end
