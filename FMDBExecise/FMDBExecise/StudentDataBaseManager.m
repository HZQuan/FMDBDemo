//
//  StudentDataBaseManager.m
//  FMDBExecise
//
//  Created by 黄增权 on 15/10/22.
//  Copyright (c) 2015年 黄增权. All rights reserved.
//

#import "StudentDataBaseManager.h"
#define databasename @"student"

@implementation StudentDataBaseManager
+(instancetype) shareStudentDataBaseManager
{
    static StudentDataBaseManager *dbManager;
    if (dbManager == nil) {
        dbManager = [[StudentDataBaseManager alloc] init];
    }
    return dbManager;

}
-(BOOL)createStudentTable
{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dbPath = [docPath stringByAppendingString:databasename];
    self.queue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    [self.queue inDatabase:^(FMDatabase *db) {
        BOOL  result = [db executeUpdate:@"create table student (name text primary key, age text, address text)"];
        if (result) {
            NSLog(@"创表成功");
        }else{
            NSLog(@"创表失败");
        
        }
            

    }];
    return YES;
}

-(BOOL)insertStudent:(Student *)student
{
    
    [self.queue inDatabase:^(FMDatabase *db) {
        NSString *update = [NSString stringWithFormat:@"insert into student values ('%@', '%@', '%@')",student.nama,student.age,student.address];
        BOOL result = [db executeUpdate:update];
        if (result) {
            NSLog(@"插入成功");
        }else{
            NSLog(@"插入失败");
        }

    }];
    return YES;
}


-(BOOL)deleateStudent:(Student *)student
{
    if (student.nama == nil) {
        return NO;
    }
    [self.queue inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:@"delete from student where name = ?",student.nama];
        if (result) {
            NSLog(@"删除成功");
        }else{
            NSLog(@"删除成功");
        }
    }];
    return YES;

}

-(BOOL)updateStudent:(Student *)student
{
    if (student.nama == nil) {
        return NO;
    }
    [self.queue inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:@"update student set name = ?, age = ?, address = ? where name = ?",student.nama,student.age,student.address,student.nama];
        if (result) {
            NSLog(@"更改成功");
        }else{
            NSLog(@"更改失败");
        }
    }];
    return YES;
}

-(BOOL)findStudentByName:(NSString *)name
{
    [self.queue inDatabase:^(FMDatabase *db) {
        FMResultSet *result = [db executeQuery:@"select * from student where name = ?",name];
        int a = 0;
        while ([result next]) {
            a = 1;
            Student *student = [[Student alloc] init];
            student.nama = [result stringForColumn:@"name"];
            NSLog(@"%@",student.nama);
            student.age = [result stringForColumn:@"age"];
            NSLog(@"%@",student.age);
            student.address = [result stringForColumn:@"address"];
            NSLog(@"%@",student.address);
        }
        if (a == 1) {
            NSLog(@"查找成功");
        }else{
            NSLog(@"查找失败");
        }


    }];
    
    return YES;
}

-(void)executeWithTransaction
{
    [self.queue inDatabase:^(FMDatabase *db) {
        [db beginTransaction];
        [db executeUpdate:@"update student set name = ? where name = ?",@"huangzengquan",@"quan"];
        [db executeUpdate:@"update student set name = ? where name = ?",@"huangzengquan1",@"quan"];
        if ([db hadError]) {
           [db rollback];
            NSLog(@"回滚");
        }
        [db commit];
        
    }];


}






@end
