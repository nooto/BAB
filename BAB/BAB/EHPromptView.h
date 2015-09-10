//
//  EHPromptView.h
//  EHouse
//
//  Created by user on 15/4/2.
//  Copyright (c) 2015年 wondershare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EHPromptView : UIView
-(id)initWithPromptString:(NSString*)PromptText complete:(void(^)())finish;
-(id)initWithPromptString:(NSString*)PromptText  image:(NSString*)name complete:(void(^)())finish;
-(void)show:(BOOL)show;
@end
