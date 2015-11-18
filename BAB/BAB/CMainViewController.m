//
//  CMainViewController.m
//  BAB
//
//  Created by GaoAng on 14-4-8.
//  Copyright (c) 2014年 selfcom. All rights reserved.
//

#import "CMainViewController.h"
#import "BABData.h"
#import "EHSharePageView.h"
#import "MJExtension.h"
#import "EHDataMgrModule.h"
#import "HistoryViewController.h"
#import "Masonry.h"
#import "View+MASShorthandAdditions.h"

@interface CMainViewController () <EHSharePageViewdDelegate>

@property (nonatomic, strong)  UIImageView *mBgView;

@property (nonatomic, strong)  UIButton *clearnButton;
@property (nonatomic, strong)  UIButton *calculateButton;

@property (nonatomic, strong) RFDatePickerView *datePickerView;
@property (nonatomic, strong)  UILabel *pmjeLabel;
@property (nonatomic, strong)  UITextField *pmjeTextField;
@property (nonatomic, strong)  UILabel *pmjeUintLabel;

@property (nonatomic, strong)  UILabel *yllLabel;
@property (nonatomic, strong)  UITextField *yllTextField;
@property (nonatomic, strong)  UILabel *yllUintLabel;

@property (nonatomic, strong)  UILabel *txrqLabel;
@property (nonatomic, strong)  UIButton   *txrqButton;

@property (nonatomic, strong)  UILabel *dqrqLabel;
@property (nonatomic, strong)  UIButton   *dqrqButton;

@property (nonatomic, strong)  UILabel *tztsLabel;
@property (nonatomic, strong)  UITextField *tztsTextField;
@property (nonatomic, strong)  UILabel *tztsUintLabel;

@property (nonatomic, strong) UILabel *resultLabel;

@property (nonatomic, strong) IBOutlet ADBannerView *bannerView;
@property (nonatomic, strong) 	CBABData* babData;
@property (nonatomic, strong) NSMutableArray *arrHistory;

@end

@implementation CMainViewController
-(NSMutableArray*)arrHistory{
	if (_arrHistory == nil) {
		_arrHistory = [[NSMutableArray alloc] initWithCapacity:1];
	}
	return _arrHistory;
}

-(CBABData*)babData{
	if (_babData == nil) {
		_babData = [[CBABData alloc] init];
	}
	return _babData;
}

-(UILabel*)resultLabel{
    if (!_resultLabel) {
        _resultLabel = [[ UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.clearnButton.frame) + 40, SCREEN_W - 40, SCREEN_H - (CGRectGetMaxY(self.clearnButton.frame) + 40))];
        _resultLabel.numberOfLines = 4;
    }
    return _resultLabel;
}
//static UIEdgeInsets const kPadding = {10, 10, 10, 10};

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self.pmjeLabel setText:@"测试位置"];
//    [self.yllLabel setText:@"测试位置"];
//    [self.txrqLabel setText:@"测试位置"];
//    [self.dqrqLabel setText:@"测试位置"];
//    [self.tztsLabel setText:@"测试位置"];
// 
//    WeakSelf(weaKSelf);
////    [self.yllLabel mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.center.equalTo(weaKSelf.view);
////    }];
//    
//    UILabel *sv = [UILabel new];
////    [sv showPlaceHolder];
//    sv.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:sv];
//    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(weaKSelf.view);
//        make.size.mas_equalTo(CGSizeMake(300, 300));
//    }];
//    
//    int padding1 = 10;
//    UILabel *sv2 = [UILabel new];
//    //    [sv showPlaceHolder];
//    sv2.backgroundColor = [UIColor redColor];
//    [sv addSubview:sv2];
//    
//    UILabel *sv3 = [UILabel new];
//    //    [sv showPlaceHolder];
//    sv3.backgroundColor = [UIColor greenColor];
//    [sv addSubview:sv3];
//
//    
//    [sv2 mas_makeConstraints:^(MASConstraintMaker *make) {
//                 make.centerY.mas_equalTo(sv.mas_centerY);
//                 make.left.equalTo(sv.mas_left).with.offset(padding1);
//                 make.right.equalTo(sv3.mas_left).with.offset(-padding1);
//                 make.height.mas_equalTo(@150);
//
//        make.width.equalTo(sv3);
//    }];
//
//    [sv3 mas_makeConstraints:^(MASConstraintMaker *make) {
//          make.centerY.mas_equalTo(sv.mas_centerY);
//         make.left.equalTo(sv2.mas_right).with.offset(padding1);
//                make.right.equalTo(sv.mas_right).with.offset(-padding1);
//                make.height.mas_equalTo(@150);
//                make.width.equalTo(sv2);
//    }];
//    
//    
//UILabel *displayNum = [[UILabel alloc]init];
//[sv addSubview:displayNum];
//    sv.backgroundColor = [UIColor clearColor];
//    sv.layer.borderColor = [UIColor redColor].CGColor;
//    sv.layer.borderWidth = 1.0f;
//   displayNum.text = @"fadfasdfad";
//    displayNum.font = [UIFont fontWithName:@"HeiTi SC" size:70];
//    displayNum.backgroundColor = [UIColor greenColor];
//    displayNum.textColor = [UIColor greenColor];
////        displayNum.textAlignment = NSTextAlignmentRight;
//    [displayNum mas_makeConstraints:^(MASConstraintMaker *make){
//        
//        make.left.equalTo(sv).with.offset(50);
//        make.right.equalTo(sv).with.offset(-50);
//        make.height.equalTo(sv);
////        make.bottom.equalTo(sv).width.offset(-20);
//        
////        make.left.equalTo(sv).with.offset(50);
//////        make.left.equalTo(sv).width.offset(50);
////
////        make.right.equalTo(sv).with.offset(-50);
//        make.bottom.and.top.equalTo(sv).with.offset(0);
//    }];
    
//    [self.yllLabel makeConstraints:^(nscontr *make) {
//        make.top.equalTo(@20);
//        make.left.equalTo(@20);
//        make.width.equalTo(@(CGRectGetWidth(_yllLabel.frame)));
//        make.height.equalTo(@(CGRectGetHeight(_yllLabel.frame)));
//    }];
    
//    _yllLabel make
    
//    [self.yllLabel makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.yllLabel).insets(kPadding);
//        make.top.equalTo(self.yllLabel).insets(kPadding);
//    }];
//    

    
//    [_yllUintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(_yllLabel.mas_centerY);
//        make.right.equalTo(@20);
//        make.width.equalTo(@(CGRectGetWidth(_yllUintLabel.frame)));
//        make.height.equalTo(@(CGRectGetHeight(_yllUintLabel.frame)));
//    }];
//    
//    [_yllTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(_yllLabel.mas_centerY);
//        make.right.equalTo(_yllUintLabel.mas_left);
//        make.width.equalTo(@(CGRectGetWidth(_yllTextField.frame)));
//        make.height.equalTo(@(CGRectGetHeight(_yllTextField.frame)));
//    }];
    
//    [self.jxtsTextField setText:@"测试位置"];
//    [self.pmjeTextField setText:@"测试位置"];
//    [self.pmjeTextField setText:@"测试位置"];
//    [self.pmjeTextField setText:@"测试位置"];
//    [self.pmjeTextField setText:@"测试位置"];
//    [self.pmjeTextField setText:@"测试位置"];
    
    [[EHDataMgrModule shareInstance] initQueue];
//    [self setTitle:@"承兑贴现计算"];
//    [self hiddeBackButton];
//    [self setBackButtonImage:nil];
//    [self setBackButtonText:@"分享"];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_W - 40 - 15 ,20, NAVBAR_H - 20, NAVBAR_H - 20)];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBtn setTitle:@"记录" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(showHistory) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.titleLabel.font = Font17;
    [self addRightButton:rightBtn];

    [self.view addSubview:self.mBgView];
    [self.view addSubview:self.pmjeLabel];
    [self.view addSubview:self.pmjeTextField];
    [self.view addSubview:self.pmjeUintLabel];
    
    [self.view addSubview:self.yllLabel];
    [self.view addSubview:self.yllTextField];
    [self.view addSubview:self.yllUintLabel];
    
    [self.view addSubview:self.txrqLabel];
    [self.view addSubview:self.txrqButton];
    
    [self.view addSubview:self.dqrqLabel];
    [self.view addSubview:self.dqrqButton];

//    WeakSelf(weaKSelf);
    __weak typeof(self.view )weaskSuperView = self.view;
    
    [_mBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weaskSuperView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    //票面金额
    [self.pmjeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weaskSuperView).with.offset(NAVBAR_H + 20);
        make.left.equalTo(weaskSuperView).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 25));
    }];
    
    [self.pmjeUintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weaskSuperView).with.offset(20);
        make.centerY.equalTo(_pmjeLabel.mas_centerY);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(_pmjeLabel.mas_height);
    }];
    
    [self.pmjeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_pmjeLabel.mas_right).with.offset(5);
        make.right.equalTo(_pmjeUintLabel.mas_left).with.offset(-5);
        make.centerY.equalTo(_pmjeLabel.mas_centerY);
        make.height.mas_equalTo(_pmjeLabel.mas_height);
    }];
    
    //月利率
    [self.yllLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pmjeLabel.mas_bottom).with.offset(20);
        make.left.equalTo(weaskSuperView).with.offset(20);
        make.size.equalTo(_pmjeLabel);
    }];
    
    [self.yllUintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weaskSuperView).with.offset(20);
        make.centerY.equalTo(_yllLabel.mas_centerY);
        make.size.equalTo(_pmjeUintLabel);
    }];
    
    [self.yllTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_yllLabel.mas_right).with.offset(5);
        make.right.equalTo(_yllUintLabel.mas_left).with.offset(-5);
        make.centerY.equalTo(_yllLabel.mas_centerY);
        make.height.mas_equalTo(_yllLabel.mas_height);
    }];
    
    //贴现日期
    [self.txrqLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_yllLabel.mas_bottom).with.offset(20);
        make.left.equalTo(weaskSuperView).with.offset(20);
        make.size.equalTo(_pmjeLabel);
    }];
    
    [self.txrqButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_txrqLabel.mas_right).with.offset(5);
        make.centerY.equalTo(_txrqLabel.mas_centerY);
        make.width.mas_equalTo(_yllTextField.mas_width);
        make.height.mas_equalTo(_yllLabel.mas_height);
    }];
    
    //到期日期
    [self.dqrqLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_txrqLabel.mas_bottom).with.offset(20);
        make.left.equalTo(weaskSuperView).with.offset(20);
        make.size.equalTo(_pmjeLabel);
    }];
    
    [self.dqrqButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_dqrqLabel.mas_right).with.offset(5);
        make.centerY.equalTo(_dqrqLabel.mas_centerY);
        make.width.mas_equalTo(_yllTextField.mas_width);
        make.height.mas_equalTo(_yllLabel.mas_height);
    }];
    
    //日期选择控件。
	[self.view addSubview:self.datePickerView];
    
    [self initViewAndData];
    self.txrqButton.showsTouchWhenHighlighted = self.dqrqButton.showsTouchWhenHighlighted = YES;
    [self autoLayOutView];
}

-(void)backBtnPressed:(UIButton *)sender{
    EHSharePageView *view = [[EHSharePageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) withDelegate:self];
    [view showSharePageView:YES];
}

-(void)autoLayOutView{
//    self.mBgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

-(void)initViewAndData{
    [self.calculateButton setEnabled:NO];
    [self.clearnButton setEnabled:NO];

    [self.pmjeTextField setText:nil];
    self.yllTextField.text = nil;
    self.tztsTextField.text = nil;
    self.resultLabel = nil;
//    self.jxtsTextField.text = nil;
//    self.txlxTextField.text = nil;
//    self.txjeTextField.text = nil;
    self.babData.txrq = [NSDate date];
    NSDateFormatter *formattter = [[NSDateFormatter alloc] init];
    [formattter setDateFormat:@"yyyy年MM月dd日"];
    NSString* temp = [formattter stringFromDate:[NSDate date]];
//    [self.txrqTextField settit];
//    [self.dqrqTextField setText:temp];
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
#pragma mark - ViewConstrouct
- (RFDatePickerView*)datePickerView{
    if (!_datePickerView) {
        _datePickerView = [[RFDatePickerView alloc] initWithFrame:CGRectMake(0,
                                                                             [UIScreen mainScreen].bounds.size.height,
                                                                             [UIScreen mainScreen].bounds.size.width,246)];
        _datePickerView.m_delegate = self;
    }
    return _datePickerView;
}

-(UIImageView*)mBgView{
    if (!_mBgView) {
        _mBgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    }
    return _mBgView;
}

-(UILabel*)pmjeLabel{
    if (!_pmjeLabel) {
        _pmjeLabel = [[UILabel alloc] init];
        [_pmjeLabel setText:@"票面金额"];
        [_pmjeLabel setText:@"测试位置"];
        [_pmjeLabel setFont:Font15];
        [_pmjeLabel setTextColor:Color_white_50];
    }
    return _pmjeLabel;
}

-(UITextField*)pmjeTextField{
    if (!_pmjeTextField) {
        _pmjeTextField = [[UITextField alloc] init];
        [_pmjeTextField setBackgroundColor:[UIColor whiteColor]];
        _pmjeTextField.textAlignment = NSTextAlignmentRight;
        _pmjeTextField.borderStyle = UITextBorderStyleRoundedRect;
        _pmjeTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _pmjeTextField;
}

-(UILabel*)pmjeUintLabel{
    if (!_pmjeUintLabel) {
        _pmjeUintLabel = [[UILabel alloc] init];
        _pmjeUintLabel.text = @"万";
        _pmjeUintLabel.text = @"位";
        _pmjeUintLabel.font = Font15;
        _pmjeUintLabel.textColor = Color_white_50;
    }
    return _pmjeUintLabel;
}

-(UILabel*)yllLabel{
    if (!_yllLabel) {
        _yllLabel = [[UILabel alloc] init];
        [_yllLabel setText:@"票面金额"];
        [_yllLabel setText:@"测试位置"];
        [_yllLabel setFont:Font15];
        [_yllLabel setTextColor:Color_white_50];
    }
    return _yllLabel;
}

-(UITextField*)yllTextField{
    if (!_yllTextField) {
        _yllTextField = [[UITextField alloc] init];
        [_yllTextField setBackgroundColor:[UIColor whiteColor]];
        _yllTextField.textAlignment = NSTextAlignmentRight;
        _yllTextField.borderStyle = UITextBorderStyleRoundedRect;
        _yllTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _yllTextField;
}

-(UILabel*)yllUintLabel{
    if (!_yllUintLabel) {
        _yllUintLabel = [[UILabel alloc] init];
        _yllUintLabel.text = @"万";
        _yllUintLabel.text = @"位";
        _yllUintLabel.font = Font15;
        _yllUintLabel.textColor = Color_white_50;
    }
    return _yllUintLabel;
}


-(UILabel*)txrqLabel{
    if (!_txrqLabel) {
        _txrqLabel = [[UILabel alloc] init];
        [_txrqLabel setText:@"贴现日期"];
//        [_txrqLabel setText:@"测试位置"];
        [_txrqLabel setFont:Font15];
        [_txrqLabel setTextColor:Color_white_50];
    }
    return _txrqLabel;
}

-(UIButton*)txrqButton{
    if (!_txrqButton) {
        _txrqButton = [[UIButton alloc] init];
        [_txrqButton setBackgroundColor:[UIColor whiteColor]];
        _txrqButton.titleLabel.textAlignment = NSTextAlignmentRight;
        _txrqButton.layer.cornerRadius = 5.0f;
    }
    return _txrqButton;
}


-(UILabel*)dqrqLabel{
    if (!_dqrqLabel) {
        _dqrqLabel = [[UILabel alloc] init];
        [_dqrqLabel setText:@"到期日期"];
        //        [_txrqLabel setText:@"测试位置"];
        [_dqrqLabel setFont:Font15];
        [_dqrqLabel setTextColor:Color_white_50];
    }
    return _txrqLabel;
}

-(UIButton*)dqrqButton{
    if (!_dqrqButton) {
        _dqrqButton = [[UIButton alloc] init];
        [_dqrqButton setBackgroundColor:[UIColor whiteColor]];
        _dqrqButton.titleLabel.textAlignment = NSTextAlignmentRight;
        _dqrqButton.layer.cornerRadius = 5.0f;
    }
    return _dqrqButton;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [_datePickerView showDatePickerView:NO];
	return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
	[self.clearnButton setEnabled:YES];
	[self.calculateButton setEnabled:YES];

	if ([textField isEqual:_tztsTextField]) {
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
	if ([textField isEqual:_pmjeTextField]) {
		self.babData.pmje = textField.text;
	}
	else if ([textField isEqual:_yllTextField])
	{
		self.babData.yll = textField.text;
	}
	else if ([textField isEqual:_tztsTextField])
	{
		self.babData.tzts = textField.text;
	}
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
	
	if ([textField isEqual:_pmjeTextField]) {
		self.babData.pmje = textField.text;
	}
	else if ([textField isEqual:_yllTextField])
	{
		self.babData.yll = textField.text;
	}
	else if ([textField isEqual:_tztsTextField])
	{
		self.babData.tzts = textField.text;
	}
	return YES;
}

//  ‰// %
-(void)datePickerViewSeldate:(NSDate*)date{
//  	NSDateFormatter *formattter = [[NSDateFormatter alloc] init];
//	[formattter setDateFormat:@"yyyy年MM月dd日"];
//	if (_datePickerView.tag == 1) {
//		_babData.txrq = date;
//		NSString* temp = [formattter stringFromDate:date];
//		[self.txrqTextField setText:temp];
//		self.babData.txrqstr = temp;
//	}
//	else if (_datePickerView.tag ==2){
//		_babData.dqrq = date;
//		NSString* temp = [formattter stringFromDate:date];
//		[self.dqrqTextField setText:temp];
//		self.babData.dqrqstr = temp;
//	}
}

-(IBAction)txrqButtonAction:(UIButton*)sender{
	[self closeKeyBoarad];
//    self.txrqTextField.text;
//    NSDateFormatter *formattter = [[NSDateFormatter alloc] init];
//    [formattter setDateFormat:@"yyyy年MM月dd日"];
//    NSDate *date = [formattter dateFromString:self.txrqTextField.text];
//	_datePickerView.tag = 1;
//    [_datePickerView showDatePickerView:YES WithDate:date];
//    
//    date = [formattter dateFromString:self.dqrqTextField.text];
//    [_datePickerView setDatePickerMaxData:date];
}

-(IBAction)dqrqButtonAction:(UIButton*)sender{
//	[self closeKeyBoarad];
//    NSDateFormatter *formattter = [[NSDateFormatter alloc] init];
//    [formattter setDateFormat:@"yyyy年MM月dd日"];
//    NSDate *date = [formattter dateFromString:self.dqrqTextField.text];
//	_datePickerView.tag = 2;
//	[_datePickerView showDatePickerView:YES WithDate:date];
//
//    date = [formattter dateFromString:self.txrqTextField.text];
//    [_datePickerView setDatePickerMinData:date];

}

-(IBAction)calculateButtonAction:(id)sender{
	[self closeKeyBoarad];
	//check data
	
	if (_babData.pmje.length <= 0) {
		[self showMessage:@"请输入票面金额"];
		[self.pmjeTextField becomeFirstResponder];
		return;
	}
	else if (_babData.yll.length <= 0 || [_babData.yll intValue] >= 1000){
		[self showMessage:@"请输入正确的月利率"];
		[self.yllTextField becomeFirstResponder];
		return;
	}
	NSTimeInterval val111 = [_babData.dqrq timeIntervalSince1970];
	NSInteger day1 = val111 / (60 * 60 * 24);
	NSInteger day2 = [_babData.txrq timeIntervalSince1970] / (60 *60* 24);
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
	double pmje = [_babData.pmje doubleValue] * 10000;
	double yll = [_babData.yll doubleValue] / 1000;
	
	NSTimeInterval val =  [_babData.dqrq timeIntervalSinceDate:_babData.txrq];
	NSInteger days=((NSInteger)(val+0.5))/(3600*24);
	days = day1 - day2;
	days = days + [_babData.tzts intValue];
	double temp  = pmje * days * (yll/30);
	
	self.babData.jxts = [NSString stringWithFormat:@"%ld", (long)days];
//	[self.jxtsTextField setText:babData.jxts];
	
	//
	NSInteger temp1 = (NSInteger)(temp * numGap + 0.5);
	double   temp2 = ((double) temp1) / numGap;
	self.babData.txlx = [NSString stringWithFormat:@"%.2f", temp2];
//	[self.txlxTextField setText:babData.txlx];

	double temp3 =  (double) ( pmje * numGap - temp1) / numGap;
	
	self.babData.txje = [NSString stringWithFormat:@"%.2f", temp3];
//	[self.txjeTextField setText:babData.txje];
	
    [self.resultLabel setAttributedText:[_babData getResultString]];
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
	[_datePickerView showDatePickerView:NO];
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
