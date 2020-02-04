//
//  Tool.h
//  BAB
//
//  Created by GaoAng on 2020/2/4.
//  Copyright © 2020 selfcom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tool : NSObject
/*s*
 *  获取path路径下文件夹的大小
 *
 *  @param path 要获取的文件夹 路径
 *
 *  @return 返回path路径下文件夹的大小
 */
+ (NSString *)getCacheSizeWithFilePath:(NSString *)path;
/**
 *  清除path路径下文件夹的缓存
 *
 *  @param path  要清除缓存的文件夹 路径
 *
 *  @return 是否清除成功
 */
+ (BOOL)clearCacheWithFilePath:(NSString *)path;


//获取appIconName
+(NSString*)GetAppIconName;

@end

