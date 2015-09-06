

#import <UIKit/UIKit.h>
#import "FMDBHelpers.h"
#import "FMDB.h"

#define DBHelper [EHDataMgrModule shareInstance]

@interface EHDataMgrModule : NSObject

@property (nonatomic, strong, readonly) FMDatabaseQueue *mQueue;

+ (id)shareInstance;

- (void)initQueue;
- (void)deleteDB;


- (NSArray *)valuesForCloumns: (NSString *)cloumnName matching:(NSDictionary *)matching tableName:(NSString *)table;
- (NSArray *)valuesWithMatchingValues:(NSDictionary *)matchingValues tableName:(NSString *)table;
    
@end

