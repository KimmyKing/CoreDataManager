//
//  CoredataMacros.h
//  CCFin
//
//  Created by Cain on 2017/7/13.
//  Copyright © 2017年 Goldian. All rights reserved.
//

#ifndef CoredataMacros_h
#define CoredataMacros_h

//表
#define Table_Person @"Person"
#define Table_MerchantSearchHistory @"MerchantSearchHistory"
#define Table_CommunitySearchHistory @"CommunitySearchHistory"

//key
#define INDEX @"index"
#define KEYWORDS @"keywords"

//Predicate
#define UserSearch_Predicate @"object_id = 1"


//更新用户表数据宏
#define UPDATEUSERINFO(VALUE,KEY) [[CoreDataManager shareManager] updateUserinfoWithAttribute:VALUE key:KEY tableName:Table_Person predicate:UserSearch_Predicate]


/**
 *用户表获取数据宏
 */
#define UID [[CoreDataManager shareManager] getAttributeWithKey:USERINFO_KEY_UID tableName:Table_Person predicate:UserSearch_Predicate]
/**数据库存储的用户选择的优惠城市*/
#define SelectDiscountCity [[CoreDataManager shareManager] getAttributeWithKey:USERINFO_KEY_SELECTDISCOUNTCITY tableName:Table_Person predicate:UserSearch_Predicate]
#define VERSION [[CoreDataManager shareManager] getAttributeWithKey:USERINFO_KEY_VERSION tableName:Table_Person predicate:UserSearch_Predicate]
/**数据库存储的登录令牌*/
#define Login [[CoreDataManager shareManager] getAttributeWithKey:USERINFO_KEY_TOKEN tableName:Table_Person predicate:UserSearch_Predicate]
#define NICKNAME [[CoreDataManager shareManager] getAttributeWithKey:USERINFO_KEY_NICKNAME tableName:Table_Person predicate:UserSearch_Predicate]
#define PHONENUMBER [[CoreDataManager shareManager] getAttributeWithKey:USERINFO_KEY_PHONENUMBER tableName:Table_Person predicate:UserSearch_Predicate]
#define MARRIAGE [[CoreDataManager shareManager] getAttributeWithKey:USERINFO_KEY_MARRIAGE tableName:Table_Person predicate:UserSearch_Predicate]
#define GENDER [[CoreDataManager shareManager] getAttributeWithKey:USERINFO_KEY_GENDER tableName:Table_Person predicate:UserSearch_Predicate]
#define BIRTHDAY [[CoreDataManager shareManager] getAttributeWithKey:USERINFO_KEY_BIRTHDAY tableName:Table_Person predicate:UserSearch_Predicate]
#define HOMEADDRESS [[CoreDataManager shareManager] getAttributeWithKey:USERINFO_KEY_HOMETOWN_ADDRESS tableName:Table_Person predicate:UserSearch_Predicate]
#define ADDRESS [[CoreDataManager shareManager] getAttributeWithKey:USERINFO_KEY_ADDRESS tableName:Table_Person predicate:UserSearch_Predicate]
#define HEADERIMAGEURL [[CoreDataManager shareManager] getAttributeWithKey:USERINFO_KEY_HEADERIMGURL tableName:Table_Person predicate:UserSearch_Predicate]
#define VERIFIED [[[CoreDataManager shareManager] getAttributeWithKey:USERINFO_KEY_VERIFIED tableName:Table_Person predicate:UserSearch_Predicate]  boolValue]



/**
 *CCUserInfo表的key
 */
#define USERINFO_KEY_ADDRESS @"address"
#define USERINFO_KEY_HOMETOWN_ADDRESS @"hometown_address"
#define USERINFO_KEY_UID @"uid"
#define USERINFO_KEY_TOKEN @"token"
#define USERINFO_KEY_VERSION @"version"
#define USERINFO_KEY_SELECTDISCOUNTCITY @"selectDiscountCity"
#define USERINFO_KEY_NICKNAME @"nickName"
#define USERINFO_KEY_PHONENUMBER @"phone"
#define USERINFO_KEY_HEADERIMGURL @"headerImageUrl"
#define USERINFO_KEY_GENDER @"gender"
#define USERINFO_KEY_MARRIAGE @"marriage"
#define USERINFO_KEY_BIRTHDAY @"birthday"
#define USERINFO_KEY_VERIFIED @"verified"
#define USERINFO_KEY_REALNAME @"realName"
#define USERINFO_KEY_IDCARDNO @"iDCardNo"

#endif /* CoredataMacros_h */
