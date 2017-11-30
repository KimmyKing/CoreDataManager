//
//  CoreDataManager.h
//  CoradataFramework
//
//  Created by Cain on 2017/11/20.
//  Copyright © 2017年 Goldian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CCCommunitySearchHistory.h"
#import "CCMerchantSearchHistory.h"
#import "CCUserInfo.h"
#import "CoredataMacros.h"

@interface CoreDataManager : NSObject

+ (instancetype)shareManager;

@property (nonatomic , strong)NSManagedObjectContext *context;

//MARK: -
//MARK: --插入数据
- (void)insertParemeter:(NSDictionary *)paremeter tableName:(NSString *)tableName;

//MARK: -
//MARK: --删除
- (void)deleteDataWithTableName:(NSString *)tableName predicate:(NSPredicate *)predicate;

//MARK: -
//MARK: - 清空表
- (void)clearDataWithTableName:(NSString *)tableName;

//MARK: -
//MARK: --查询数据
- (NSArray *)selectInfoWithTableName:(NSString *)tableName predicate:(NSPredicate *)predicate;

//MARK: -
//MARK: -- 更新数据库数据
- (void)updateUserinfoWithAttribute:(id)attribute key:(NSString *)key tableName:(NSString *)tableName predicate:(NSString *)predicateString;

//MARK: -
//MARK: -- 获取数据库数据
- (id)getAttributeWithKey:(NSString *)key tableName:(NSString *)tableName predicate:(NSString *)predicateString;

//MARK: -
//MARK: -- 清空用户数据
- (void)clearUserinfo;

@end
