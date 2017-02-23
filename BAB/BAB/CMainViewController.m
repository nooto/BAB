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
#import "Utility/UtilityHelper.h"
#import "CBabResultView.h"
@interface CMainViewController () <EHSharePageViewdDelegate, UITextFieldDelegate, ADBannerViewDelegate>

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

@property (nonatomic, strong) ADBannerView *mBannerView;
@property (nonatomic, strong) 	CBABData* babData;
@property (nonatomic, strong) NSMutableArray *arrHistory;


@property (nonatomic, assign) APPType  mAppType; //App le

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
        _resultLabel = [[UILabel alloc] init];
        _resultLabel.layer.borderColor = [UIColor grayColor].CGColor;;
        _resultLabel.layer.borderWidth = 0.5f;
        _resultLabel.layer.cornerRadius = 15.0f;
        _resultLabel.backgroundColor = Color_white_30;
        _resultLabel.textColor = Color_black_60;
        _resultLabel.textColor = [UIColor redColor];
        _resultLabel.layer.masksToBounds = YES;
        _resultLabel.numberOfLines = 3;
        _resultLabel.font = Font16;
        _resultLabel.hidden = YES;
    }
    return _resultLabel;
}
//static UIEdgeInsets const kPadding = {10, 10, 10, 10};

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[EHDataMgrModule shareInstance] initQueue];
    [self setTitle:@"承兑贴现计算"];
//    [self hiddeBackButton];
    [self setBackButtonImage:nil];
    [self setBackButtonText:@"分享"];
    
    self.mAppType = [Utility AppType];
    
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

    
    [self.view addSubview:self.tztsLabel];
    [self.view addSubview:self.tztsTextField];
    [self.view addSubview:self.tztsUintLabel];
    
    [self.view addSubview:self.calculateButton];
    [self.view addSubview:self.clearnButton];
    
    [self.view addSubview:self.resultLabel];
//    [self.view addSubview:self.mBannerView];
    
    //日期选择控件。
    [self.view addSubview:self.datePickerView];

    __weak typeof(self.view )weaskSuperView = self.view;
    
    [_mBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.width.mas_equalTo(SCREEN_W);
        make.size.height.mas_equalTo(SCREEN_H);
        make.edges.equalTo(weaskSuperView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    //票面金额
    [self.pmjeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weaskSuperView).with.offset(NAVBAR_H + 20);
        make.left.equalTo(weaskSuperView).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 35));
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
//    self.dqrqLabel.backgroundColor = [UIColor redColor];
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
    
    
    //调整天数
    [self.tztsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_dqrqLabel.mas_bottom).with.offset(20);
        make.left.equalTo(weaskSuperView).with.offset(20);
        make.size.equalTo(_pmjeLabel);
    }];
    
    [self.tztsUintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weaskSuperView).with.offset(20);
        make.centerY.equalTo(_tztsLabel.mas_centerY);
        make.size.equalTo(_pmjeUintLabel);
    }];
    
    [self.tztsTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tztsLabel.mas_right).with.offset(5);
        make.right.equalTo(_tztsUintLabel.mas_left).with.offset(-5);
        make.centerY.equalTo(_tztsLabel.mas_centerY);
        make.height.mas_equalTo(_tztsLabel.mas_height);
    }];

    
    CGFloat padding = 30;
    [self.clearnButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tztsLabel.mas_bottom).with.offset(20);
        make.left.equalTo(weaskSuperView).with.offset(padding);
        make.right.equalTo(_calculateButton.mas_left).with.offset(-padding);
        make.height.equalTo(_yllLabel.mas_height);
        make.width.equalTo(_calculateButton.mas_width);
    }];
    
    [self.calculateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_clearnButton.mas_right).with.offset(padding);
        make.right.equalTo(weaskSuperView).with.offset(-padding);
        make.centerY.equalTo(_clearnButton.mas_centerY);
        make.height.equalTo(_clearnButton.mas_height);
        make.width.equalTo(_clearnButton.mas_width);
    }];
    
    //有广告
    if (self.mAppType == APP_FREE) {
        [self.view addSubview:self.mBannerView];

        //jieguo
        //    CGSize textSize = [@"测试" sizeWithAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:_resultLabel.font,NSFontAttributeName, nil]];
        //    CGFloat labelHieht = textSize.height * 5;
        [self.resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_pmjeLabel.mas_left);
            make.right.equalTo(weaskSuperView).with.offset(-20);
            make.top.equalTo(_clearnButton.mas_bottom).with.offset(20);
            make.bottom.equalTo(_mBannerView.mas_top).with.offset(-20);
        }];
    }
    //无广告
    else if (self.mAppType == APP_CHARGE){
        CGSize textSize = [@"测试" sizeWithAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:_resultLabel.font,NSFontAttributeName, nil]];
        CGFloat labelHieht = textSize.height * 5;
        [self.resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_pmjeLabel.mas_left);
                make.right.equalTo(weaskSuperView).with.offset(-20);
                make.bottom.equalTo(weaskSuperView).with.offset(-20);
                make.height.mas_equalTo(labelHieht);
        }];
    }

    [self initViewAndData];
    self.txrqButton.showsTouchWhenHighlighted = self.dqrqButton.showsTouchWhenHighlighted = YES;
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
    self.resultLabel.text = nil;
    
    self.babData.txrq = [NSDate date];
    NSDateFormatter *formattter = [[NSDateFormatter alloc] init];
    [formattter setDateFormat:@"yyyy年MM月dd日"];
    NSString* temp = [formattter stringFromDate:self.babData.txrq];
    [self.txrqButton setTitle:temp forState:UIControlStateNormal];
    
    self.babData.dqrq = [[NSDate date] dateByAddingDays:1];
    temp = [formattter stringFromDate:self.babData.dqrq];
    [self.dqrqButton setTitle:temp forState:UIControlStateNormal];
    
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


-(ADBannerView*)mBannerView{
    if (!_mBannerView) {
        _mBannerView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
//        _mBannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
        [_mBannerView setFrame:CGRectMake(0, SCREEN_H - 45 , SCREEN_W, 45)];
        _mBannerView.delegate = self;
        _mBannerView.alpha = 0.0f;
    }
    return _mBannerView;
}
-(UILabel*)pmjeLabel{
    if (!_pmjeLabel) {
        _pmjeLabel = [UILabel new];
        [_pmjeLabel setText:@"票面金额"];
        [_pmjeLabel setFont:Font15];
        [_pmjeLabel setTextColor:Color_white_50];
    }
    return _pmjeLabel;
}

-(UITextField*)pmjeTextField{
    if (!_pmjeTextField) {
        _pmjeTextField = [UITextField new];
        [_pmjeTextField setBackgroundColor:[UIColor whiteColor]];
        _pmjeTextField.textAlignment = NSTextAlignmentCenter;
        _pmjeTextField.borderStyle = UITextBorderStyleRoundedRect;
        _pmjeTextField.keyboardType = UIKeyboardTypeDecimalPad;
        _pmjeTextField.delegate = self;
    }
    return _pmjeTextField;
}

-(UILabel*)pmjeUintLabel{
    if (!_pmjeUintLabel) {
        _pmjeUintLabel = [UILabel new];
        _pmjeUintLabel.text = @"万";
        _pmjeUintLabel.font = Font15;
        _pmjeUintLabel.textColor = Color_white_50;
    }
    return _pmjeUintLabel;
}

-(UILabel*)yllLabel{
    if (!_yllLabel) {
        _yllLabel = [UILabel new];
        [_yllLabel setText:@"月利率"];
        [_yllLabel setFont:Font15];
        [_yllLabel setTextColor:Color_white_50];
    }
    return _yllLabel;
}

-(UITextField*)yllTextField{
    if (!_yllTextField) {
        _yllTextField = [UITextField new];
        [_yllTextField setBackgroundColor:[UIColor whiteColor]];
        _yllTextField.textAlignment = NSTextAlignmentCenter;
        _yllTextField.borderStyle = UITextBorderStyleRoundedRect;
        _yllTextField.keyboardType = UIKeyboardTypeDecimalPad;
        _yllTextField.delegate = self;
    }
    return _yllTextField;
}

-(UILabel*)yllUintLabel{
    if (!_yllUintLabel) {
        _yllUintLabel = [UILabel new];
        _yllUintLabel.text = @"‰";
        _yllUintLabel.font = Font15;
        _yllUintLabel.textColor = Color_white_50;
    }
    return _yllUintLabel;
}


-(UILabel*)txrqLabel{
    if (!_txrqLabel) {
        _txrqLabel = [UILabel new];
        [_txrqLabel setText:@"贴现日期"];
        [_txrqLabel setFont:Font15];
        [_txrqLabel setTextColor:Color_white_50];
    }
    return _txrqLabel;
}

-(UIButton*)txrqButton{
    if (!_txrqButton) {
        _txrqButton = [UIButton new];
        [_txrqButton setBackgroundColor:[UIColor whiteColor]];
        _txrqButton.titleLabel.font = Font15;
        _txrqButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_txrqButton setTitleColor:Color_black_100 forState:UIControlStateNormal];
        _txrqButton.layer.cornerRadius = 5.0f;
        [_txrqButton addTarget:self action:@selector(txrqButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _txrqButton;
}


-(UILabel*)dqrqLabel{
    if (!_dqrqLabel) {
        _dqrqLabel = [UILabel new];
        [_dqrqLabel setText:@"到期日期"];
        //        [_txrqLabel setText:@"测试位置"];
        [_dqrqLabel setFont:Font15];
        [_dqrqLabel setTextColor:Color_white_50];
    }
    return _dqrqLabel;
}

-(UIButton*)dqrqButton{
    if (!_dqrqButton) {
        _dqrqButton = [[UIButton alloc] init];
        [_dqrqButton setBackgroundColor:[UIColor whiteColor]];
        _dqrqButton.titleLabel.font = Font15;
        _dqrqButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_dqrqButton addTarget:self action:@selector(dqrqButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_dqrqButton setTitleColor:Color_black_100 forState:UIControlStateNormal];
        _dqrqButton.layer.cornerRadius = 5.0f;
    }
    return _dqrqButton;
}

-(UILabel*)tztsLabel{
    if (!_tztsLabel) {
        _tztsLabel = [[UILabel alloc] init];
        [_tztsLabel setText:@"调整天数"];
        //[_yllLabel setText:@"测试位置"];
        [_tztsLabel setFont:Font15];
        [_tztsLabel setTextColor:Color_white_50];
    }
    return _tztsLabel;
}

-(UITextField*)tztsTextField{
    if (!_tztsTextField) {
        _tztsTextField = [[UITextField alloc] init];
        [_tztsTextField setBackgroundColor:[UIColor whiteColor]];
        _tztsTextField.textAlignment = NSTextAlignmentCenter;
        _tztsTextField.borderStyle = UITextBorderStyleRoundedRect;
        _tztsTextField.keyboardType = UIKeyboardTypeNumberPad;
        _tztsTextField.delegate = self;
    }
    return _tztsTextField;
}

-(UILabel*)tztsUintLabel{
    if (!_tztsUintLabel) {
        _tztsUintLabel = [[UILabel alloc] init];
        _tztsUintLabel.text = @"天";
        _tztsUintLabel.font = Font15;
        _tztsUintLabel.textColor = Color_white_50;
    }
    return _tztsUintLabel;
}


-(UIButton*)clearnButton{
    if (!_clearnButton) {
        _clearnButton = [[UIButton alloc] init];
        [_clearnButton setBackgroundColor:[UIColor whiteColor]];
        _clearnButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_clearnButton setTitle:@"重置" forState:UIControlStateNormal];
        [_clearnButton setTitleColor:Color_black_60 forState:UIControlStateNormal];
        _clearnButton.titleLabel.font = Font15;
        [_clearnButton addTarget:self action:@selector(clearButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _clearnButton.layer.cornerRadius = 5.0f;
    }
    return _clearnButton;
}
-(UIButton*)calculateButton{
    if (!_calculateButton) {
        _calculateButton = [[UIButton alloc] init];
        _calculateButton.titleLabel.font = Font15;
        [_calculateButton setBackgroundColor:[UIColor whiteColor]];
        _calculateButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_calculateButton setTitle:@"计算" forState:UIControlStateNormal];
        [_calculateButton setTitleColor:Color_black_60 forState:UIControlStateNormal];
        [_calculateButton addTarget:self action:@selector(calculateButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _calculateButton.layer.cornerRadius = 5.0f;
    }
    return _calculateButton;
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
			){
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
			){
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
  	NSDateFormatter *formattter = [[NSDateFormatter alloc] init];
	[formattter setDateFormat:@"yyyy年MM月dd日"];
	if (_datePickerView.tag == 1) {
		_babData.txrq = date;
        [self.txrqButton setTitle:_babData.txrqstr forState:UIControlStateNormal];
	}
	else if (_datePickerView.tag ==2){
		_babData.dqrq = date;
        [self.dqrqButton setTitle:_babData.dqrqstr forState:UIControlStateNormal];
	}
}

-(IBAction)txrqButtonAction:(UIButton*)sender{
	[self closeKeyBoarad];
	_datePickerView.tag = 1;
    [_datePickerView showDatePickerView:YES WithDate:self.babData.txrq];
    [_datePickerView setDatePickerMaxData:self.babData.dqrq];
}

-(IBAction)dqrqButtonAction:(UIButton*)sender{
	[self closeKeyBoarad];
	_datePickerView.tag = 2;
	[_datePickerView showDatePickerView:YES WithDate:self.babData.dqrq];
    [_datePickerView setDatePickerMinData:self.babData.txrq];
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
    
//	NSTimeInterval val111 = [_babData.dqrq timeIntervalSince1970];
//	NSInteger day1 = val111 / (60 * 60 * 24);
//	NSInteger day2 = [_babData.txrq timeIntervalSince1970] / (60 *60* 24);
//	if (day1 <= day2) {
//		[self showMessage:@"到期日期要晚于贴现日期。"];
//		return;
//	}
    
    if ([_babData.txrq isLaterThanDate:_babData.dqrq]) {
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
	
//	NSTimeInterval val =  [_babData.dqrq timeIntervalSinceDate:_babData.txrq];
//	NSInteger days=((NSInteger)(val+0.5))/(3600*24);
//	days = day1 - day2;
    NSInteger  days = [_babData.dqrq daysAfterDate:_babData.txrq];
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
    self.resultLabel.hidden = NO;

    [DBHelper inserTtBABData:self.babData];
}


-(IBAction)clearButtonAction:(id)sender{
    self.resultLabel.hidden = YES;
	[self closeKeyBoarad];
    [self initViewAndData];
}
-(void)showHistory{
    HistoryViewController *vc = [[HistoryViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
#pragma mark - sharePage
-(void)sharePageViewDidFinshShare:(BOOL)issuccess withMessage:(NSString *)message{
    if (issuccess) {
        [self showMessage:@"分享成功"];
    }
    else{
        [self showMessage:message];
    }
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


- (void)showMessage:(NSString*)msg{
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
														message:msg
													   delegate:nil
											  cancelButtonTitle:nil
											  otherButtonTitles:@"确定", nil];
	[alertView show];
	
}


@end
