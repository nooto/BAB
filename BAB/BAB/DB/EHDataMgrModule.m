

#import "EHDataMgrModule.h"

@interface EHDataMgrModule ()

@property (nonatomic, strong, readwrite) FMDatabaseQueue *mQueue;

@end

@implementation EHDataMgrModule
#define kDatabaseHistoryTableName  @"history"

- (void)initQueue{
    
    _mQueue = [FMDatabaseQueue databaseQueueWithPath:[self dbpath]];
    [self.mQueue inDatabase:^(FMDatabase *db) {
        [self createHistoryTable:db];
    }];
}

-(NSString*)dbpath{
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dbPath = [document stringByAppendingPathComponent:@"BAB"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dbPath]) {
        NSError *err = nil;
        if (![[NSFileManager defaultManager] createDirectoryAtPath:dbPath
                                       withIntermediateDirectories:YES attributes:nil error:&err])
        {
            NSLog(@"DDFileLogManagerDefault: Error creating logsDirectory: %@", err);
        }
    }

    dbPath = [dbPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.db",@"BAB"]];
    return dbPath;
}
__strong static id sharedInstance = nil;
+ (id)shareInstance
{
    static dispatch_once_t pred = 0;
//    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[self alloc] init]; // or some other init method
    });
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone//其实alloc也是调用此方法，只是参数zone为nil而已
{
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
//            [sharedInstance initQueue];
            return sharedInstance;  // assignment and return on first allocation
        }
    }
    return sharedInstance; //on subsequent allocation attempts return nil
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;//此处保证不会产生副本
}
/*
- (FMDatabaseQueue *)mQueue{
    @synchronized(self) {
        if (nil == _mQueue) {
            [self initQueue];
        }
    }
    return _mQueue;
}*/

- (void)deleteDB{
//    [[NSFileManager defaultManager] removeItemAtPath:DBPath error:nil];
    _mQueue = nil;

}

- (NSArray *)valuesForCloumns: (NSString *)cloumnName matching:(NSDictionary *)matching tableName:(NSString *)table{
    
    if (cloumnName == nil) {
        NSLog(@"Parameter 'cloumnName' is nil");
        return nil;
    }
    
    __block NSMutableArray *array;
    [self.mQueue inDatabase:^(FMDatabase *db) {
        
        NSError *error;
        NSArray *records = [db selectResults: @[cloumnName]
                                        from: table
                              matchingValues: matching
                                     orderBy: nil
                                       limit: nil
                                      offset: nil
                                       error: &error].allRecords;
        
        if ([records count] >= 1 && error == nil) {
            array = [NSMutableArray array];
            for (NSDictionary *keyValue in records) {
                id value = [keyValue objectForKey: cloumnName];
                if (value != nil) {
                    [array addObject: value];
                }
            }
            return;
        }
        if (error) {
            NSLog(@"error: %@", error);
        }
    }];
    
    return array;
}

- (NSArray *)valuesWithMatchingValues:(NSDictionary *)matchingValues tableName:(NSString *)table{
    
    __block NSMutableArray *devices;
    [self.mQueue inDatabase:^(FMDatabase *db) {
        
        NSError *error;
        NSArray * records = [db selectResultsFrom: (NSString *)table
                                   matchingValues: matchingValues
                                          orderBy: nil
                                            error: &error].allRecords;
        
        if (([records count] >= 1) && (error == nil)) {
            devices = [NSMutableArray array];
            return;
        }
        
        NSLog(@"error: %@", error);
    }];
    
    return devices;
}


- (void)createHistoryTable:(FMDatabase *)db{
    if (![[db tableNames] containsObject:@""]) {
        NSError *error;
        [db createTableWithName: (NSString *)kDatabaseHistoryTableName
                        columns: @[ @"user_id TEXT PRIMARY KEY",
                                    @"username TEXT",
                                    @"userType INTEGER",
                                    @"name TEXT",
                                    @"email TEXT",
                                    @"phone TEXT",
                                    @"avatar TEXT",
                                    @"md5_file TEXT",
                                    @"user_token TEXT",
                                    @"autoLogin INTEGER",
                                    @"urgency_contact TEXT",
                                    @"urgency_contact_phone TEXT"
                                    ]
                    constraints: nil
                          error: &error];
        
        //        [dict setValue:_user.username        forKey: KUserName];
        //        [dict setValue:_user.userId          forKey: KUserId];
        //        [dict setValue:@(_user.userType)     forKey: KUserType];
        //        [dict setValue:_user.name            forKey: KName];
        //        [dict setValue:_user.email           forKey: KEmail];
        //        [dict setValue:_user.phone           forKey: KPhone];
        //
        //        [dict setValue:_user.avatar          forKey: KAvatar];
        //        [dict setValue:_user.md5File         forKey: KMd5File];
        //        [dict setValue:_user.userToken       forKey: KUserToken];
        //        [dict setValue:@(_user.autoLogin)    forKey: KAutoLogin];
        //        [dict setValue:_user.urgencyPhone    forKey: KUrgencyPhone];
        //        [dict setValue:_user.urgencyContact  forKey: KUrgencyContact];
    }
}


@end

