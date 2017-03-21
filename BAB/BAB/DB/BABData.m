//
//  BABData.m
//  BAB
//
//  Created by GaoAng on 15/9/6.
//  Copyright (c) 2015年 selfcom. All rights reserved.
//

#import "BABData.h"
#import "CThemeManager.h"

@implementation CBABData: NSObject
-(CBABData*)init{
    if (self = [super init]) {
        
    }
    return self;
}

- (NSDictionary *)transformToDictionary{
    NSDictionary *dict = [self keyValues];
    return dict;
}

- (void)parseDictionary:(NSDictionary*)dict{
    if (![dict isKindOfClass:[NSDictionary class]]) {
        return;
    }
}
//-(id)initWithCoder:(NSCoder *)aDecoder
//{
//    if (self = [super init]) {
//        self.pmje = [aDecoder decodeObjectForKey:@"pmje"];
//        self.yll = [aDecoder decodeObjectForKey:@"yll"];
//        self.txrqstr = [aDecoder decodeObjectForKey:@"txrqstr"];
//        self.dqrqstr = [aDecoder decodeObjectForKey:@"dqrqstr"];
//        self.tzts = [aDecoder decodeObjectForKey:@"tzts"];
//        
//        self.txje = [aDecoder decodeObjectForKey:@"txje"];
//        self.txlx = [aDecoder decodeObjectForKey:@"txlx"];
//        self.jxts = [aDecoder decodeObjectForKey:@"jxts"];
//        self.jssj = [aDecoder decodeObjectForKey:@"time"];
//    }
//    return  self;
//}
//
//
//-(void)encodeWithCoder:(NSCoder *)aCoder
//{
//    [aCoder encodeObject:self.pmje forKey:@"pmje"];
//    [aCoder encodeObject:self.yll forKey:@"yll"];
//    [aCoder encodeObject:self.txrqstr forKey:@"txrqstr"];
//    [aCoder encodeObject:self.dqrqstr forKey:@"dqrqstr"];
//    [aCoder encodeObject:self.tzts forKey:@"tzts"];
//    
//    [aCoder encodeObject:self.jxts forKey:@"jxts"];
//    [aCoder encodeObject:self.txlx forKey:@"txlx"];
//    [aCoder encodeObject:self.txje forKey:@"txje"];
//    
//    [aCoder encodeObject:self.jssj forKey:@"time"];
//}
+ (NSArray*)ignoredPropertyNames{
    return @[@"txrq",@"dqrq"];
}

-(void)setTxrq:(NSDate *)txrq{
    _txrq = txrq;
    _txrqstr = nil;
}

-(NSString*)txrqstr{
    if (_txrqstr.length <= 0) {
        NSDateFormatter *formattter = [[NSDateFormatter alloc] init];
        [formattter setDateFormat:@"yyyy年MM月dd日"];
        _txrqstr = [formattter stringFromDate:_txrq];
    }
    return _txrqstr;
}

-(void)setDqrq:(NSDate *)dqrq{
    _dqrq = dqrq;
    _dqrqstr = nil;
}

-(NSString*)dqrqstr{
    if (_dqrqstr.length <= 0) {
        NSDateFormatter *formattter = [[NSDateFormatter alloc] init];
        [formattter setDateFormat:@"yyyy年MM月dd日"];
        _dqrqstr = [formattter stringFromDate:_dqrq];
    }
    return _dqrqstr;
}


-(NSAttributedString*)getResultString{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] init];
    
    NSString *tempString = [NSString stringWithFormat:@"     计息天数: %@天\n",self.jxts];
    NSMutableAttributedString *tempAttriString = [[NSMutableAttributedString alloc] initWithString:tempString];
    [tempAttriString addAttributes:@{NSForegroundColorAttributeName : [ThemeManager buttonTitleColor]} range:NSMakeRange(0, tempString.length)];
    [tempAttriString addAttributes:@{NSForegroundColorAttributeName : [ThemeManager buttonTitleColor]} range:[tempString rangeOfString:@"计息天数:"]];
    [attributeString appendAttributedString:tempAttriString];
    
    tempString = [NSString stringWithFormat:@"     贴现利息: %@\n",self.txlx];
    tempAttriString = [[NSMutableAttributedString alloc] initWithString:tempString];
    [tempAttriString addAttributes:@{NSForegroundColorAttributeName : [ThemeManager buttonTitleColor]} range:NSMakeRange(0, tempString.length)];
    [tempAttriString addAttributes:@{NSForegroundColorAttributeName : [ThemeManager buttonTitleColor]} range:[tempString rangeOfString:@"贴现利息:"]];
    [attributeString appendAttributedString:tempAttriString];

    tempString = [NSString stringWithFormat:@"     贴现金额: %@",self.txje];
    tempAttriString = [[NSMutableAttributedString alloc] initWithString:tempString];
    [tempAttriString addAttributes:@{NSForegroundColorAttributeName : [ThemeManager buttonTitleColor]} range:NSMakeRange(0, tempString.length)];
    [tempAttriString addAttributes:@{NSForegroundColorAttributeName : [ThemeManager buttonTitleColor]} range:[tempString rangeOfString:@"贴现金额:"]];
    [attributeString appendAttributedString:tempAttriString];

    return attributeString;
}

@end
