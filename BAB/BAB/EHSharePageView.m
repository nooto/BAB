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
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#define KICON @"icon"
#define KNAME @"name"
#define KTAG  @"tag"

#define numberOfColunm 4
@interface EHSharePageView ()
@property (nonatomic, strong) UIView *mBackGroundView;
@property (nonatomic, strong) UIView *mItemsView;
@property (nonatomic, strong) NSMutableArray *arrDataSource;
@property (nonatomic, assign) id<EHSharePageViewdDelegate> m_delegate;
@end

@implementation EHSharePageView
- (id)initWithFrame:(CGRect)frame withDelegate:(id)delegate{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.mBackGroundView];
        [self addSubview:self.mItemsView];
        self.m_delegate = delegate;
        
//        [self.mBackGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.leading.equalTo(self);
//            make.top.equalTo(self.mas_top);
//            make.width.equalTo(self.mas_width);
//            make.height.equalTo(self.mas_height);
//        }];
//        
//        
////        frame.size.height = posY + (self.arrDataSource.count/numberOfColunm + 1) * (buttonWidht + 30) + margin;
//
//        [self.mItemsView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self);
//            make.top.equalTo(self.mas_bottom);
//            make.width.equalTo(self.mas_width);
//            make.height.equalTo(self.mItemsView.mas_height);
//        }];
        
    }
    return self;
}


-(NSArray*)arrDataSource{
    if (!_arrDataSource) {
        _arrDataSource = [[NSMutableArray alloc] initWithCapacity:1];
        //微信
//        if ([WXApi isWXAppInstalled]) {
//            [_arrDataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"微信",                             KNAME,  @"WXIconNormal",   KICON,  [NSNumber numberWithInteger:ShareTypeWeixiSession],  KTAG, nil]];
//            [_arrDataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"朋友圈", KNAME,  @"ic_friends_sel",   KICON,  [NSNumber numberWithInteger:ShareTypeWeixiTimeline], KTAG, nil]];
//        }
        
        //QQ
//        if ([QQApi isQQInstalled]) {
//            [_arrDataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"QQ",          KNAME,  @"QQIconNormal",   KICON,  [NSNumber numberWithInteger:ShareTypeQQ],            KTAG, nil]];
//            [_arrDataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"QQ空间",       KNAME,  @"ic_qq_zone",   KICON,  [NSNumber numberWithInteger:ShareTypeQQSpace],       KTAG, nil]];
//        }
        
        //新浪
        [_arrDataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"新浪微博",   KNAME,  @"SinaIconNormal", KICON, [NSNumber numberWithInteger:ShareTypeSinaWeibo],     KTAG, nil]];
        
        //复制链接。
        [_arrDataSource addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"复制链接",KNAME,  @"ic_copy",    KICON,  [NSNumber numberWithInteger:ShareTypeOther],        KTAG, nil]];
    }
    
    return _arrDataSource;
}

- (UIView*)mBackGroundView{
    if (!_mBackGroundView) {
        _mBackGroundView = [UIView new];
        [_mBackGroundView setBackgroundColor:[UIColor blackColor]];
        [_mBackGroundView setFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
        _mBackGroundView.alpha = 0.0f;
    }
    return _mBackGroundView;
}

- (UIView*)mItemsView{
    if (!_mItemsView) {
        _mItemsView = [UIView new];
        [_mItemsView setBackgroundColor:[UIColor whiteColor]];
        
        CGFloat posY = 15.0f;
        UIButton *button = nil;
        UILabel *namelabel = nil;
        CGFloat marginLeft = Margin_left;
        CGFloat margin =Margin_top;
        CGFloat  buttonWidht = (CGRectGetWidth(self.bounds) - marginLeft*2 - margin * 3) / numberOfColunm;
        
        for (NSInteger i = 0; i < self.arrDataSource.count; i++) {
            NSInteger row = i / numberOfColunm;
            NSInteger col = i % numberOfColunm;
            
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
            namelabel.textColor = [ThemeManager mainTextColor];
            namelabel.textAlignment = NSTextAlignmentCenter;
            namelabel.adjustsFontSizeToFitWidth = YES;
            [_mItemsView addSubview:namelabel];
        }
        
        CGRect frame = _mItemsView.frame;
        frame.origin.y = CGRectGetHeight(self.bounds);
        frame.size.width = SCREEN_W;
        frame.size.height = posY + (self.arrDataSource.count/numberOfColunm + 1) * (buttonWidht + 30) + margin;
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
        [UIView animateWithDuration:0.3f animations:^{
            _mBackGroundView.alpha = 0.5f;
            _mItemsView.center = CGPointMake(SCREEN_W/2, SCREEN_H - CGRectGetHeight(_mItemsView.frame)/2);
        }];
    }
    else{
        
        [UIView animateWithDuration:0.3f animations:^{
            _mBackGroundView.alpha = 0.0f;
            _mItemsView.center = CGPointMake(SCREEN_W/2, SCREEN_H + CGRectGetHeight(_mItemsView.frame)/2);
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
    NSString* m_url = @"www.baidu.com";
    NSString*  m_shareContent = NSLocalizedString(@"我正在用的这款承兑贴现计算工具很不错，也推荐给你用呀。。。。", nil);
    
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
        imagePath = [ShareSDK pngImageWithImage:[UIImage imageNamed:@"AppIcon-2"]];
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
                                [_self notiySuperView:YES withMessage:NSLocalizedString(@"QQ分享成功", nil)];
                            }
                            else if (state == SSPublishContentStateFail){
                                if ([QQApi isQQInstalled]) {
                                    [_self notiySuperView:NO withMessage:NSLocalizedString(@"尚未安装QQ", nil)];
                                }
                                else{
                                    [_self notiySuperView:NO withMessage:NSLocalizedString(@"QQ分享失败", nil)];
                                }
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
                                [_self notiySuperView:YES withMessage:NSLocalizedString(@"QQ空间分享成功", nil)];
                            }
                            else if (state == SSPublishContentStateFail){
                                if ([QQApi isQQInstalled]) {
                                    [_self notiySuperView:NO withMessage:NSLocalizedString(@"尚未安装QQ空间", nil)];
                                }
                                else{
                                    [_self notiySuperView:NO withMessage:NSLocalizedString(@"QQ空间分享失败", nil)];
                                }
                            }
                            else if (state == SSPublishContentStateCancel){
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
        [self showSharePageView:NO];
        BOOL hasSinaWeb = [WeiboSDK isWeiboAppInstalled];
        if (hasSinaWeb) {
            [ShareSDK clientShareContent:shareContent
                                    type:ShareTypeSinaWeibo
                           statusBarTips:NO
                                  result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                      if (state == SSPublishContentStateSuccess){
                                          [_self notiySuperView:YES withMessage:NSLocalizedString(@"新浪微博分享成功", nil)];
                                      }
                                      else if (state == SSPublishContentStateFail){
                                          [_self notiySuperView:NO withMessage:NSLocalizedString(@"新浪微博分享失败", nil)];
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
                                    [_self notiySuperView:YES withMessage:NSLocalizedString(@"新浪微博分享成功", nil)];
                                }
                                else if (state == SSPublishContentStateFail){
                                    [_self notiySuperView:NO withMessage:NSLocalizedString(@"新浪微博分享失败", nil)];
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
                                [_self notiySuperView:YES withMessage:NSLocalizedString(@"微信分享成功", nil)];
                            }
                            else  if (state == SSPublishContentStateFail){
                                    if ([WXApi isWXAppInstalled]) {
                                        [_self notiySuperView:NO withMessage:NSLocalizedString(@"尚未安装微信", nil)];
                                    }
                                    else{
                                        [_self notiySuperView:NO withMessage:NSLocalizedString(@"微信分享失败", nil)];
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
                                [_self notiySuperView:YES withMessage:NSLocalizedString(@"朋友圈分享成功", nil)];
                            }
                            else if (state == SSPublishContentStateFail){
                                if ([WXApi isWXAppInstalled]) {
                                    [_self notiySuperView:NO withMessage:NSLocalizedString(@"尚未安装微信", nil)];
                                }
                                else{
                                    [_self notiySuperView:NO withMessage:NSLocalizedString(@"朋友圈分享失败", nil)];
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
        [pasteboard setString:[NSString stringWithFormat:@"%@%@", m_shareContent, m_url]];
        [_self notiySuperView:YES withMessage:@"分享链接已经复制到粘贴板中,可以粘贴发送给朋友啦。。"];
    }
}

@end
