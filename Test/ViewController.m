//
//  ViewController.m
//  Test
//
//  Created by Cain on 2017/12/6.
//  Copyright © 2017年 Goldian. All rights reserved.
//

#define Manager [CoreDataManager shareManager]
#define Table_People @"People"

#import "ViewController.h"
#import "CoreDataManager.h"
#import "People.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

}

//MARK: -
//MARK: --增
- (IBAction)add:(id)sender {
    
    [Manager insertParameter:@{
                               @"age" : [NSNumber numberWithInt:1],
                               @"name" : @"AAA",
                               } tableName:Table_People];
    [Manager insertParameter:@{
                               @"age" : [NSNumber numberWithInt:2],
                               @"name" : @"BBB",
                               } tableName:Table_People];
    [Manager insertParameter:@{
                               @"age" : [NSNumber numberWithInt:3],
                               @"name" : @"CCC",
                               } tableName:Table_People];
    [Manager insertParameter:@{
                               @"age" : [NSNumber numberWithInt:4],
                               @"name" : @"DDD",
                               } tableName:Table_People];
    [Manager insertParameter:@{
                               @"age" : [NSNumber numberWithInt:5],
                               @"name" : @"EEE",
                               } tableName:Table_People];
    [Manager insertParameter:@{
                               @"age" : [NSNumber numberWithInt:6],
                               @"name" : @"FFF",
                               } tableName:Table_People];
    [Manager insertParameter:@{
                               @"age" : [NSNumber numberWithInt:7],
                               @"name" : @"GGG",
                               } tableName:Table_People];
    [Manager insertParameter:@{
                               @"age" : [NSNumber numberWithInt:8],
                               @"name" : @"HHH",
                               } tableName:Table_People];
    [Manager insertParameter:@{
                               @"age" : [NSNumber numberWithInt:9],
                               @"name" : @"III",
                               } tableName:Table_People];
    [Manager insertParameter:@{
                               @"age" : [NSNumber numberWithInt:10],
                               @"name" : @"JJJ",
                               } tableName:Table_People];
    [Manager insertParameter:@{
                               @"age" : [NSNumber numberWithInt:11],
                               @"name" : @"KKK",
                               } tableName:Table_People];
    [Manager insertParameter:@{
                               @"age" : [NSNumber numberWithInt:12],
                               @"name" : @"LLL",
                               } tableName:Table_People];
}

//MARK: -
//MARK: --删
- (IBAction)delete:(id)sender {
    [Manager deleteDataWithTableName:Table_People predicate:@"age=1"];
}

//MARK: -
//MARK: --改
- (IBAction)update:(id)sender {
    [Manager updateWithAttribute:@"KimmyKing" key:@"name" tableName:Table_People predicate:@"name='BBB'"];
}

//MARK: -
//MARK: --查
- (IBAction)select:(id)sender {
    NSArray *arr = [Manager selectWithTableName:Table_People predicate:@"age>10"];
    for (People *p in arr) {
        NSLog(@"%@今年%@岁了",p.name,p.age);
    }
}

//MARK: -
//MARK: --修改性别
- (IBAction)changeGender:(id)sender {
    [Manager updateWithAttribute:[NSNumber numberWithBool:1] key:@"gender" tableName:Table_People predicate:@"name='KimmyKing' OR age>10"];
}

@end
