//
//  CoreDataManager.m
//  CoradataFramework
//
//  Created by Cain on 2017/11/20.
//  Copyright © 2017年 Goldian. All rights reserved.
//

#import "CoreDataManager.h"

@interface CoreDataManager()

@property (nonatomic , strong)NSManagedObjectContext *context;

@end

@implementation CoreDataManager

static CoreDataManager *_manager;
+ (instancetype)shareManager
{
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [super allocWithZone:zone];
    });
    return _manager;
}

//MARK: -
//MARK: --插入数据
- (void)insertParameter:(NSDictionary *)parameter tableName:(NSString *)tableName
{
    NSManagedObject *obj = [NSEntityDescription insertNewObjectForEntityForName:tableName inManagedObjectContext:self.context];
    for (NSString *key in parameter.allKeys) {
        [obj setValue:parameter[key] forKey:key];
    }
    if ([self.context save:nil]) {
        NSLog(@"save success");
    }else{
        NSLog(@"save failure");
    }
}

//MARK: -
//MARK: --删除
- (void)deleteDataWithTableName:(NSString *)tableName predicate:(NSString *)predicateString
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:tableName];
    request.predicate = [NSPredicate predicateWithFormat:predicateString];
    NSArray *results = [self.context executeFetchRequest:request error:nil];
    for (NSManagedObject *obj in results) {
        [self.context deleteObject:obj];
    }
    if ([self.context save:nil]) {
        NSLog(@"save success");
    }else{
        NSLog(@"save failure");
    }
}

//MARK: -
//MARK: -- 更新数据
- (void)updateWithAttribute:(id)attribute key:(NSString *)key tableName:(NSString *)tableName predicate:(NSString *)predicateString
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:tableName];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
    request.predicate = predicate;
    NSArray *results = [self.context executeFetchRequest:request error:nil];
    for (NSManagedObject *obj in results) {
        [obj setValue:attribute forKey:key];
    }
    //保存
    if ([self.context save:nil]) {
        NSLog(@"operate success");
    }else{
        NSLog(@"operate failed");
    }
}

//MARK: -
//MARK: --查询数据
- (NSArray *)selectWithKey:(NSString *)key tableName:(NSString *)tableName predicate:(NSString *)predicateString
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:tableName];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
    request.predicate = predicate;
    NSArray *results = [self.context executeFetchRequest:request error:nil];
    return results;
}

- (NSManagedObjectContext *)context
{
    if (!_context) {
        //1.经过编译后数据模型文件的扩展名由xcdatamodeld变成了momd
        NSURL *modelUrl = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
        //2.构建CoreData的模型文件
        NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelUrl];
        //3.通过模型文件创建PersistentStoreCoordinator对象
        NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        //4.数据库存储路径URL
        NSURL *dbUrl = [NSURL fileURLWithPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"test.sqlite"]];
        //5.设置persistStore的持久化存储方式为SQLiteStoreType,代表persistStore会自动生成一个SQLite数据库文件来实现持久化存储，并会自动生成SQL语句来做CRUD（增删改查)
        /***************************************************数据库升级*****************************************************************************/
        NSDictionary *optionsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],
                                           NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES],NSInferMappingModelAutomaticallyOption, nil];
        if (![coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:dbUrl options:optionsDictionary error:nil]) {
            NSLog(@"failed to add persistent store with type to persistent store coordinator");
        }
        /****************************************************************************************************************************************/
        //6.NSManagedObjectContext:所有的ManagedObject的增删改查都是在context上进行的。
        //NSMainQueueConcurrencyType:这个context所关联的控制器和UI控件只能在主线程中使用
        _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _context.persistentStoreCoordinator = coordinator;
    }
    return _context;
}
    
@end

