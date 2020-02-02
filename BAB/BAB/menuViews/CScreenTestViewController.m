//
//  CScreenTestViewController.m
//  BAB
//
//  Created by GaoAng on 2020/2/2.
//  Copyright © 2020 selfcom. All rights reserved.
//

#import "CScreenTestViewController.h"

@interface CScreenTestViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation CScreenTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mNavBarView.backgroundColor = [UIColor systemBlueColor];
    [self.view addSubview:self.scrollView];
    [self addScrollSubviews];
}


- (UIScrollView*)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVBAR_H, SCREEN_W, SCREEN_H - NAVBAR_H)];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.pagingEnabled = YES;

    }
    return _scrollView;
}

- (void)addScrollSubviews{
    
    NSArray *colors = @[[UIColor redColor], [UIColor greenColor], [UIColor blackColor], [UIColor whiteColor]];
    for (NSInteger i = 0; i< colors.count; i++) {
        UIColor *color = colors[i];

        UIView *view  = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_W*i, 0, SCREEN_W, CGRectGetHeight(self.scrollView.bounds))];
        view.backgroundColor = color;
        [self.scrollView addSubview:view];
        
        UILabel *pageLabel = [[UILabel alloc] init];
        [view addSubview:pageLabel];
        pageLabel.font = [UIFont systemFontOfSize:80];
        [pageLabel setText:[NSString stringWithFormat:@"%ld",i+1]];
        pageLabel.textAlignment = NSTextAlignmentCenter;
        NSInteger index = i+1;
        if (i == colors.count - 1) {
            index = 0;
        }
        pageLabel.textColor = colors[index];
        [pageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(view);
            make.centerY.mas_equalTo(view).offset(-80);
            make.width.height.mas_equalTo(400);
        }];
        
        
//        [self debugView:view];
    }
    [self.scrollView setContentSize:CGSizeMake(SCREEN_W * colors.count, CGRectGetHeight(self.scrollView.bounds))];
}

@end
