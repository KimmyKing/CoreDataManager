//
//  CoreDataManager.h
//  CoradataFramework
//
//  Created by Cain on 2017/11/20.
//  Copyright © 2017年 Goldian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

+ (instancetype)shareManager;

//MARK: -
//MARK: --插入数据
- (void)insertParameter:(NSDictionary *)parameter tableName:(NSString *)tableName;

//MARK: -
//MARK: --删除
- (void)deleteDataWithTableName:(NSString *)tableName predicate:(NSString *)predicateString;

//MARK: -
//MARK: -- 更新数据
- (void)updateWithAttribute:(id)attribute key:(NSString *)key tableName:(NSString *)tableName predicate:(NSString *)predicateString;

//MARK: -
//MARK: --查询数据
- (NSArray *)selectWithKey:(NSString *)key tableName:(NSString *)tableName predicate:(NSString *)predicateString;

@end
