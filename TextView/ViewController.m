//
//  ViewController.m
//  TextView
//
//  Created by XinGou on 2017/11/14.
//  Copyright © 2017年 XinGou. All rights reserved.
//

#import "ViewController.h"
#import "UITextView+ZYZTextView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITextView *vc = [[UITextView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    vc.zyz_placeholder = @"请输入。。。。";
    vc.zyz_placeholderFont = [UIFont systemFontOfSize:10];
    [self.view addSubview:vc];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
