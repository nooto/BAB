//
//  BABNavigationController.m
//  BAB
//
//  Created by GaoAng on 15/8/29.
//  Copyright (c) 2015年 selfcom. All rights reserved.
//

#import "BABNavigationController.h"

@interface BABNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation BABNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    id taret = self.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *panGesture  = [[UIPanGestureRecognizer alloc] initWithTarget:taret action:@selector(handleNavigationTransition:)];
    panGesture.delegate = self;
    [self.view addGestureRecognizer:panGesture];
    self.interactivePopGestureRecognizer.enabled = NO;
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (self.childViewControllers.count == 1) {
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
