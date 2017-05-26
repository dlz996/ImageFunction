//
//  ViewController.m
//  ImageModule
//
//  Created by 董立峥 on 2017/5/24.
//  Copyright © 2017年 芦苇科技. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * tableView;
@end
static NSString * const CellID = @"cellid";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor redColor]];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellID];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    cell.textLabel.text = @[@"拍照",@"选取照片",@"方形/原型剪切",@"编辑",@"滤镜"][indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            [self.navigationController pushViewController:[[PhotographController alloc]init] animated:YES];
        }
            break;
        case 1:{
            [self.navigationController pushViewController:[[SelectImageController alloc]init] animated:YES];
        }
            break;
        case 2:{
            [self.navigationController pushViewController:[[ShearImageController alloc]init] animated:YES];
        }
            break;
        case 3:{
            [self.navigationController pushViewController:[[TuEditController alloc]init] animated:YES];
        }
            break;
        case 4:{
            [self.navigationController pushViewController:[[FilterImageController alloc]init] animated:YES];
        }
            break;
        default:
            break;
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
