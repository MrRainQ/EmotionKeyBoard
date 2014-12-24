//
//  HMMMMViewController.m
//   
//
//  Created by sen5labs on 14/12/22.
//  Copyright (c) 2014年  . All rights reserved.
//

#import "HMMMMViewController.h"
#import "HMComposeViewController.h"

@interface HMMMMViewController ()

@end

@implementation HMMMMViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    UIButton *plusButton = [[UIButton alloc] init];
    plusButton.bounds = CGRectMake(0, 0, 100, 100);
    plusButton.center = CGPointMake(160, 568 / 2);
    // 设置背景 test nihao
    [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
    [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    // 设置图标
    [plusButton setImage: [UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [plusButton setImage: [UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    [plusButton addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
    // 添加
    [self.view addSubview:plusButton];
}

- (void)plusClick
{
    HMComposeViewController *compose = [[HMComposeViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:compose];
    [self presentViewController:nav animated:YES completion:nil];
}


@end
