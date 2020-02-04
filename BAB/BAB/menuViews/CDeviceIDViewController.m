//
//  CDeviceIDViewController.m
//  BAB
//
//  Created by GaoAng on 2020/2/4.
//  Copyright © 2020 selfcom. All rights reserved.
//

#import "CDeviceIDViewController.h"
#import <AdSupport/AdSupport.h>

@interface CDeviceIDViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView*tableView;
@end

@implementation CDeviceIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mNavBarView.backgroundColor = [UIColor systemBlueColor];
    [self.view addSubview:self.tableView];
}

- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVBAR_H, SCREEN_W, SCREEN_H - NAVBAR_H) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.estimatedRowHeight = _tableView.rowHeight = MarginH(55.0F);
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 55;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), [self tableView:tableView heightForHeaderInSection:section])];
    view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2f];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 200, 20)];
    label.text = @"点击可复制";
    [label setTextColor:[UIColor grayColor]];
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 160;
    }
    else{
        return 180;
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), [self tableView:tableView heightForHeaderInSection:section])];
    view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2f];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, SCREEN_W - 30, [self tableView:tableView heightForFooterInSection:section])];
    label.numberOfLines = 0;
    if (section == 0) {
        label.text = @"广告标示符，在同一个设备上的所有App都会取到相同的值，是苹果专门给各广告提供商用来追踪用户而设的。\r\n 通过以下情况可以重新生成广告标示符。 \r\n(1)完全重置系统（(设置程序 -> 通用 -> 还原 -> 还原位置与隐私)。\r\n(2)用户明确的还原广告(设置程序-> 通用 -> 关于本机 -> 广告 -> 还原广告标示符)";
    }
    else{
        label.text = @"Vendor标示符，是给Vendor标识用户用的，每个设备在所属同一个Vender的应用里，都有相同的值。其中的Vender是指应用提供商。\r\n 和IDFA不同的是，IDFV的值是一定能取到的，适合于作为内部用户行为分析的主id，来标识用户。\r\n 但是如果将属于此Vender的所有App卸载，则IDFV的值会被重置，即再重装此Vender的App，IDFV的值和之前不同。";
    }
    [label setTextColor:[UIColor grayColor]];
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];
    return view;

}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        [cell.textLabel setText:@"广告标示符（IDFA）"];
        NSString *adId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        [cell.detailTextLabel setText:adId];
    }
    else{
        cell.textLabel.text = @"应用开发商标识符（Vendor）";
        NSString *strIDFV = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        cell.detailTextLabel.text = strIDFV;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string =cell.detailTextLabel.text;
    
    NSString *title = NSLocalizedString(@"提示", nil);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:[NSString stringWithFormat:@"\r\n复制%@成功！",cell.textLabel.text] preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end




