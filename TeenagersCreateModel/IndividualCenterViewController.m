//
//  IndividualCenterViewController.m
//  TeenagersCreateModel
//
//  Created by mac on 14-10-11.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "IndividualCenterViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "MyInfoViewController.h"
#import "Customer.h"
#import "MyFundViewController.h"
#import "MyInvViewController.h"
#import "MyPrjViewController.h"
#import "InvestorsViewController.h"
#import "SeniorInvestorsViewController.h"
#import "LeadingInvestmentViewController.h"
#import "SettingViewController.h"

@interface IndividualCenterViewController ()
{
   
    UIButton *loginBtn;
   
    UILabel *loginEndLabel;
    UIButton *regestBtn;
    UIView *isView;
    float scrollViewHight;
    UIScrollView *scrollView;
    UIImageView *isLtrView;
    UIImageView *isYBTZRView;
    UIImageView *isGJTZRView;
    UIButton *btn1;
    UIButton *btn2;
    UIButton *btn3;
}
@end

@implementation IndividualCenterViewController
@synthesize loginLabel,headImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.title = @"个人中心";
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    //[self performSelector:@selector(reloadData)];
    
    [self reloadData];
}


-(void)loadView {
    UIView *baseView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    baseView.backgroundColor = [ColorUtil colorWithHexString:@"eeeeee"];
    self.view = baseView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
#endif
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
   
    
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 49)];
    [scrollView setContentSize:CGSizeMake(ScreenWidth, 600)];
    
    UIImageView *loginView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 135)];
    loginView.image = [UIImage imageNamed:@"not_login_bg.jpg"];
    loginView.userInteractionEnabled = YES;
//加图层
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.backgroundColor = [UIColor whiteColor].CGColor;
    UIBezierPath *layerPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(1, 1, 58, 58)];
    maskLayer.path = layerPath.CGPath;
    maskLayer.fillColor = [UIColor blackColor].CGColor;
    
    UIView *clippingViewForLayerMask = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
    clippingViewForLayerMask.layer.mask = maskLayer;
    clippingViewForLayerMask.clipsToBounds = YES;
    [loginView addSubview:clippingViewForLayerMask];
    
    
    UIImageView *baseV = [[UIImageView alloc]initWithFrame:CGRectMake(320 - 30, 45, 10, 10)];
    baseV.image = [UIImage imageNamed:@"setting_arrow"];
    
    [loginView addSubview:baseV];
    
    
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    baseView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *baseTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callPhone:)];
    baseView.tag = 100000;
    //单点触摸
    baseTap.numberOfTouchesRequired = 1;
    //点击几次，如果是1就是单击
    baseTap.numberOfTapsRequired = 1;
    [baseView addGestureRecognizer:baseTap];
    [loginView addSubview:baseView];
    
    
    isView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, ScreenWidth, 35)];
    isView.backgroundColor = [UIColor clearColor];
    //[isView setTintColor:[UIColor redColor]];
    
    if (delegate.array.count > 0) {
        
        Customer *customer = [delegate.array objectAtIndex:0];
        if (customer.loginSueccss == YES) {
            isView.hidden = NO;
        } else {
        isView.hidden = YES;
        
        }
    } else {
      isView.hidden = YES;
        
    }
    
   [loginView addSubview:isView];
    
   
    
    
    headImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    headImage.backgroundColor = [UIColor lightGrayColor];
    
    if (delegate.array.count > 0) {
        
        Customer *customer = [delegate.array objectAtIndex:0];
        if (customer.loginSueccss) {
            headImage.image = customer.icon;
        } else {
            headImage.image = [UIImage imageNamed:@"xd1"];
            
        }
    } else {
    
     headImage.image = [UIImage imageNamed:@"xd1"];
    }

    
    
    //headImage.hidden = YES;
    
    [clippingViewForLayerMask addSubview:headImage];
    
    
    loginEndLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 63, ScreenWidth - 130, 12)];
    loginEndLabel.font = [UIFont systemFontOfSize:12];
    loginEndLabel.textAlignment = NSTextAlignmentCenter;
    loginEndLabel.text = @"";
    [loginView addSubview:loginEndLabel];
    
    
    
    loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake((ScreenWidth - 110)/2, 62, 110, 35) ;
    [loginBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
    [loginBtn setImage:[UIImage imageNamed:@"click_login"] forState:UIControlStateNormal];
    UILabel *loginBtnLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 110, 15)];
    loginBtnLabel.font = [UIFont boldSystemFontOfSize:15];
    loginBtnLabel.textColor = [UIColor brownColor];
    loginBtnLabel.textAlignment = NSTextAlignmentCenter;
    loginBtnLabel.text = @"登录/注册";
    [loginBtn addSubview:loginBtnLabel];
    [loginBtn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    if (delegate.array.count > 0) {
        
        Customer *customer = [delegate.array objectAtIndex:0];
        if (customer.loginSueccss) {
            loginBtn.hidden = YES;
        } else {
           loginBtn.hidden = NO;
            
        }
    }else {
    
     loginBtn.hidden = NO;
    }

    
    [loginView addSubview:loginBtn];
    
    loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 40, ScreenWidth - 150, 13)];
    loginLabel.font = [UIFont boldSystemFontOfSize:13];
    loginLabel.textAlignment = NSTextAlignmentCenter;
    if (delegate.array.count > 0) {
        
        Customer *customer = [delegate.array objectAtIndex:0];
        if (customer.loginSueccss) {
             loginLabel.text = [NSString stringWithFormat:@"欢迎您，%@，登录成功！",customer.customerName];
        } else {
            loginLabel.text = @"欢迎来到投资管理系统";
            
        }
    } else {
        loginLabel.text = @"欢迎来到投资管理系统";
        
    }
    
    
   
    [loginView addSubview:loginLabel];
     [scrollView addSubview:loginView];
    
    
//1
    UIImageView *oneView = [[UIImageView alloc] initWithFrame:CGRectMake(0, loginView.frame.origin.y + loginView.frame.size.height + 10, ScreenWidth, 44)];
    oneView.image = [UIImage imageNamed:@"head_bg"];
    oneView.userInteractionEnabled = YES;
    
    UIImageView *starView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 24, 24)];
    starView.image = [UIImage imageNamed:@"12"];
    starView.userInteractionEnabled = YES;
    [oneView addSubview:starView];
    
    UILabel *starLabel = [[UILabel alloc] initWithFrame:CGRectMake(55,14, 100, 15)];
    starLabel.font = [UIFont systemFontOfSize:15];
    starLabel.text = @"我的资产";
    [oneView addSubview:starLabel];
   UIImageView *pushView = [[UIImageView alloc]initWithFrame:CGRectMake(320 - 30, 17, 10, 10)];
    pushView.image = [UIImage imageNamed:@"setting_arrow"];
    
    [oneView addSubview:pushView];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callPhone:)];
    oneView.tag = 101;
    //单点触摸
    singleTap.numberOfTouchesRequired = 1;
    //点击几次，如果是1就是单击
    singleTap.numberOfTapsRequired = 1;
    [oneView addGestureRecognizer:singleTap];
    
    [scrollView addSubview:oneView];
//2
    UIImageView *oneView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, oneView.frame.origin.y + oneView.frame.size.height, ScreenWidth, 44)];
    oneView1.image = [UIImage imageNamed:@"head_bg"];
    oneView1.userInteractionEnabled = YES;
    
    UIImageView *starView1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 7, 30, 30)];
    starView1.image = [UIImage imageNamed:@"13"];
    starView1.userInteractionEnabled = YES;
    [oneView1 addSubview:starView1];
    
    UILabel *starLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(55,15, 100, 14)];
    starLabel1.font = [UIFont systemFontOfSize:14];
    starLabel1.text = @"我的投资";
    
    [oneView1 addSubview:starLabel1];
    
    UIImageView *pushView1 = [[UIImageView alloc]initWithFrame:CGRectMake(320 - 30, 17, 10, 10)];
    pushView1.image = [UIImage imageNamed:@"setting_arrow"];
    
    
    [oneView1 addSubview:pushView1];
    
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callPhone:)];
    oneView1.tag = 102;
    //单点触摸
    singleTap1.numberOfTouchesRequired = 1;
    //点击几次，如果是1就是单击
    singleTap1.numberOfTapsRequired = 1;
    [oneView1 addGestureRecognizer:singleTap1];
    
    [scrollView addSubview:oneView1];
//3
    UIImageView *oneView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, oneView1.frame.origin.y + oneView1.frame.size.height + 10, ScreenWidth, 44)];
    oneView2.image = [UIImage imageNamed:@"head_bg"];
    oneView2.userInteractionEnabled = YES;
    
    UIImageView *starView2 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 7, 30, 30)];
    starView2.image = [UIImage imageNamed:@"14"];
    starView2.userInteractionEnabled = YES;
    [oneView2 addSubview:starView2];
    
    UILabel *starLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(55,15, 100, 14)];
    starLabel2.font = [UIFont systemFontOfSize:14];
    starLabel2.text = @"我的项目";
    [oneView2 addSubview:starLabel2];
    
    UIImageView *pushView2 = [[UIImageView alloc]initWithFrame:CGRectMake(320 - 30, 17, 10, 10)];
    pushView2.image = [UIImage imageNamed:@"setting_arrow"];
    
    [oneView2 addSubview:pushView2];
    UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callPhone:)];
    oneView2.tag = 103;
    //单点触摸
    singleTap2.numberOfTouchesRequired = 1;
    //点击几次，如果是1就是单击
    singleTap2.numberOfTapsRequired = 1;
    [oneView2 addGestureRecognizer:singleTap2];
    [scrollView addSubview:oneView2];
    
//4
    UIImageView *oneView3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, oneView2.frame.origin.y + oneView2.frame.size.height, ScreenWidth, 44)];
    oneView3.image = [UIImage imageNamed:@"head_bg"];
    oneView3.userInteractionEnabled = YES;
    
    UIImageView *starView3 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 7, 30, 30)];
    starView3.image = [UIImage imageNamed:@"11"];
    starView3.userInteractionEnabled = YES;
    [oneView3 addSubview:starView3];
    
    UILabel *starLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(55,15, 100, 14)];
    starLabel3.font = [UIFont systemFontOfSize:14];
    starLabel3.text = @"我的设置";
    [oneView3 addSubview:starLabel3];
    
    UIImageView *pushView3 = [[UIImageView alloc]initWithFrame:CGRectMake(320 - 30, 17, 10, 10)];
    pushView3.image = [UIImage imageNamed:@"setting_arrow"];
    [oneView3 addSubview:pushView3];
    UITapGestureRecognizer *singleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callPhone:)];
    oneView3.tag = 100;
    //单点触摸
    singleTap3.numberOfTouchesRequired = 1;
    //点击几次，如果是1就是单击
    singleTap3.numberOfTapsRequired = 1;
    [oneView3 addGestureRecognizer:singleTap3];
    [scrollView addSubview:oneView3];
    
 
    
    regestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    regestBtn.frame = CGRectMake(20, oneView3.frame.origin.y + oneView3.frame.size.height + 10, ScreenWidth - 40, 40);
    [regestBtn setBackgroundImage:[UIImage imageNamed:@"head_bg"] forState:UIControlStateNormal];
    UILabel *lab6 = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, ScreenWidth - 200 - 40, 40)];
    lab6.font = [UIFont boldSystemFontOfSize:17];
    lab6.textColor = [UIColor redColor];
    lab6.text = @"退出登录";
    lab6.textAlignment = NSTextAlignmentCenter;
    [regestBtn addSubview:lab6];
    [regestBtn addTarget:self action:@selector(regestBtn) forControlEvents:UIControlEventTouchUpInside];
    regestBtn.hidden = YES;
    [scrollView addSubview:regestBtn];
    [self.view addSubview:scrollView];
    
    [self reloadData];
    [self reloadView];
}



- (IBAction)callPhone:(UITouch *)sender
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (delegate.array.count > 0) {
        Customer *customer = [delegate.array objectAtIndex:0];
    if (customer.loginSueccss) {
        
    UIView *view = [sender view];
        if (view.tag == 100) {
            
          //
            SettingViewController *controller = [[SettingViewController alloc] init];
            
            
            controller.hidesBottomBarWhenPushed = YES;
            // controller.productId = [NSString stringWithFormat:@"%d",view.tag];
            // controller.orderListViewController = self;
            [self.navigationController pushViewController:controller animated:NO];
        }else if (view.tag == 100000){
            
             MyInfoViewController *controller = [[MyInfoViewController alloc] init];
            controller.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:controller animated:NO];
            
        } else if (view.tag == 101){
            
            MyFundViewController *controller = [[MyFundViewController alloc] init];
            ;
            controller.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:controller animated:NO];
            
        } else if (view.tag == 102){
            MyInvViewController *controller = [[MyInvViewController alloc] init];
            ;
            controller.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:controller animated:NO];
        }else if (view.tag == 103){
            MyPrjViewController *controller = [[MyPrjViewController alloc] init];
            ;
            controller.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:controller animated:NO];
        }else if (view.tag == 104){
            MyInfoViewController *controller = [[MyInfoViewController alloc] init];
            ;
            controller.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:controller animated:NO];
        }
    
    } else {
        LoginViewController *vc = [[LoginViewController alloc] init];
        vc.myViewController = self;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:NO];
    
    }
    } else {
        LoginViewController *vc = [[LoginViewController alloc] init];
        vc.myViewController = self;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:NO];
    }

}


-(void)regestBtn{
    UIAlertView *outAlert = [[UIAlertView alloc] initWithTitle:@"注销" message:@"是否要退出该帐号" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [outAlert show];
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.dimBackground = YES; //加层阴影
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"加载中...";
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            [self requestCategoryList:kBusinessTagGetLogOut];
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
        });
        

    }
}

//获取品牌列表
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
	if (tag==kBusinessTagGetLogOut ) {
       [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (result.length > 7) {
            NSDictionary *dic = [result JSONValue];
            if ([[dic objectForKey:@"object"] isEqualToString:@"loginTimeout"]) {
                LoginViewController *vc = [[LoginViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:NO];
                
            }
            
        } else {
        
        if ([result isEqualToString:@"success"] == 0) {
            //数据异常处理
            [self.view makeToast:@"注销失败"];
            
        } else {
            
            loginEndLabel.hidden = YES;
            isView.hidden = YES;
            //[isView removeFromSuperview];
            loginBtn.hidden = NO;
            regestBtn.hidden = YES;
            //[regestBtn removeFromSuperview];
            loginLabel.text = @"欢迎来到股权众筹中心!";
            AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [delegate.array removeAllObjects];
            //delegate.array = nil;
            headImage.image = [UIImage imageNamed:@"xd1"];
            
            }
        }
    }
    [[NetworkModule sharedNetworkModule] cancel:tag];
}
-(void)errorPost:(NSError *)err business:(kBusinessTag)tag{
    NSLog(@"%s Error:%@", __FUNCTION__, @"连接数据服务器超时");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法连接" message:@"您所在地的网络信号微弱，无法连接到服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    if (tag == kBusinessTagGetLogOut) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    [[NetworkModule sharedNetworkModule] cancel:tag];
}

-(void) reloadView {

    isGJTZRView = [[UIImageView alloc] initWithFrame:CGRectMake(110, 0, 110, 35)];
    isGJTZRView.image = [UIImage imageNamed:@"gjtzr"];
    isYBTZRView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 110, 35)];
    isYBTZRView.image = [UIImage imageNamed:@"hgtzr"];
   
    [isView addSubview:isGJTZRView];
    [isView addSubview:isYBTZRView];

    
    btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, 110, 35);
    [btn1 setBackgroundImage:[UIImage imageNamed:@"no_hgtzr"] forState:UIControlStateNormal];
    
    btn1.tag = 1;
    [btn1 addTarget:self action:@selector(registerMethods:) forControlEvents:UIControlEventTouchUpInside];
    //[btn addSubview:isLable];
    [isView addSubview:btn1];
   
    isLtrView = [[UIImageView alloc] initWithFrame:CGRectMake(220, 0, 110, 35)];
    isLtrView.image = [UIImage imageNamed:@"ltr"];
    
    [isView addSubview:isLtrView];
    
    btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(110, 0, 110, 35);
    [btn2 setBackgroundImage:[UIImage imageNamed:@"no_gjtzr"] forState:UIControlStateNormal];
    btn2.tag = 2;
    [btn2 addTarget:self action:@selector(registerMethods:) forControlEvents:UIControlEventTouchUpInside];
    [isView addSubview:btn2];
    
    btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(220, 0, 100, 35);
    [btn3 setBackgroundImage:[UIImage imageNamed:@"no_ltr"] forState:UIControlStateNormal];
    
    btn3.tag = 3;
    [btn3 addTarget:self action:@selector(registerMethods:) forControlEvents:UIControlEventTouchUpInside];
    [isView addSubview:btn3];
    
}


-(void) reloadData {
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (delegate.array.count > 0) {
//登录成功之后
        Customer *customer = [delegate.array objectAtIndex:0];
        
        if (customer.loginSueccss == YES) {
            
      
        [loginLabel setText:[NSString stringWithFormat:@"欢迎您，%@，登录成功！",customer.customerName]];
       // [loginLabel setText:[NSString stringWithFormat:@"成功登录！客户号:%@",customer.customerNum]];
        //headImage.hidden = NO;
        headImage.image = customer.icon;
        isView.hidden = NO;
       
        loginEndLabel.hidden = NO;
        loginBtn.hidden = YES;
        
        regestBtn.hidden = NO;
        
 //是否为高级投资人
        if (customer.isGJTZR) {
            btn1.hidden = YES;
           
            btn2.hidden = YES;
           
            isGJTZRView.hidden = NO;
            isYBTZRView.hidden = NO;
        } else {
            isGJTZRView.hidden = YES;
            
            //是否为一般投资人
            if (customer.isHGTZR) {
                isYBTZRView.hidden = NO;
                btn1.hidden = YES;
                
                
            } else {
                isYBTZRView.hidden = YES;
                
                 btn1.hidden = NO;
                
            }

           btn2.hidden =  NO;
            
        }
//是否为领投人
        if (customer.isLTR) {
            btn3.hidden = YES;
            isLtrView.hidden = NO;
            
        } else {
            isLtrView.hidden = YES;
           
           btn3.hidden = NO;
        }
    }
        
    }
}

-(void)registerMethods:(UIButton *)btn {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
     Customer *customer = [delegate.array objectAtIndex:0];
    if (btn.tag == 1) {
        if ([customer.sessionId isEqualToString:@"0"]) {
      //个人
            InvestorsViewController *cv = [[InvestorsViewController alloc] init];
            cv.titleName = @"个人升级合格投资人申请";
            cv.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:cv animated:NO];
            
        } else {
        //机构
            SeniorInvestorsViewController *cv = [[SeniorInvestorsViewController alloc] init];
            cv.title = @"机构升级合格投资人申请";
            cv.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:cv animated:NO];
        }
        
        
    } else if (btn.tag == 2){
        if ([customer.sessionId isEqualToString:@"0"]) {
            //个人
            InvestorsViewController *cv = [[InvestorsViewController alloc] init];
            cv.titleName = @"个人升级高级投资人申请";
            cv.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:cv animated:NO];
            
        } else {
            //机构
            SeniorInvestorsViewController *cv = [[SeniorInvestorsViewController alloc] init];
             cv.title = @"机构升级高级投资人申请";
            cv.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:cv animated:NO];
        }

    } else if (btn.tag == 3){
        
  //先判定是否为投资人权限
        if (customer.isTZRQX) {
        if (customer.isLTR == NO) {
       
        LeadingInvestmentViewController *cv = [[LeadingInvestmentViewController alloc] init];
        cv.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cv animated:NO];
        }
        } else {
        
            [self.view makeToast:@"请首先申请成为投资人" duration:0.5 position:@"center"];
        
        }
    }

}



#pragma mark - user methods
-(void)push {
    LoginViewController *controller = [[LoginViewController alloc] init];
    controller.myViewController = self;
    controller.hidesBottomBarWhenPushed = YES;
    //controller.customerName = loginLabel.text;
    [self.navigationController pushViewController:controller animated:NO];
    
}

-(void)dealloc {
    [scrollView removeFromSuperview];
    scrollView = nil;
    [loginLabel removeFromSuperview];
    loginLabel = nil;
    [headImage removeFromSuperview];
    headImage = nil;
    [loginBtn removeFromSuperview];
    loginBtn = nil;
    
    [loginEndLabel removeFromSuperview];
    loginEndLabel = nil;
    [regestBtn removeFromSuperview];
    regestBtn = nil;

    [isView removeFromSuperview];
    isView = nil;
    [isLtrView removeFromSuperview];
    isLtrView = nil;
    [isYBTZRView removeFromSuperview];
    [isGJTZRView removeFromSuperview];
    isYBTZRView = nil;
    isGJTZRView = nil;
    [btn1 removeFromSuperview];
    [btn2 removeFromSuperview];
    [btn3 removeFromSuperview];
    btn2 = nil;
    btn3 = nil;
    btn1 = nil;
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}


@end
