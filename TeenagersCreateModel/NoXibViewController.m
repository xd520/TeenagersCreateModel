//
//  NoXibViewController.m
//  TeenagersCreateModel
//
//  Created by Yonghui Xiong on 15-3-28.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "NoXibViewController.h"

@interface NoXibViewController ()
{

    float addHeight;
}
@end

@implementation NoXibViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        addHeight = 20;
        //相对于上面的接口，这个接口可以动画的改变statusBar的前景色
    } else {
        addHeight = 0;
    }
    
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, addHeight)];
    
    statusBarView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"title_bg"]];
    
    [self.view addSubview:statusBarView];
 
    
    UIImageView *ing = [[UIImageView alloc] initWithFrame:CGRectMake(0, addHeight, ScreenWidth, 44)];
    ing.image = [UIImage imageNamed:@"title_bg"];
    [self.view addSubview:ing];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
