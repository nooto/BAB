

#import "EHDataMgrModule.h"
#import "MJExtension.h"

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
    [[NSFileManager defaultManager] removeItemAtPath:[self dbpath] error:nil];
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
    if (![[db tableNames] containsObject:kDatabaseHistoryTableName]) {
        NSError *error;
        [db createTableWithName: (NSString *)kDatabaseHistoryTableName
                        columns: @[ @"timestamp TEXT PRIMARY KEY"
                                    ]
                    constraints: nil
                          error: &error];
        
        CBABData *data = [[CBABData alloc] init];
        NSArray *dict = data.propertyNames;
        for (NSString *key in dict) {
            [self addTextColumnName:key inTabel:kDatabaseHistoryTableName WithDataBase:db];
        }
    }
}

-(BOOL)addTextColumnName:(NSString*)cloumn inTabel:(NSString*)tableName WithDataBase:(FMDatabase*)db{
    if ([[db tableNames] containsObject:tableName]) {
        NSError *error;
        if (![self checkColumnExists:db colume:cloumn inTabel:tableName]) {
            [db addColumn:[NSString stringWithFormat:@"%@ TEXT",cloumn] toTable:tableName error:&error];
            if (error) {
                NSLog(@"%@", [error description]);
                return NO;
            }
            else{
                return YES;
            }
        }
        
    }
    return NO;
}

-(BOOL)addIntegerColumnName:(NSString*)cloumn inTabel:(NSString*)tableName WithDataBase:(FMDatabase*)db{
    if ([[db tableNames] containsObject:tableName]) {
        NSError *error;
        if (![self checkColumnExists:db colume:cloumn inTabel:tableName]) {
            [db addColumn:[NSString stringWithFormat:@"%@ INTEGER",cloumn] toTable:tableName error:&error];
            if (error) {
                NSLog(@"%@", [error description]);
                return NO;
            }
            else{
                return YES;
            }
        }
        
    }
    return NO;
}

-(BOOL)addBoolColumnName:(NSString*)cloumn inTabel:(NSString*)tableName WithDataBase:(FMDatabase*)db{
    if ([[db tableNames] containsObject:tableName]) {
        NSError *error;
        if (![self checkColumnExists:db colume:cloumn inTabel:tableName]) {
            [db addColumn:[NSString stringWithFormat:@"%@ BOOL",cloumn] toTable:tableName error:&error];
            if (error) {
                NSLog(@"%@", [error description]);
                return NO;
            }
            else{
                return YES;
            }
        }
        
    }
    return NO;
}


-(BOOL)checkColumnExists:(FMDatabase*)db colume:(NSString*) columnname inTabel:(NSString*)tabelName;
{
    BOOL columnExists = NO;
    sqlite3_stmt *selectStmt;
    NSString *sqlString = [NSString stringWithFormat:@"select %@ from %@", columnname, tabelName];
//    const char *sqlStatement = "select yourcolumnname from yourtable";
    const char *sqlStatement = [sqlString UTF8String];
    if(sqlite3_prepare_v2([db sqliteHandle], sqlStatement, -1, &selectStmt, NULL) == SQLITE_OK)
        columnExists = YES;
    
    return columnExists;
}


-(BOOL)inserTtBABData:(CBABData *)data{
    if (!data) {
        return NO;
    }
    // 用户不存在，插入数据
    __block BOOL insertSucceed = NO;
    [self.mQueue inDatabase:^(FMDatabase *db) {
        NSDictionary *valueDict = [data keyValues];
        
        NSError *error;
        NSNumber *insertNumber = [db insertInto: (NSString *)kDatabaseHistoryTableName
                                            row: valueDict
                                          error: &error];
        
        if (([insertNumber integerValue] >= 1) && (error == nil)) {
            insertSucceed = YES;
            return;
        }
    }];
    
    return insertSucceed;
    
}

-(NSArray*)babdataFromDB{
    __block NSArray *result = nil;
    [self.mQueue inDatabase:^(FMDatabase *db) {
        
        NSError *error;
        NSArray * records = [db selectResultsFrom: (NSString *)kDatabaseHistoryTableName
                                   matchingValues: nil
                                          orderBy: nil
                                            error: &error].allRecords;

        if (([records count] >= 1) && (error == nil)) {
            result = [CBABData objectArrayWithKeyValuesArray:records];
        }
    }];
    
    return result;}


@end

