//
//  ViewController.m
//  FMDBExecise
//
//  Created by 黄增权 on 15/10/22.
//  Copyright (c) 2015年 黄增权. All rights reserved.
//

#import "ViewController.h"
#import "StudentDataBaseManager.h"
#import "Student.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Student *student = [[Student alloc]init];
    student.nama = @"quan";
    student.age = @"16";
    student.address = @"广州";
    StudentDataBaseManager *manager = [StudentDataBaseManager shareStudentDataBaseManager];
    if ([manager createStudentTable]) {
    //    NSLog(@"创建表成功");
    }
    if ([manager insertStudent:student]){
    //    NSLog(@"插入成功");
    }
    if ([manager updateStudent:student]) {
    //    NSLog(@"更改成功");
    }
    if ([manager findStudentByName:student.nama]) {
    //    NSLog(@"查找成功");
    }
    [manager executeWithTransaction];
    if ([manager deleateStudent:student]) {
    //    NSLog(@"删除成功");
    }
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
