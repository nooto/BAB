//
//  BABData.m
//  BAB
//
//  Created by GaoAng on 15/9/6.
//  Copyright (c) 2015年 selfcom. All rights reserved.
//

#import "BABData.h"
@implementation CBABData: NSObject
-(CBABData*)init{
    if (self = [super init]) {
        
    }
    return self;
}

- (NSDictionary *)transformToDictionary{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
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

@end
