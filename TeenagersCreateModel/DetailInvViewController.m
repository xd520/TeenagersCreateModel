//
//  DetailInvViewController.m
//  TeenagersCreateModel
//
//  Created by Yonghui Xiong on 14-12-30.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "DetailInvViewController.h"

@interface DetailInvViewController ()

@end

@implementation DetailInvViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@",self.dic);
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    img.userInteractionEnabled = YES;
    img.image = [UIImage imageNamed:@"title_bg"];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(50, 20 + 12, ScreenWidth - 100, 20)];
    title.text = @"我的投资详情";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:18];
    [img addSubview:title];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 20 + 12, 40, 20);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"return_ico"]
                       forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [img addSubview:backBtn];
    
    [self.view addSubview:img];
    
//认购金额
    UILabel *nameLabe = [[UILabel alloc] initWithFrame:CGRectMake(10, 71, ScreenWidth - 20, 18)];
    nameLabe.text = [self.dic objectForKey:@"FID_CPMC"];
    nameLabe.font = [UIFont boldSystemFontOfSize:18];
    [self.view addSubview:nameLabe];
    
    UILabel *rgjeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 94, 100, 13)];
    rgjeNameLabel.text = @"认购金额:";
    rgjeNameLabel.textAlignment = NSTextAlignmentRight;
    rgjeNameLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:rgjeNameLabel];
    
    UILabel *rgjeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 94 + 13, ScreenWidth - 20, 17)];
    rgjeLabel.text = [NSString stringWithFormat:@"%.2f",[[self.dic objectForKey:@"FID_RGJE"] floatValue]];
    rgjeLabel.textAlignment = NSTextAlignmentCenter;
    rgjeLabel.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:rgjeLabel];
    
//冻结金额
    
    
    UILabel *djjeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 134, 100, 13)];
    djjeNameLabel.text = @"冻结金额:";
    djjeNameLabel.textAlignment = NSTextAlignmentRight;
    djjeNameLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:djjeNameLabel];
    
    UILabel *djjeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 147, ScreenWidth - 20, 17)];
    djjeLabel.text = [NSString stringWithFormat:@"%.2f",[[self.dic objectForKey:@"FID_DJJE"] floatValue]];
    djjeLabel.textAlignment = NSTextAlignmentCenter;
    djjeLabel.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:djjeLabel];
//产品代码
    UILabel *codeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 174, 100, 13)];
    codeNameLabel.text = @"产品代码:";
    codeNameLabel.textAlignment = NSTextAlignmentRight;
    codeNameLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:codeNameLabel];
    
    UILabel *codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 174, 100, 13)];
    codeLabel.text = [self.dic objectForKey:@"FID_CPDM"];
    codeLabel.textAlignment = NSTextAlignmentCenter;
    codeLabel.font = [UIFont boldSystemFontOfSize:13];
    [self.view addSubview:codeLabel];
    
    
    
//产品状态
    UILabel *stutasNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 194, 100, 13)];
    stutasNameLabel.text = @"产品状态:";
    stutasNameLabel.textAlignment = NSTextAlignmentRight;
    stutasNameLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:stutasNameLabel];
    
    UILabel *stutasLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 194, 100, 13)];
    stutasLabel.text = [self.dic objectForKey:@"FID_STATUS"];
    stutasLabel.textAlignment = NSTextAlignmentCenter;
    stutasLabel.font = [UIFont boldSystemFontOfSize:13];
    [self.view addSubview:stutasLabel];
    
//认购日期
    UILabel *buyNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 214, 100, 13)];
    buyNameLabel.text = @"认购日期:";
    buyNameLabel.textAlignment = NSTextAlignmentRight;
    buyNameLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:buyNameLabel];
    
    UILabel *buyLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 214, 100, 13)];
    buyLabel.text = [self.dic objectForKey:@"FID_RGRQ"];
    buyLabel.textAlignment = NSTextAlignmentCenter;
    buyLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:buyLabel];
    
//委托号
    UILabel *delegateNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 234, 100, 13)];
    delegateNameLabel.text = @"委托号:";
     delegateNameLabel.textAlignment = NSTextAlignmentRight;
    delegateNameLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:delegateNameLabel];
    
    UILabel *delegateLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 234, 100, 13)];
    delegateLabel.text = [self.dic objectForKey:@"FID_WTH"];
    delegateLabel.textAlignment = NSTextAlignmentCenter;
    delegateLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:delegateLabel];
    
//客户号
    UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 254, 100, 13)];
    userNameLabel.text = @"客户号:";
     userNameLabel.textAlignment = NSTextAlignmentRight;
    userNameLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:userNameLabel];
    
    UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 254, 200, 13)];
    userLabel.text = [self.dic objectForKey:@"FID_KHH"];
    userLabel.textAlignment = NSTextAlignmentCenter;
    userLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:userLabel];
    
//申请状态
    UILabel *sqNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 274, 100, 13)];
    sqNameLabel.text = @"申请状态:";
    sqNameLabel.textAlignment = NSTextAlignmentRight;
    sqNameLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:sqNameLabel];
    
    UILabel *sqLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 274, 100, 17)];
    sqLabel.text = [self.dic objectForKey:@"FID_ZT"];
    sqLabel.textAlignment = NSTextAlignmentCenter;
    sqLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:sqLabel];
//撤销标志
    UILabel *cxNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 294, 100, 13)];
    cxNameLabel.text = @"撤销标志:";
    cxNameLabel.textAlignment = NSTextAlignmentRight;
    cxNameLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:cxNameLabel];
    
    UILabel *cxLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 294, 100, 13)];
    cxLabel.text = [self.dic objectForKey:@"FID_CXBZ"];
    cxLabel.textAlignment = NSTextAlignmentCenter;
    cxLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:cxLabel];
    
    
    
    
    
}

-(void)push {
    [self.navigationController popViewControllerAnimated:YES];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
