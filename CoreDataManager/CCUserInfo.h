//
//  CCUserInfo.h
//  CCFin
//
//  Created by Cain on 2017/7/20.
//  Copyright © 2017年 Goldian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCUserInfo : NSObject

@property (nullable, nonatomic, copy) NSString *address;
@property (nullable, nonatomic, copy) NSString *birthday;
@property (nullable, nonatomic, copy) NSString *gender;
@property (nullable, nonatomic, copy) NSString *headerImageUrl;
@property (nullable, nonatomic, copy) NSString *hometown_address;
@property (nullable, nonatomic, copy) NSString *marriage;
@property (nullable, nonatomic, copy) NSString *nickName;
@property (nullable, nonatomic, copy) NSString *object_id;
@property (nullable, nonatomic, copy) NSString *phone;
@property (nullable, nonatomic, copy) NSString *selectDiscountCity;
@property (nullable, nonatomic, copy) NSString *token;
@property (nullable, nonatomic, copy) NSString *uid;
@property (nullable, nonatomic, copy) NSString *version;
@property (nullable, nonatomic, strong)NSNumber *verified; //是否实名认证
@property (nullable, nonatomic, copy) NSString *realName;
@property (nullable, nonatomic, copy) NSString *iDCardNo;

@end
