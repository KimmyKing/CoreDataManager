//
//  CoreDataManager.m
//  CoradataFramework
//
//  Created by Cain on 2017/11/20.
//  Copyright © 2017年 Goldian. All rights reserved.
//

#import "CoreDataManager.h"

@implementation CoreDataManager

+ (instancetype)shareManager
{
    static CoreDataManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CoreDataManager alloc] init];
    });
    return manager;
}

//MARK: -
//MARK: --插入数据
- (void)insertParemeter:(NSDictionary *)paremeter tableName:(NSString *)tableName
{
    NSManagedObject *obj = [NSEntityDescription insertNewObjectForEntityForName:tableName inManagedObjectContext:self.context];
    
    for (NSString *key in paremeter.allKeys) {
        [obj setValue:paremeter[key] forKey:key];
    }
    
    if ([self.context save:nil]) {
        NSLog(@"save success");
    }else{
        NSLog(@"save failure");
    }
}

//MARK: -
//MARK: --删除
- (void)deleteDataWithTableName:(NSString *)tableName predicate:(NSPredicate *)predicate
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:tableName];
    request.predicate = predicate;
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
//MARK: - 清空表
- (void)clearDataWithTableName:(NSString *)tableName
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:tableName];
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
//MARK: --查询数据
- (NSArray *)selectInfoWithTableName:(NSString *)tableName predicate:(NSPredicate *)predicate
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:tableName];
    request.predicate = predicate;
    NSArray *result = [self.context executeFetchRequest:request error:nil];
    return result;
}

//MARK: -
//MARK: -- 更新用户信息表的数据
- (void)updateUserinfoWithAttribute:(id)attribute key:(NSString *)key tableName:(NSString *)tableName predicate:(NSString *)predicateString
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
//MARK: -- 获取用户信息表的数据
- (id)getAttributeWithKey:(NSString *)key tableName:(NSString *)tableName predicate:(NSString *)predicateString
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:tableName];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
    request.predicate = predicate;
    NSArray *results = [self.context executeFetchRequest:request error:nil];
    id attribute;
    for (NSManagedObject *obj in results) {
        attribute = [obj valueForKey:key];
    }
    return attribute;
}

//MARK: -
//MARK: -- 清空用户数据
- (void)clearUserinfo
{
    UPDATEUSERINFO(nil,USERINFO_KEY_TOKEN);
    UPDATEUSERINFO(@"-1",USERINFO_KEY_UID);
    UPDATEUSERINFO(nil,USERINFO_KEY_NICKNAME);
    UPDATEUSERINFO(nil,USERINFO_KEY_PHONENUMBER);
    UPDATEUSERINFO(nil,USERINFO_KEY_MARRIAGE);
    UPDATEUSERINFO(nil,USERINFO_KEY_GENDER);
    UPDATEUSERINFO(nil,USERINFO_KEY_BIRTHDAY);
    UPDATEUSERINFO(nil,USERINFO_KEY_HOMETOWN_ADDRESS);
    UPDATEUSERINFO(nil,USERINFO_KEY_ADDRESS);
    UPDATEUSERINFO(nil,USERINFO_KEY_HEADERIMGURL);
    UPDATEUSERINFO(nil, USERINFO_KEY_VERIFIED);
    UPDATEUSERINFO(nil, USERINFO_KEY_REALNAME);
    UPDATEUSERINFO(nil, USERINFO_KEY_IDCARDNO);
}

- (NSManagedObjectContext *)context
{
    if (!_context) {
        //1.经过编译后数据模型文件的扩展名由xcdatamodeld变成了momd
        NSURL *modelUrl = [[NSBundle mainBundle] URLForResource:@"CCFinDB" withExtension:@"momd"];
        //2.构建CoreData的模型文件
        NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelUrl];
        //3.通过模型文件创建PersistentStoreCoordinator对象
        NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        //4.数据库存储路径URL
        NSURL *dbUrl = [NSURL fileURLWithPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"CCFin_ios.sqlite"]];
        
        //5.设置persistStore的持久化存储方式为SQLiteStoreType,代表persistStore会自动生成一个SQLite数据库文件来实现持久化存储，并会自动生成SQL语句来做CRUD（增删改查)
        /***************************************************数据库升级*****************************************************************************/
        NSDictionary *optionsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],
                                           NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES],NSInferMappingModelAutomaticallyOption, nil];
        if (![coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:dbUrl options:optionsDictionary error:nil]) {
            NSLog(@"failed to add persistent store with type to persistent store coordinator");
        }
        
        /****************************************************************************************************************************************/
        
        //6.NSManagedObjectContext:所有的ManagedObject的CRUD都是在context上进行的。
        //NSMainQueueConcurrencyType:这个context所关联的控制器和UI控件只能在主线程中使用
        _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _context.persistentStoreCoordinator = coordinator;
        
        //先查询数据库
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:Table_Person];
        NSArray *results = [self.context executeFetchRequest:fetchRequest error:nil];
        //查询不到就插入一条用户数据
        if (results.count == 0) {
            CCUserInfo *user = (CCUserInfo *)[NSEntityDescription insertNewObjectForEntityForName:Table_Person inManagedObjectContext:self.context];
            user.object_id = @"1";
            //默认为-1
            user.uid = @"-1";
            //默认为上海市
            user.selectDiscountCity = @"上海市";
            //保存
            if ([self.context save:nil]) {
                NSLog(@"operate success");
            }else{
                NSLog(@"operate failed");
            }
        }
    }
    return _context;
}

@end

