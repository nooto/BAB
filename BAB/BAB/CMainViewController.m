//
//  CMainViewController.m
//  BAB
//
//  Created by GaoAng on 14-4-8.
//  Copyright (c) 2014年 selfcom. All rights reserved.
//

#import "CMainViewController.h"
#import "BABData.h"

#import "MJExtension.h"
#import "EHDataMgrModule.h"
#import "HistoryViewController.h"
@interface CMainViewController ()

@end

@implementation CMainViewController
@synthesize datePickerView;
@synthesize txjeTextField, txlxTextField, txrqTextField, tztsTextField, pmjeTextField, yllTextField, dqrqTextField, jxtsTextField,babData;
@synthesize txrqButton, dqrqButton;
@synthesize arrHistory, clearnButton, calculateButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(NSMutableArray*)arrHistory{
	if (arrHistory == nil) {
		arrHistory = [[NSMutableArray alloc] initWithCapacity:1];
	}
	return arrHistory;
}

-(CBABData*)babData{
	if (babData == nil) {
		babData = [[CBABData alloc] init];
	}
	return babData;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[EHDataMgrModule shareInstance] initQueue];

//	self.title = @"承兑贴现计算";
	UILabel *t = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width/4, 44)];
    t.font = [UIFont systemFontOfSize:20];
    t.textColor = [UIColor colorWithWhite:1 alpha:0.8f];
    t.backgroundColor = [UIColor clearColor];
    t.textAlignment = NSTextAlignmentCenter;
    t.text = @"承兑贴现计算";
    self.navigationItem.titleView = t;
	UIBarButtonItem *righth = [[UIBarButtonItem alloc] initWithTitle:@"记录" style:UIBarButtonItemStylePlain
															  target:self action:@selector(showHistory)];
	[righth setTintColor:[UIColor colorWithWhite:1 alpha:0.6f]];
	self.navigationItem.rightBarButtonItem = righth;
	[self.navigationItem.backBarButtonItem setTitle:@"返回"];

	if (datePickerView == nil) {
		datePickerView = [[RFDatePickerView alloc] initWithFrame:CGRectMake(0,
																			[UIScreen mainScreen].bounds.size.height,
																			[UIScreen mainScreen].bounds.size.width,246)];
		datePickerView.m_delegate = self;
	}
	[self.view addSubview:datePickerView];
    
    [self initViewAndData];
    
    txrqButton.showsTouchWhenHighlighted = dqrqButton.showsTouchWhenHighlighted = YES;
}

-(void)initViewAndData{
    [self.calculateButton setEnabled:NO];
    [self.clearnButton setEnabled:NO];

    [self.pmjeTextField setText:nil];
    self.yllTextField.text = nil;
    self.tztsTextField.text = nil;
    self.jxtsTextField.text = nil;
    self.txlxTextField.text = nil;
    self.txjeTextField.text = nil;
    self.babData.txrq = [NSDate date];
    NSDateFormatter *formattter = [[NSDateFormatter alloc] init];
    [formattter setDateFormat:@"yyyy年MM月dd日"];
    NSString* temp = [formattter stringFromDate:[NSDate date]];
    [self.txrqTextField setText:temp];
    [self.dqrqTextField setText:temp];
    self.babData.dqrqstr =temp;
    self.babData.txrqstr = temp;
    self.babData.dqrq = [NSDate date];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.datePickerView.isShow) {
        [self.datePickerView showDatePickerView:NO];
    }
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [datePickerView showDatePickerView:NO];
	return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
	[self.clearnButton setEnabled:YES];
	[self.calculateButton setEnabled:YES];

	if ([textField isEqual:tztsTextField]) {
		if ([string isEqualToString:@"0" ]||
			[string isEqualToString:@"1"] ||
			[string isEqualToString:@"2"] ||
			[string isEqualToString:@"3"] ||
			[string isEqualToString:@"4"] ||
			[string isEqualToString:@"5"] ||
			[string isEqualToString:@"6"] ||
			[string isEqualToString:@"7"] ||
			[string isEqualToString:@"8"] ||
			[string isEqualToString:@"9"] ||
			[string isEqualToString:@""]
			)
		{
			return YES;
		}
	}
	else{
		if ([string isEqualToString:@"0" ]||
			[string isEqualToString:@"1"] ||
			[string isEqualToString:@"2"] ||
			[string isEqualToString:@"3"] ||
			[string isEqualToString:@"4"] ||
			[string isEqualToString:@"5"] ||
			[string isEqualToString:@"6"] ||
			[string isEqualToString:@"7"] ||
			[string isEqualToString:@"8"] ||
			[string isEqualToString:@"9"] ||
			[string isEqualToString:@""] ||
			[string isEqualToString:@"."]
			)
		{
			return YES;
		}
	}
	
	return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
	if ([textField isEqual:pmjeTextField]) {
		self.babData.pmje = textField.text;
	}
	else if ([textField isEqual:yllTextField])
	{
		self.babData.yll = textField.text;
	}
	else if ([textField isEqual:tztsTextField])
	{
		self.babData.tzts = textField.text;
	}
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
	
	if ([textField isEqual:pmjeTextField]) {
		self.babData.pmje = textField.text;
	}
	else if ([textField isEqual:yllTextField])
	{
		self.babData.yll = textField.text;
	}
	else if ([textField isEqual:tztsTextField])
	{
		self.babData.tzts = textField.text;
	}
	return YES;
}

//  ‰// %
-(void)datePickerViewSeldate:(NSDate*)date{
  	NSDateFormatter *formattter = [[NSDateFormatter alloc] init];
	[formattter setDateFormat:@"yyyy年MM月dd日"];
	if (datePickerView.tag == 1) {
		babData.txrq = date;
		NSString* temp = [formattter stringFromDate:date];
		[self.txrqTextField setText:temp];
		self.babData.txrqstr = temp;
	}
	else if (datePickerView.tag ==2){
		babData.dqrq = date;
		NSString* temp = [formattter stringFromDate:date];
		[self.dqrqTextField setText:temp];
		self.babData.dqrqstr = temp;
	}
}

-(IBAction)txrqButtonAction:(UIButton*)sender{
	[self closeKeyBoarad];
//    self.txrqTextField.text;
    NSDateFormatter *formattter = [[NSDateFormatter alloc] init];
    [formattter setDateFormat:@"yyyy年MM月dd日"];
    NSDate *date = [formattter dateFromString:self.txrqTextField.text];
	datePickerView.tag = 1;
    [datePickerView showDatePickerView:YES WithDate:date];
    
    date = [formattter dateFromString:self.dqrqTextField.text];
    [datePickerView setDatePickerMaxData:date];
}

-(IBAction)dqrqButtonAction:(UIButton*)sender{
	[self closeKeyBoarad];
    NSDateFormatter *formattter = [[NSDateFormatter alloc] init];
    [formattter setDateFormat:@"yyyy年MM月dd日"];
    NSDate *date = [formattter dateFromString:self.dqrqTextField.text];
	datePickerView.tag = 2;
	[datePickerView showDatePickerView:YES WithDate:date];

    date = [formattter dateFromString:self.txrqTextField.text];
    [datePickerView setDatePickerMinData:date];

}

-(IBAction)calculateButtonAction:(id)sender{
	[self closeKeyBoarad];
	//check data
	
	if (babData.pmje.length <= 0) {
		[self showMessage:@"请输入票面金额"];
		[self.pmjeTextField becomeFirstResponder];
		return;
	}
	else if (babData.yll.length <= 0 || [babData.yll intValue] >= 1000){
		[self showMessage:@"请输入正确的月利率"];
		[self.yllTextField becomeFirstResponder];
		return;
	}
	NSTimeInterval val111 = [babData.dqrq timeIntervalSince1970];
	NSInteger day1 = val111 / (60 * 60 * 24);
	NSInteger day2 = [babData.txrq timeIntervalSince1970] / (60 *60* 24);
	if (day1 <= day2) {
		[self showMessage:@"到期日期要晚于贴现日期。"];
		return;
	}
	
	[self.clearnButton setEnabled:YES];
	[self.calculateButton setEnabled:YES];
	NSDateFormatter *formattter = [[NSDateFormatter alloc] init];
	[formattter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
	NSString* temp12 = [formattter stringFromDate:[NSDate date]];
	self.babData.jssj = temp12;
	
	
	//测试数据。
	//150.55万   1.5利率   2014-04-09- 2014-05-01  1656.05 ---- 1503843.95
	
	NSInteger numGap = 100;
	
//	贴息=票面金额*贴现天数/360*贴现率（年息）或贴息=票面金额*贴现天数/30*贴现率（月息
	double pmje = [babData.pmje doubleValue] * 10000;
	double yll = [babData.yll doubleValue] / 1000;
	
	NSTimeInterval val =  [babData.dqrq timeIntervalSinceDate:babData.txrq];
	NSInteger days=((NSInteger)(val+0.5))/(3600*24);
	days = day1 - day2;
	days = days + [babData.tzts intValue];
	double temp  = pmje * days * (yll/30);
	
	self.babData.jxts = [NSString stringWithFormat:@"%ld", (long)days];
	[self.jxtsTextField setText:babData.jxts];
	
	//
	NSInteger temp1 = (NSInteger)(temp * numGap + 0.5);
	double   temp2 = ((double) temp1) / numGap;
	self.babData.txlx = [NSString stringWithFormat:@"%.2f", temp2];
	[self.txlxTextField setText:babData.txlx];

	double temp3 =  (double) ( pmje * numGap - temp1) / numGap;
	
	self.babData.txje = [NSString stringWithFormat:@"%.2f", temp3];
	[self.txjeTextField setText:babData.txje];
	
    [DBHelper inserTtBABData:self.babData];
}


-(IBAction)clearButtonAction:(id)sender{
	[self closeKeyBoarad];
    [self initViewAndData];
}
-(void)showHistory{
    HistoryViewController *vc = [[HistoryViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
//	CHistoryViewController *conroller = [[CHistoryViewController alloc] initWithNibName:@"CHistoryViewController" bundle:nil];
//	[self.navigationController pushViewController:conroller animated:YES];
}

-(void)bgButtonAciton:(id)sender{
	[self closeKeyBoarad];
	[datePickerView showDatePickerView:NO];
}

-(void)closeKeyBoarad{
	[self.pmjeTextField resignFirstResponder];
	[self.yllTextField resignFirstResponder];
	[self.tztsTextField resignFirstResponder];

}
#pragma mark  ADBannerView 
- (void)bannerViewWillLoadAd:(ADBannerView *)banner{
    [self.bannerView setFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds) - 44, CGRectGetWidth(self.view.bounds), 50)];
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    NSLog(@"bannerViewDidLoadAd");
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
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


- (void)showMessage:(NSString*)msg{
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
														message:msg
													   delegate:nil
											  cancelButtonTitle:nil
											  otherButtonTitles:@"确定", nil];
	[alertView show];
	
}


@end
