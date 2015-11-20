//
//  BABData.h
//  BAB
//
//  Created by GaoAng on 15/9/6.
//  Copyright (c) 2015年 selfcom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJExtension.h"
@interface CBABData : NSObject

//参数
@property (nonatomic, strong)  NSString*  pmje;
@property (nonatomic, strong) NSString*  yll;
@property (nonatomic, strong) NSDate*  txrq;
@property (nonatomic, strong) NSString*  txrqstr;
@property (nonatomic, strong) NSDate*  dqrq;
@property (nonatomic, strong) NSString*  dqrqstr;
@property (nonatomic, strong) NSString*  tzts;

//结果
@property (nonatomic, strong) NSString*  jxts;
@property (nonatomic, strong) NSString*  txlx;
@property (nonatomic, strong) NSString* txje;

@property (nonatomic, strong) NSString* jssj;
//- (CBABData *)initWithDictionary: (NSDictionary *)userInfoDict;

/**
 *  将用户对象的属性转换为字典，方便保存
 */
- (NSDictionary *)transformToDictionary;
- (void)parseDictionary:(NSDictionary*)dict;

- (NSAttributedString*)getResultString;
@end