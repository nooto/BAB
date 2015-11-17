//
//  EHSharePageView.m
//  EHouse
//
//  Created by GaoAng on 15/5/13.
//  Copyright (c) 2015年 wondershare. All rights reserved.
//

#import "EHSharePageView.h"
#import <ShareSDK/ShareSDK.h>
#import "WeiboSDK.h"

#define KICON @"icon"
#define KNAME @"name"
#define KTAG  @"tag"

@interface EHSharePageView ()
@property (nonatomic, strong) UIView *mBackGroundView;
@property (nonatomic, strong) UIView *mItemsView;
@property (nonatomic, strong) NSArray *arrDataSource;
@property (nonatomic, assign) id<EHSharePageViewdDelegate> m_delegate;
@end

@implementation EHSharePageView
- (id)initWithFrame:(CGRect)frame withDelegate:(id)delegate{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.mBackGroundView];
        [self addSubview:self.mItemsView];
        self.m_delegate = delegate;
    }
    return self;
}


-(NSArray*)arrDataSource{
    if (!_arrDataSource) {
        _arrDataSource = [[NSArray alloc] initWithObjects:
                          [NSDictionary dictionaryWithObjectsAndKeys:NSLocalizedString(@"sina_text", nil),   KNAME,  @"SinaIconNormal", KICON, [NSNumber numberWithInteger:ShareTypeSinaWeibo],     KTAG, nil], //sina
                          [NSDictionary dictionaryWithObjectsAndKeys:@"微信",                             KNAME,  @"WXIconNormal",   KICON,  [NSNumber numberWithInteger:ShareTypeWeixiSession],  KTAG, nil], //wechat
                          [NSDictionary dictionaryWithObjectsAndKeys:@"朋友圈", KNAME,  @"ic_friends_sel",   KICON,  [NSNumber numberWithInteger:ShareTypeWeixiTimeline], KTAG, nil], //wechat
                          [NSDictionary dictionaryWithObjectsAndKeys:NSLocalizedString(@"QQ空间", nil),       KNAME,  @"ic_qq_zone",   KICON,  [NSNumber numberWithInteger:ShareTypeQQSpace],       KTAG, nil], //QQ
                          [NSDictionary dictionaryWithObjectsAndKeys:NSLocalizedString(@"QQ", nil),          KNAME,  @"QQIconNormal",   KICON,  [NSNumber numberWithInteger:ShareTypeQQ],            KTAG, nil], //QQ
                          [NSDictionary dictionaryWithObjectsAndKeys:@"复制链接",                             KNAME,  @"ic_copy",    KICON,  [NSNumber numberWithInteger:ShareTypeOther],        KTAG, nil], //wechat
                          nil];
    }
    return _arrDataSource;
}

- (UIView*)mBackGroundView{
    if (!_mBackGroundView) {
        _mBackGroundView = [[UIView alloc] initWithFrame:self.bounds];
        [_mBackGroundView setBackgroundColor:[UIColor blackColor]];
        _mBackGroundView.alpha = 0.0f;
    }
    return _mBackGroundView;
}

- (UIView*)mItemsView{
    if (!_mItemsView) {
        _mItemsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
        [_mItemsView setBackgroundColor:[UIColor whiteColor]];
        
        CGFloat posY = 15.0f;
//        //构建itemsView
//        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, posY+10, CGRectGetWidth(_mItemsView.frame), 35)];
//        titleLabel.textAlignment = NSTextAlignmentCenter;
//        [titleLabel setText:NSLocalizedString(@"分享到", nil)];
//        [titleLabel setTextColor:Color_deepGray_666666];
//        [_mItemsView addSubview:titleLabel];
//        posY += CGRectGetHeight(titleLabel.frame);
        UIButton *button = nil;
        UILabel *namelabel = nil;
        CGFloat marginLeft = Margin_left;
        CGFloat margin =Margin_top;
        CGFloat  buttonWidht = (CGRectGetWidth(self.bounds) - marginLeft*2 - margin * 3) / 4;
        
        for (NSInteger i = 0; i < self.arrDataSource.count; i++) {
            NSInteger row = i / 4;
            NSInteger col = i % 4;
            
            NSDictionary *dict = [self.arrDataSource objectAtIndex:i];
            button = [[UIButton alloc] initWithFrame:CGRectMake(marginLeft  + col *(margin + buttonWidht),
                                                                posY + row * (buttonWidht + 30) + 5,
                                                                buttonWidht,
                                                                buttonWidht)];
            [button setImage:[UIImage imageNamed:dict[KICON]] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(shareButtonAciton:) forControlEvents:UIControlEventTouchUpInside];
            button.tag =  [dict[KTAG] integerValue];
            [_mItemsView addSubview:button];
            namelabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(button.frame), CGRectGetMaxY(button.frame)-5, CGRectGetWidth(button.frame), 30)];
            [namelabel setText:dict[KNAME]];
            [namelabel setFont:Font14];
            namelabel.textColor = Color_black_60;
            namelabel.textAlignment = NSTextAlignmentCenter;
            namelabel.adjustsFontSizeToFitWidth = YES;
            [_mItemsView addSubview:namelabel];
        }
        
        CGRect frame = _mItemsView.frame;
        frame.origin.y = CGRectGetHeight(self.bounds);
        frame.size.height = posY + (self.arrDataSource.count/4 + 1) * (buttonWidht + 30) + margin;
        [_mItemsView setFrame:frame];
    }
    return _mItemsView;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self showSharePageView:NO];
}


-(void)showSharePageView:(BOOL)show{
    if (show) {
        [[UIApplication sharedApplication].keyWindow addSubview:self];
//        WeakSelf(weakSelf);
//    [_mItemsView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf).with.offset(0);
//        make.right.equalTo(weakSelf).with.offset(0);
//        make.bottom.equalTo(weakSelf).with.offset(0);
//    }];
        [UIView animateWithDuration:0.3f animations:^{
            _mBackGroundView.alpha = 0.5f;
            _mItemsView.frame = CGRectMake(0, CGRectGetHeight(self.bounds) - CGRectGetHeight(_mItemsView.frame), CGRectGetWidth(_mItemsView.frame), CGRectGetHeight(_mItemsView.frame));
        }];
    }
    else{
        [UIView animateWithDuration:0.3f animations:^{
            _mBackGroundView.alpha = 0.0f;
            _mItemsView.frame = CGRectMake(0, CGRectGetHeight(self.bounds), CGRectGetWidth(_mItemsView.frame), CGRectGetHeight(_mItemsView.frame));
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

-(void)notiySuperView:(BOOL)issuccess withMessage:(NSString*)message{
    if (self.m_delegate && [self.m_delegate respondsToSelector:@selector(sharePageViewDidFinshShare:withMessage:)]) {
        [self.m_delegate sharePageViewDidFinshShare:issuccess withMessage:message];
    }
    [self showSharePageView:NO];
}


-(void)shareButtonAciton:(UIButton*)sender{
    __strong typeof(EHSharePageView*) _self = self;
    ShareType shareType = (ShareType)sender.tag;
    NSString* m_url = @"www.spotmau.cn";
    NSString*  m_shareContent = NSLocalizedString(@"share text content", nil);
    
    //内容。
    if (self.mShareContent) {
        m_shareContent = self.mShareContent;
    }
    
    //图片
    id<ISSCAttachment> imagePath = nil;
    if (self.mShareImage) {
        imagePath = [ShareSDK pngImageWithImage:self.mShareImage];
    }
    else{
        imagePath = [ShareSDK pngImageWithImage:[UIImage imageNamed:@"AppIcon_1"]];
    }
    
    NSString *m_title = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    
    [ShareSDK hideStatusbarMessage];
    
    //
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    
     // 分享内容协议
    id<ISSContent> shareContent = [ShareSDK content:m_shareContent
                                defaultContent:m_shareContent
                                         image:(id)imagePath
                                         title:m_title
                                           url:m_url
                                   description:m_shareContent
                                     mediaType:SSPublishContentMediaTypeNews];
    //qq
    if (ShareTypeQQ == shareType ) {
        
        [ShareSDK shareContent:shareContent
                          type:ShareTypeQQ
                   authOptions:authOptions
                 statusBarTips:YES
                        result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                            if (state == SSPublishContentStateSuccess){
                                [_self notiySuperView:YES withMessage:NSLocalizedString(@"QQ share success!", nil)];
                            
                            }
                            else if (state == SSPublishContentStateFail){
                                if ([error errorCode] == -24002){
                                    [_self notiySuperView:NO withMessage:[error errorDescription]];
                                }
                                else{
                                    [_self notiySuperView:NO withMessage:NSLocalizedString(@"QQ share faild!", nil)];
                                }
//                                DDLogError(@"发布失败!error code == %ld, error code == %@", (long)[error errorCode], [error errorDescription]);
                            }
                            else if (state == SSPublishContentStateCancel){
//                                [_self notiySuperView:NO withMessage:NSLocalizedString(@"QQ share faild!", nil)];
                            }
                        }];
        
    }
    //qq 空间
    else if (ShareTypeQQSpace == shareType){
        [ShareSDK shareContent:shareContent
                          type:ShareTypeQQSpace
                   authOptions:authOptions
                 statusBarTips:YES
                        result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                            
                            if (state == SSPublishContentStateSuccess){
                                [_self notiySuperView:YES withMessage:NSLocalizedString(@"QQ space share success!", nil)];
                            }
                            else if (state == SSPublishContentStateFail){
                                if ([error errorCode] == -24002){
                                    [_self notiySuperView:NO withMessage:[error errorDescription]];
                                }
                                else{
                                    [_self notiySuperView:NO withMessage:NSLocalizedString(@"QQ space share faild!", nil)];
                                }
//                                DDLogError(@"发布失败!error code == %ld, error code == %@", (long)[error errorCode], [error errorDescription]);
                            }
                            else if (state == SSPublishContentStateCancel){
//                                [_self notiySuperView:NO withMessage:NSLocalizedString(@"QQ share faild!", nil)];
                            }
                        }];
    }
    //新浪微博
    else  if (ShareTypeSinaWeibo == shareType ) {
        m_shareContent = [m_shareContent stringByAppendingString:@"http://www.spotmau.cn"];
        id<ISSContent> shareContent = [ShareSDK content:m_shareContent
                                         defaultContent:m_shareContent
                                                  image:(id)imagePath
                                                  title:m_title
                                                    url:m_url
                                            description:m_shareContent
                                              mediaType:SSPublishContentMediaTypeNews];
        
        BOOL hasSinaWeb = [WeiboSDK isWeiboAppInstalled];
        if (hasSinaWeb) {
            [ShareSDK clientShareContent:shareContent
                                    type:ShareTypeSinaWeibo
                           statusBarTips:NO
                                  result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                      if (state == SSPublishContentStateSuccess){
                                          [_self notiySuperView:YES withMessage:NSLocalizedString(@"sina share success!", nil)];
                                      }
                                      else if (state == SSPublishContentStateFail){
                                          [_self notiySuperView:NO withMessage:NSLocalizedString(@"sina share faild!", nil)];
//                                          DDLogError(@"发布失败!error code == %ld, error code == %@", (long)[error errorCode], [error errorDescription]);
                                      }
                                      else if (state == SSPublishContentStateCancel){
//                                          [_self notiySuperView:NO withMessage:NSLocalizedString(@"sina share faild!", nil)];
                                      }
                                  }];
        }
        else{
            if (self.m_delegate && [self.m_delegate respondsToSelector:@selector(sharePageViewWillPopWindow:)]) {
                [self.m_delegate sharePageViewWillPopWindow:self];
            }
            
            [ShareSDK shareContent:shareContent
                              type:ShareTypeSinaWeibo
                       authOptions:authOptions
                     statusBarTips:YES
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSPublishContentStateSuccess){
                                    [_self notiySuperView:YES withMessage:NSLocalizedString(@"sina share success!", nil)];
                                }
                                else if (state == SSPublishContentStateFail){
                                    [_self notiySuperView:NO withMessage:NSLocalizedString(@"sina share faild!", nil)];
//                                    DDLogError(@"发布失败!error code == %ld, error code == %@", (long)[error errorCode], [error errorDescription]);
                                }
                                else if (state == SSPublishContentStateCancel){
//                                    [_self notiySuperView:NO withMessage:NSLocalizedString(@"sina share faild!", nil)];
                                }

                            }];
        }
    }
    //微信好友。
    else if (ShareTypeWeixiSession == shareType){
        [ShareSDK shareContent:shareContent
                          type:ShareTypeWeixiSession
                   authOptions:authOptions
                 statusBarTips:NO
                        result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                            if (state == SSPublishContentStateSuccess){
                                [_self notiySuperView:YES withMessage:NSLocalizedString(@"wechat share success!", nil)];
                            }
                            else  if (state == SSPublishContentStateFail){
                                if ([error errorCode] == -22003){
                                    //未安装微信 提示。
                                    [_self notiySuperView:NO withMessage:[error errorDescription]];
                                }
                                else{
                                    [_self notiySuperView:NO withMessage:NSLocalizedString(@"wechat share faild!", nil)];
                                }
                            }
                            else if (state == SSPublishContentStateCancel){
//                                [_self notiySuperView:NO withMessage:NSLocalizedString(@"wechat share faild!", nil)];
                            }
                            
                        }];
    }
    //微信朋友圈
    else if (ShareTypeWeixiTimeline == shareType ) {
        id<ISSContent> shareContent = [ShareSDK content:m_shareContent
                                         defaultContent:m_shareContent
                                                  image:(id)imagePath
                                                  title:m_shareContent
                                                    url:m_url
                                            description:m_shareContent
                                              mediaType:SSPublishContentMediaTypeNews];

        
        [ShareSDK shareContent:shareContent
                          type:ShareTypeWeixiTimeline
                   authOptions:authOptions
                 statusBarTips:NO
                        result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                            if (state == SSPublishContentStateSuccess){
                                [_self notiySuperView:YES withMessage:NSLocalizedString(@"wechat share success!", nil)];
                            }
                            else if (state == SSPublishContentStateFail){
                                if ([error errorCode] == -22003){
                                    //未安装微信 提示。
                                    [_self notiySuperView:NO withMessage:[error errorDescription]];
                                }
                                else{
                                    [_self notiySuperView:NO withMessage:NSLocalizedString(@"wechat share faild!", nil)];
                                }
                                
//                                DDLogError(@"发布失败!error code == %ld, error code == %@", (long)[error errorCode], [error errorDescription]);
                            }
                            else if (state == SSPublishContentStateCancel){
//                                [_self notiySuperView:NO withMessage:NSLocalizedString(@"wechat share faild!", nil)];
                            }

                        }];
    }
    //复制链接
    else{
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:m_url];
        [_self notiySuperView:YES withMessage:@"链接已经复制到粘贴板中"];
    }
}

@end
