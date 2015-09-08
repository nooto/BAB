

#import <UIKit/UIKit.h>
#import "FMDBHelpers.h"
#import "FMDB.h"
#import "BABData.h"
#define DBHelper [EHDataMgrModule shareInstance]

@interface EHDataMgrModule : NSObject

@property (nonatomic, strong, readonly) FMDatabaseQueue *mQueue;

+ (id)shareInstance;

- (void)initQueue;


- (NSArray *)valuesForCloumns: (NSString *)cloumnName matching:(NSDictionary *)matching tableName:(NSString *)table;
- (NSArray *)valuesWithMatchingValues:(NSDictionary *)matchingValues tableName:(NSString *)table;


-(BOOL)inserTtBABData:(CBABData*)data;
-(NSArray*)babdataFromDB;
- (void)deleteDB;
@end

