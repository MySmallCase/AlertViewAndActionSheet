//
//  ViewController.m
//  AlertViewAndActionSheet
//
//  Created by MyMac on 15/9/22.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import "ViewController.h"
#import "AlertView.h"
#import "ActionSheet.h"
#import <Masonry.h>

@interface ViewController ()<AlertViewDelegate>

@property (nonatomic,strong) UIButton *alert1;

@property (nonatomic,strong) UIButton *alert2;

@property (nonatomic,strong) UIButton *actionSheet1;

@property (nonatomic,strong) UIButton *actionSheet2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.alert1];
    [self.view addSubview:self.alert2];
    [self.view addSubview:self.actionSheet1];
    [self.view addSubview:self.actionSheet2];
    
}

- (void)alert1Clck{
    AlertView *alert = [[AlertView alloc] initWithTitle:@"这是一个警告框" WithDesc:@"这里可以填一些详细内容这里可以填一些详细内容这里可以填一些详细内容这里可以填一些详细内容这里可以填一些详细内容"];
    alert.btnTitleArray = @[@"按钮一",@"按钮二",@"按钮一",@"按钮二"];
    alert.delegate = self;
    [alert showAnimation1];

}

- (void)alert2Clck{
    AlertView *alert = [[AlertView alloc]init];
    alert.containViewHeight = 100;
    CGFloat width = alert.containView.frame.size.width;
    UIImageView *avatar = [[UIImageView alloc]initWithFrame:CGRectMake((width - 60)/2, 10, 60, 60)];
    avatar.layer.cornerRadius = 30;
    avatar.layer.masksToBounds = true;
    avatar.image = [UIImage imageNamed:@"cute_girl"];
    avatar.backgroundColor = [UIColor redColor];
    [alert.containView addSubview:avatar];

    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(0, 10 + 60 + 10,width, 20)];
    name.text = @"StrongX";
    name.textColor = [UIColor darkGrayColor];
    name.textAlignment = NSTextAlignmentCenter;
    [alert.containView addSubview:name];

    alert.btnTitleArray = @[@"确定",@"关闭"];
    alert.delegate = self;
    [alert showAnimation2];
}

- (void)actionSheet1Clck{
    
    ActionSheet *sheet = [[ActionSheet alloc] initWithTitle:@"这是一个上啦菜单" Desc:@"你可以在这里填写一些详细内容"];
    [sheet addCancelButtonTitle:@"取消"];
    [sheet addButtonTitle:@"按钮一"];
    [sheet addButtonTitle:@"按钮二"];
    [sheet addButtonTitle:@"按钮三"];
//    sheet.delegate = self;
    [sheet showInAnimation];
}

- (void)actionSheet2Clck{
    ActionSheet *sheet = [[ActionSheet alloc] initWithTitle:@"这是一个上啦菜单" Desc:@"你可以在这里填写一些详细内容"];
    [sheet addCancelButtonTitle:@"取消"];
    [sheet addButtonTitle:@"按钮一"];
    [sheet addButtonTitle:@"按钮二"];
    [sheet addButtonTitle:@"按钮三"];
    //    sheet.delegate = self;
    [sheet show];
}

- (void)alertView:(AlertView *)alertView btnClicked:(NSInteger)index{
    NSLog(@"index==%ld",(long)index);
}

#pragma mark - getter and setter
- (UIButton *)alert1{
    if (!_alert1) {
        _alert1 = [[UIButton alloc] init];
        _alert1.backgroundColor = [UIColor redColor];
        [_alert1 setTitle:@"alert1" forState:UIControlStateNormal];
        [_alert1 addTarget:self action:@selector(alert1Clck) forControlEvents:UIControlEventTouchUpInside];
    }
    return _alert1;
}

- (UIButton *)alert2{
    if (!_alert2) {
        _alert2 = [[UIButton alloc] init];
        _alert2.backgroundColor = [UIColor redColor];
        [_alert2 setTitle:@"alert2" forState:UIControlStateNormal];
        [_alert2 addTarget:self action:@selector(alert2Clck) forControlEvents:UIControlEventTouchUpInside];
    }
    return _alert2;
}

- (UIButton *)actionSheet1{
    if (!_actionSheet1) {
        _actionSheet1 = [[UIButton alloc] init];
        _actionSheet1.backgroundColor = [UIColor redColor];
        [_actionSheet1 setTitle:@"actionSheet1" forState:UIControlStateNormal];
        [_actionSheet1 addTarget:self action:@selector(actionSheet1Clck) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionSheet1;
}


- (UIButton *)actionSheet2{
    if (!_actionSheet2) {
        _actionSheet2 = [[UIButton alloc] init];
        _actionSheet2.backgroundColor = [UIColor redColor];
        [_actionSheet2 setTitle:@"actionSheet2" forState:UIControlStateNormal];
        [_actionSheet2 addTarget:self action:@selector(actionSheet2Clck) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionSheet2;
}


#pragma mark - setting frame
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];

    [self.alert1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(@30);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(@100);
    }];
    
    [self.alert2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.alert1.mas_centerX);
        make.size.mas_equalTo(self.alert1);
        make.top.mas_equalTo(self.alert1.mas_bottom).with.offset(20);
    }];
    
    [self.actionSheet1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.alert2.mas_centerX);
        make.size.mas_equalTo(self.alert2);
        make.top.mas_equalTo(self.alert2.mas_bottom).with.offset(20);
    }];
    
    [self.actionSheet2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.actionSheet1.mas_centerX);
        make.size.mas_equalTo(self.actionSheet1);
        make.top.mas_equalTo(self.actionSheet1.mas_bottom).with.offset(20);
    }];
    
}




@end
