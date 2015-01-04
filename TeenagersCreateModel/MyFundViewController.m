//
//  MyFundViewController.m
//  TeenagersCreateModel
//
//  Created by Yonghui Xiong on 14-11-5.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "MyFundViewController.h"
#import "AppDelegate.h"
#import "QueryViewController.h"
#import "GoldViewController.h"
#import "IntoGoldViewController.h"
#import "BankCardViewController.h"
#import "NOGoldViewController.h"
#import "NumBindViewController.h"
#import "NoIntoGoldViewController.h"
#import "LoginViewController.h"

@interface MyFundViewController ()
{
    UILabel *bankFundLable;
    UILabel *changeFundLable;
    UILabel *outFundLable;
    UILabel *inFundLable;
    NSString *str;
}
@end

@implementation MyFundViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
         self.navigationController.navigationBarHidden = YES;
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
    str = @"";
    //相对于上面的接口，这个接口可以动画的改变statusBar的前景色
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    
    statusBarView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"title_bg"]];
    
    [self.view addSubview:statusBarView];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    UINavigationBar *navibar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 44)];
    navibar.userInteractionEnabled = YES;
    //navibar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navbar.png"]];
    [navibar setBackgroundImage:[UIImage imageNamed:@"title_bg"]  forBarMetrics:UIBarMetricsDefault];
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 12, 40, 20);
    [leftBtn setImage:[UIImage imageNamed:@"return_ico"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    
    [navibar addSubview:leftBtn];
   // UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    UINavigationItem *navibarItem = [[UINavigationItem alloc]init];
    navibarItem.title = @"我的资产";
   // navibarItem.leftBarButtonItem= leftItem;
    // self.navigationItem.rightBarButtonItem = leftItem;
    [navibar pushNavigationItem:navibarItem animated:YES];
    [self.view addSubview:navibar];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
#endif

    UILabel *myFund = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 100, 15)];
    myFund.font = [UIFont boldSystemFontOfSize:15];
    myFund.text = @"我的资金";
   // [self.view addSubview:myFund];
//入金
    UIView *inputFund = [[UIView alloc] initWithFrame:CGRectMake(10, 95, ScreenWidth/2 - 20, 70)];
    inputFund.backgroundColor = [ColorUtil colorWithHexString:@"37b063"];
    inFundLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, ScreenWidth/2 - 40, 15)];
    inFundLable.text = @"0.00￥";
    inFundLable.textAlignment = NSTextAlignmentRight;
    inFundLable.font = [UIFont boldSystemFontOfSize:15];
    inFundLable.textColor = [UIColor whiteColor];
    [inputFund addSubview:inFundLable];
    
    UILabel *inFundTip = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, ScreenWidth/2 - 40, 10)];
    inFundTip.text = @"账户余额(元)";
    inFundTip.textAlignment = NSTextAlignmentRight;
    inFundTip.font = [UIFont boldSystemFontOfSize:10];
    inFundTip.textColor = [UIColor whiteColor];
    [inputFund addSubview:inFundTip];
    [self.view addSubview:inputFund];
    
    UIButton *inFundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    inFundBtn.frame = CGRectMake(10, 185, ScreenWidth/2 - 20, 60);
    //inFundBtn.backgroundColor = [UIColor grayColor];
    UIImageView *inFundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    inFundView.image = [UIImage imageNamed:@"1"];
    [inFundBtn addSubview:inFundView];
    UILabel *infundLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 0, 70, 60)];
    infundLabel.text = @"入金";
    infundLabel.font = [UIFont systemFontOfSize:14];
    [inFundBtn addSubview:infundLabel];
    
    //[inFundBtn setTitle:@"入金" forState:UIControlStateNormal];
    inFundBtn.tag = 1;
    [inFundBtn addTarget:self action:@selector(pushButtonMethods:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:inFundBtn];
    
    
//出金
    
    UIView *outputFund = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth/2 + 10, 95, ScreenWidth/2 - 20, 70)];
    outputFund.backgroundColor = [ColorUtil colorWithHexString:@"37a8b0"];
    outFundLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, ScreenWidth/2 - 40, 15)];
    outFundLable.text = @"0.00￥";
    outFundLable.textAlignment = NSTextAlignmentRight;
    outFundLable.font = [UIFont boldSystemFontOfSize:15];
    outFundLable.textColor = [UIColor whiteColor];
    [outputFund addSubview:outFundLable];
    
    UILabel *outFundTip = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, ScreenWidth/2 - 40, 10)];
    outFundTip.text = @"可用金额(元)";
    outFundTip.textAlignment = NSTextAlignmentRight;
    outFundTip.font = [UIFont boldSystemFontOfSize:10];
    outFundTip.textColor = [UIColor whiteColor];
    [outputFund addSubview:outFundTip];
    [self.view addSubview:outputFund];
    
    UIButton *outFundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //outFundBtn.backgroundColor = [UIColor grayColor];
    outFundBtn.frame = CGRectMake(ScreenWidth/2 + 10, 185, ScreenWidth/2 - 20, 60);
    UIImageView *outFundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    outFundView.image = [UIImage imageNamed:@"2"];
    [outFundBtn addSubview:outFundView];
    UILabel *outfundLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 0, 70, 60)];
    outfundLabel.text = @"出金";
    outfundLabel.font = [UIFont systemFontOfSize:14];
    [outFundBtn addSubview:outfundLabel];
    
    
    
    
    //[outFundBtn setTitle:@"出金" forState:UIControlStateNormal];
    
    outFundBtn.tag = 2;
    [outFundBtn addTarget:self action:@selector(pushButtonMethods:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:outFundBtn];
    
    
//查询资金变动
    
    UIView *changeFund = [[UIView alloc] initWithFrame:CGRectMake(10, 300, ScreenWidth/2 - 20, 70)];
    changeFund.backgroundColor = [ColorUtil colorWithHexString:@"357ca5"];
    changeFundLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, ScreenWidth/2 - 40, 15)];
    changeFundLable.text = @"0.00￥";
    changeFundLable.textAlignment = NSTextAlignmentRight;
    changeFundLable.font = [UIFont boldSystemFontOfSize:15];
    changeFundLable.textColor = [UIColor whiteColor];
    [changeFund addSubview:changeFundLable];
    
    UILabel *changeFundTip = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, ScreenWidth/2 - 40, 10)];
    changeFundTip.text = @"可取资金(元)";
    changeFundTip.textAlignment = NSTextAlignmentRight;
    changeFundTip.font = [UIFont boldSystemFontOfSize:10];
    changeFundTip.textColor = [UIColor whiteColor];
    [changeFund addSubview:changeFundTip];
    [self.view addSubview:changeFund];
    
    UIButton *changeFundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    changeFundBtn.frame = CGRectMake(10, 390, ScreenWidth/2 - 20, 60);
    //changeFundBtn.backgroundColor = [UIColor grayColor];
    
    UIImageView *changeFundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    changeFundView.image = [UIImage imageNamed:@"3"];
    [changeFundBtn addSubview:changeFundView];
    UILabel *changefundLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 0, 85, 60)];
    changefundLabel.text = @"查询资金变动";
    changefundLabel.font = [UIFont systemFontOfSize:14];
    [changeFundBtn addSubview:changefundLabel];
    
    //[changeFundBtn setTitle:@"查询资金变动" forState:UIControlStateNormal];
    changeFundBtn.tag = 3;
    [changeFundBtn addTarget:self action:@selector(pushButtonMethods:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:changeFundBtn];
    
    
    
    
    
//我的银行
    
    UIView *bankFund = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth/2 + 10, 300, ScreenWidth/2 - 20, 70)];
    bankFund.backgroundColor = [ColorUtil colorWithHexString:@"0090d9"];
    bankFundLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, ScreenWidth/2 - 40, 15)];
    bankFundLable.text = @"0.00￥";
    bankFundLable.textAlignment = NSTextAlignmentRight;
    bankFundLable.font = [UIFont boldSystemFontOfSize:15];
    bankFundLable.textColor = [UIColor whiteColor];
    [bankFund addSubview:bankFundLable];
    
    UILabel *bankFundTip = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, ScreenWidth/2 - 40, 10)];
    bankFundTip.text = @"冻结资金(元)";
    bankFundTip.textAlignment = NSTextAlignmentRight;
    bankFundTip.font = [UIFont boldSystemFontOfSize:10];
    bankFundTip.textColor = [UIColor whiteColor];
    [bankFund addSubview:bankFundTip];
    [self.view addSubview:bankFund];
    
    UIButton *bankFundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
   // bankFundBtn.backgroundColor = [UIColor grayColor];
    bankFundBtn.frame = CGRectMake(ScreenWidth/2 + 10, 390, ScreenWidth/2 - 20, 60);
    UIImageView *bankFundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    bankFundView.image = [UIImage imageNamed:@"4"];
    [bankFundBtn addSubview:bankFundView];
    UILabel *bankfundLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 0, 70, 60)];
    bankfundLabel.text = @"我的银行卡";
    bankfundLabel.font = [UIFont systemFontOfSize:14];
    [bankFundBtn addSubview:bankfundLabel];
    
    
   // [bankFundBtn setTitle:@"我的银行卡" forState:UIControlStateNormal];
    bankFundBtn.tag = 4;
    [bankFundBtn addTarget:self action:@selector(pushButtonMethods:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:bankFundBtn];
    
    //添加指示器及遮罩
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = YES; //加层阴影
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"加载中...";
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
       //获取类别信息
        [self requestCategoryList:kBusinessTagGetMyfunds];
    //获取银行卡信息
        [self requestQueryList:kBusinessTagGetBankInfo];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });
    
    
}

#pragma mark - Request Methods

- (void)requestQueryList:(kBusinessTag)_tag
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"请求品牌列表");
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
    [paraDic setObject:@"JSYH" forKey:@"yhdm"];
    
    [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:_tag owner:self];
    
}


//获取品牌列表
- (void)requestCategoryList:(kBusinessTag)_tag
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"请求品牌列表");
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
    [paraDic setObject:@"RMB" forKey:@"bz"];
    [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:_tag owner:self];
    
}

#pragma mark - Recived Methods
//处理品牌列表
- (void)recivedCategoryList:(NSMutableArray *)dataArray
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"处理品牌列表数据");
    
    
    //[bankFundLable setText:[dataArray objectForKey:@"FID_DJJE"]];
    changeFundLable.text = [NSString stringWithFormat:@"￥%.2f",[[[dataArray objectAtIndex:0] objectForKey:@"FID_KQZJ"]floatValue]];
    outFundLable.text = [NSString stringWithFormat:@"￥%.2f",[[[dataArray objectAtIndex:0] objectForKey:@"FID_KYZJ"]floatValue]];

    inFundLable.text = [NSString stringWithFormat:@"￥%.2f",[[[dataArray objectAtIndex:0] objectForKey:@"FID_ZHYE"]floatValue]];
    bankFundLable.text = [NSString stringWithFormat:@"￥%.2f",[[[dataArray objectAtIndex:0] objectForKey:@"FID_DJJE"]floatValue]];
    
    
    //[bankFundLable setText:@"111"];
    

}


#pragma mark - NetworkModuleDelegate Methods
-(void)beginPost:(kBusinessTag)tag{
    
}
-(void)endPost:(NSString *)result business:(kBusinessTag)tag{
    NSLog(@"%s %d 收到数据:%@", __FUNCTION__, __LINE__, result);
    NSMutableDictionary *jsonDic = [result JSONValue];
    NSMutableArray *dataArray = [jsonDic objectForKey:@"object"];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
	if (tag==kBusinessTagGetMyfunds ) {
       
        if ([[jsonDic objectForKey:@"success"] boolValue] == 0) {
            //数据异常处理
            if ([[jsonDic objectForKey:@"object"] isEqualToString:@"loginTimeout"] == YES) {
                
                    LoginViewController *vc = [[LoginViewController alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:NO];
                    
                } else {
            
            [self.view makeToast:@"获取资金失败"];
                }
        } else {
            
            [self recivedCategoryList:dataArray];
        }
    } else if (tag==kBusinessTagGetBankCJ ) {
        
        if ([[jsonDic objectForKey:@"success"] boolValue] == 0) {
            //数据异常处理
            NOGoldViewController *cv = [[NOGoldViewController alloc] init];
            cv.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:cv animated:NO];
        
            } else {
            
            GoldViewController *cv = [[GoldViewController alloc] init];
            cv.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:cv animated:NO];
        }
    }else if (tag==kBusinessTagGetBankIntoGoldCJ ) {
        
        if ([[jsonDic objectForKey:@"success"] boolValue] == 0) {
            //数据异常处理
            NoIntoGoldViewController *cv = [[NoIntoGoldViewController alloc] init];
            cv.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:cv animated:NO];
            
        } else {
            
            IntoGoldViewController *cv = [[IntoGoldViewController alloc] init];
            cv.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:cv animated:NO];
        }
    } else if (tag==kBusinessTagGetBankInfo ) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        str = [jsonDic objectForKey:@"msg"];
    }
    
    
    [[NetworkModule sharedNetworkModule] cancel:tag];
}
-(void)errorPost:(NSError *)err business:(kBusinessTag)tag{
    NSLog(@"%s Error:%@", __FUNCTION__, @"连接数据服务器超时");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法连接" message:@"您所在地的网络信号微弱，无法连接到服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [[NetworkModule sharedNetworkModule] cancel:tag];
}


-(void)pushButtonMethods:(UIButton *)btn {
    
    if (btn.tag == 3) {
        QueryViewController *cv = [[QueryViewController alloc] init];
        cv.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cv animated:NO];
        
    } else if (btn.tag == 4) {
        BankCardViewController *cv = [[BankCardViewController alloc] init];
        cv.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cv animated:NO];
    }else if ([str isEqualToString:@"无银证转账对应关系"]||[str isEqualToString:@""]) {
        NumBindViewController *vc = [[NumBindViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:NO];
       
    }  else {
    //} else
    if (btn.tag == 1) {
        NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
        [paraDic setObject:@"JSYH" forKey:@"yhdm"];
        [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:kBusinessTagGetBankIntoGoldCJ owner:self];
        

    }else if (btn.tag == 2) {
        NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
        [paraDic setObject:@"JSYH" forKey:@"yhdm"];
        [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:kBusinessTagGetBankCJ owner:self];
        
         
    }
 }
}


-(void)push:(UIButton *)btn {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

-(void)dealloc {
    [bankFundLable removeFromSuperview];
    bankFundLable = nil;
    [changeFundLable removeFromSuperview];
    changeFundLable = nil;
    [outFundLable removeFromSuperview];
    outFundLable = nil;
    [inFundLable removeFromSuperview];
    inFundLable = nil;
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}


@end
