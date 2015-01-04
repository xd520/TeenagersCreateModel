//
//  SettingViewController.m
//  TeenagersCreateModel
//
//  Created by Yonghui Xiong on 14-12-11.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "SettingViewController.h"
#import "AppDelegate.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadView {
    [super loadView];
    UIView *baseView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    baseView.backgroundColor = [ColorUtil colorWithHexString:@"eeeeee"];
    //baseView.backgroundColor = [UIColor grayColor];
    self.view = baseView;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //相对于上面的接口，这个接口可以动画的改变statusBar的前景色
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    
    statusBarView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"title_bg"]];
    
    [self.view addSubview:statusBarView];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    UIImageView *navImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 320, 44)];
    navImageView.image = [UIImage imageNamed:@"title_bg"];
    navImageView.userInteractionEnabled = YES;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 12, 120, 20)];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.text = @"设置";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [navImageView addSubview:titleLabel];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 12, 40, 20);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"return_ico"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [navImageView addSubview:backBtn];
    [self.view addSubview:navImageView];
    
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(110, 110, 100, 100)];
    logoView.image = [UIImage imageNamed:@"ic_launcher.png"];
    [self.view addSubview:logoView];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 242, 300, 15)];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [ColorUtil colorWithHexString:@"2d2d2d"];
    [title setBackgroundColor:[UIColor clearColor]];
    title.text = @"青创板 iPhone版";
    title.font =[UIFont systemFontOfSize:14];
    [self.view addSubview:title];
    //添加版本 Label
    
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    //CFShow((__bridge CFTypeRef)(infoDic));
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
    UILabel *version = [[UILabel alloc] initWithFrame:CGRectMake(10, 268, 300, 15)];
    version.textAlignment = NSTextAlignmentCenter;
    version.textColor = [ColorUtil colorWithHexString:@"929292"];
    [version setBackgroundColor:[UIColor clearColor]];
    version.font =[UIFont systemFontOfSize:13];
    version.text = [NSString stringWithFormat:@"v%@", currentVersion];
    [self.view addSubview:version];
    
    
    
    UILabel *zname = [[UILabel alloc] initWithFrame:CGRectMake(10, 395, 300, 13)];
    zname.textAlignment = NSTextAlignmentCenter;
    [zname setBackgroundColor:[UIColor clearColor]];
    zname.text = @"顶点软件  版权所有";
    zname.textColor = [ColorUtil colorWithHexString:@"929292"];
    zname.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:zname];
    
    
    UILabel *copy = [[UILabel alloc] initWithFrame:CGRectMake(10, 420, 300, 11)];
    copy.textAlignment = NSTextAlignmentCenter;
    [copy setBackgroundColor:[UIColor clearColor]];
    copy.text = @"Copyright Apex.";
    copy.textColor = [ColorUtil colorWithHexString:@"929292"];
    copy.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:copy];
    UILabel *ename = [[UILabel alloc] initWithFrame:CGRectMake(10, 441, 300, 11)];
    ename.textAlignment = NSTextAlignmentCenter;
    [ename setBackgroundColor:[UIColor clearColor]];
    ename.text = @"All Rights Reserved.";
    ename.textColor = [ColorUtil colorWithHexString:@"929292"];
    ename.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:ename];
    
    
    
    
    UIButton *followBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    followBtn.frame = CGRectMake(20.f,305,280, 40);
    followBtn.backgroundColor = [ColorUtil colorWithHexString:@"37B3D9"];
    [followBtn setTitle:@"检查新版本" forState:UIControlStateNormal];
    [followBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [followBtn addTarget:self action:@selector(commitMethods) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:followBtn];

    
    
}

- (void)requestCategoryList:(kBusinessTag)_tag
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"请求品牌列表");
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
     [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:_tag owner:self];
    
}


#pragma mark - NetworkModuleDelegate Methods
-(void)beginPost:(kBusinessTag)tag{
    
}
-(void)endPost:(NSString *)result business:(kBusinessTag)tag{
    NSLog(@"%s %d 收到数据:%@", __FUNCTION__, __LINE__, result);
    NSMutableDictionary *jsonDic = [result JSONValue];
    
	if (tag==kBusinessTagGetCheckIos ) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([[jsonDic objectForKey:@"success"] boolValue] == NO) {
            //数据异常处理
            
            if ([[jsonDic objectForKey:@"object"] isEqualToString:@"loginTimeout"]) {
                
                LoginViewController *vc = [[LoginViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:NO];
                
            } else {
                
                [self.view makeToast:[jsonDic objectForKey:@"msg"]];
            }
            //            subing = NO;
        } else {
            NSMutableDictionary *dataArray = [jsonDic objectForKey:@"object"];
             [self onCheckVersion:[dataArray objectForKey:@"version"]];
        }
    }
    [[NetworkModule sharedNetworkModule] cancel:tag];
}
-(void)errorPost:(NSError *)err business:(kBusinessTag)tag{
    NSLog(@"%s Error:%@", __FUNCTION__, @"连接数据服务器超时");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法连接" message:@"您所在地的网络信号微弱，无法连接到服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    if (tag==kBusinessTagGetCheckIos) {
       [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    [[NetworkModule sharedNetworkModule] cancel:tag];
}





-(void)onCheckVersion:(NSString *)lastVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    //CFShow((__bridge CFTypeRef)(infoDic));
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
    /*
    NSString *URL = @"http://itunes.apple.com/lookup?id=你的应用程序的ID";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = nil;
    NSData *recervedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    NSString *results = [[NSString alloc] initWithBytes:[recervedData bytes] length:[recervedData length] encoding:NSUTF8StringEncoding];
    NSDictionary *dic = [results JSONValue];
    NSArray *infoArray = [dic objectForKey:@"results"];
    if ([infoArray count]) {
        NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
        NSString *lastVersion = [releaseInfo objectForKey:@"version"];
        */
        if (![lastVersion isEqualToString:currentVersion]) {
            //trackViewURL = [releaseInfo objectForKey:@"trackVireUrl"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"有新的版本更新，是否前往更新？" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"更新", nil];
            alert.tag = 10000;
            [alert show];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"此版本为最新版本" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.tag = 10001;
            [alert show];
        }
   // }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==10000) {
        if (buttonIndex==1) {
            NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com"];
            [[UIApplication sharedApplication]openURL:url];
        }
    }
}



-(void) commitMethods{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = YES; //加层阴影
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"加载中...";
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [self requestCategoryList:kBusinessTagGetCheckIos];
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });
    
    
}


-(void)push {
    
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
