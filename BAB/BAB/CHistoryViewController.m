//
//  CHistoryViewController.m
//  BAB
//
//  Created by GaoAng on 14-4-17.
//  Copyright (c) 2014年 selfcom. All rights reserved.
//

#define ScreenWidth                      [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                     [[UIScreen mainScreen] bounds].size.height

#import "CHistoryViewController.h"
@interface CHistoryViewController ()
@property (nonatomic, weak) UIImageView  *mBgView;
@end

@implementation CHistoryViewController
@synthesize listView,arrHistory;
@synthesize emptyView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"记录";
	
	UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"返回"
															 style:UIBarButtonItemStylePlain
															target:self
															action:@selector(cancelAction:)];
	[left setTintColor:[UIColor colorWithWhite:1 alpha:0.8f]];
    self.navigationItem.leftBarButtonItem =left;
	
	
	UIBarButtonItem *right =  [[UIBarButtonItem alloc] initWithTitle:@"清空" style:UIBarButtonItemStylePlain target:self action:@selector(clearHistory:)];
	[right setTintColor:[UIColor colorWithWhite:1 alpha:0.8f]];
	self.navigationItem.rightBarButtonItem =right;
	
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSData *saveAccount = [defaults objectForKey:@"history"];
	self.arrHistory = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:saveAccount];
    // Do any additional setup after loading the view from its nib.
	
//	UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]
//										   initWithTarget:self
//										   action:@selector(handleSwipeLeft)];
//	swipeLeft.direction = UISwipeGestureRecognizerDirectionRight;
//	[self.listView addGestureRecognizer:swipeLeft];
//	[self.emptyView addGestureRecognizer:swipeLeft];
    
//    [self.view addSubview:self.bannerView];
//    self.bannerView.delegate = self;

    [self.listView setBackgroundColor:[UIColor clearColor]];
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    [image setFrame:self.view.bounds];
    [self.view addSubview:image];
    self.mBgView = image;
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
		[self.emptyView setHidden:YES];
	}
	else{
//		[self.emptyView addGestureRecognizer:swipeLeft];
		[self.emptyView setHidden:NO];
	}
}
//-(void)handleSwipeLeft{
//	[self.navigationController popViewControllerAnimated:YES];
//}

-(void)cancelAction:(id)sender{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)clearHistory:(id)sender{
	[self.arrHistory removeAllObjects];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSData *list = [NSKeyedArchiver archivedDataWithRootObject:arrHistory];
	[defaults setObject:list forKey:@"history"];
	[defaults synchronize];
	[self.listView reloadData];
	
	[self.emptyView setHidden:NO];
	
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    _mBgView.hidden = arrHistory.count > 0 ? NO:YES;
//    _mBgView.hidden = arrHistory.count > 0 ? NO:YES;
    return [arrHistory count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
	CHistoryViewCell *cell =(CHistoryViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CHistoryViewCell" owner:self options:nil];
#ifdef __IPHONE_2_1
        cell = [nib objectAtIndex:0];
#else
        cell = [nib objectAtIndex:1];
#endif
		[cell.textLabel setBackgroundColor:[UIColor clearColor]];
		[cell.textLabel setFont:[UIFont systemFontOfSize:16.0f]];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		if (indexPath.row >= 0 && indexPath.row < [arrHistory count]) {
			CBABData *data = (CBABData*)[arrHistory objectAtIndex:indexPath.row];
			[cell.pmje setText:[NSString stringWithFormat:@"%@万元",data.pmje]];
			[cell.yll setText:[NSString stringWithFormat:@"%@‰",data.yll]];
			[cell.txrq setText:data.txrqstr];
			[cell.dqrq setText:data.dqrqstr];
			[cell.tzts setText:data.tzts? [NSString stringWithFormat:@"%@天",data.tzts]: @"无"];
			
			[cell.jxts setText:[NSString stringWithFormat:@"%@ 天",data.jxts]];
			[cell.txlx setText:[NSString stringWithFormat:@"%@ 元",data.txlx]];
			[cell.txje setText:[NSString stringWithFormat:@"%@ 元",data.txje]];
			
			[cell.jssj setText:data.jssj];
		}
		[cell setBackgroundView:nil];
		[cell setBackgroundColor:[UIColor clearColor]];

    }
    
    return cell;
}
@end
