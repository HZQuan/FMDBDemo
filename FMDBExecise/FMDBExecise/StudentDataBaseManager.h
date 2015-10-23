//
//  StudentDataBaseManager.h
//  FMDBExecise
//
//  Created by 黄增权 on 15/10/22.
//  Copyright (c) 2015年 黄增权. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"
#import <FMDB/FMDatabase.h>
#import <FMDB/FMDB.h>
@interface StudentDataBaseManager : NSObject
@property (nonatomic , strong)FMDatabase *db;
@property (nonatomic , strong) FMDatabaseQueue *queue;
-(BOOL) createStudentTable;
-(BOOL) insertStudent:(Student*) student;
+(instancetype) shareStudentDataBaseManager;
-(BOOL) deleateStudent:(Student *)student;
-(BOOL) updateStudent:(Student *) student;
-(BOOL) findStudentByName:(NSString*) name;
-(void) executeWithTransaction;
@end
