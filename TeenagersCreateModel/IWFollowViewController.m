//
//  IWFollowViewController.m
//  TeenagersCreateModel
//
//  Created by Yonghui Xiong on 14-12-11.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "IWFollowViewController.h"
#import "AppDelegate.h"

@interface IWFollowViewController ()
{
    UILabel *productCodeLabel;
    UITextField *followText;
}
@end

@implementation IWFollowViewController

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
    titleLabel.text = @"我要跟投";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    [navImageView addSubview:titleLabel];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 12, 40, 20);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"return_ico"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [navImageView addSubview:backBtn];
    [self.view addSubview:navImageView];
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    
  //产品代码:
    UILabel *labCode = [[UILabel alloc] initWithFrame:CGRectMake(10, 84, 85, 15)];
    labCode.text = @"产品代码:";
    labCode.textColor = [ColorUtil colorWithHexString:@"000000"];
    labCode.textAlignment = NSTextAlignmentRight;
    labCode.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:labCode];
    
    productCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 85, ScreenWidth - 120, 13)];
    productCodeLabel.text = delegate.numStr;
    productCodeLabel.textColor = [ColorUtil colorWithHexString:@"B3B3B3"];
    productCodeLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:productCodeLabel];
    
    
//跟投金额(元):
   
    UILabel *labfollow = [[UILabel alloc] initWithFrame:CGRectMake(10, 124 + 17/2, 85, 13)];
    labfollow.text = @"跟投金额(元):";
    labfollow.numberOfLines = 0;
    labfollow.textColor = [ColorUtil colorWithHexString:@"000000"];
    labfollow.textAlignment = NSTextAlignmentRight;
    labfollow.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:labfollow];
    
    followText = [[UITextField alloc] initWithFrame:CGRectMake(100, 124, ScreenWidth - 120, 30)];
    followText.delegate = self;
    followText.borderStyle = UITextBorderStyleLine;
    followText.clearButtonMode = UITextFieldViewModeWhileEditing;
    followText.font = [UIFont systemFontOfSize:13];
    followText.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:followText];
    
    
    UIButton *followBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    followBtn.frame = CGRectMake(20.f,250,280, 50);
    followBtn.backgroundColor = [ColorUtil colorWithHexString:@"37B3D9"];
    [followBtn setTitle:@"提交申请" forState:UIControlStateNormal];
    [followBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [followBtn addTarget:self action:@selector(commitMethods) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:followBtn];
    
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs;
    if(textField == followText)
    {
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest)
        {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"请输入数字"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            
            [alert show];
            return NO;
        }
    }
    
    //其他的类型不需要检测，直接写入
    return YES;
}




- (void)requestCategoryList:(kBusinessTag)_tag
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"请求品牌列表");
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
    [paraDic setObject:productCodeLabel.text forKey:@"CPDM"];
    [paraDic setObject:followText.text forKey:@"SQJE"];
    
    
    [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:_tag owner:self];
    
}


#pragma mark - NetworkModuleDelegate Methods
-(void)beginPost:(kBusinessTag)tag{
    
}
-(void)endPost:(NSString *)result business:(kBusinessTag)tag{
    NSLog(@"%s %d 收到数据:%@", __FUNCTION__, __LINE__, result);
    NSMutableDictionary *jsonDic = [result JSONValue];
    //NSMutableDictionary *dataArray = [jsonDic objectForKey:@"object"];
	if (tag==kBusinessTagGetIwFlollow ) {
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
             [self.view makeToast:@"跟投成功！"];
           // [self recivedUpdateLinkMan:dataArray];
        }
    }
    [[NetworkModule sharedNetworkModule] cancel:tag];
}
-(void)errorPost:(NSError *)err business:(kBusinessTag)tag{
    NSLog(@"%s Error:%@", __FUNCTION__, @"连接数据服务器超时");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法连接" message:@"您所在地的网络信号微弱，无法连接到服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    if (tag==kBusinessTagGetIwFlollow) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    [[NetworkModule sharedNetworkModule] cancel:tag];
}




-(void) commitMethods{

    if ([followText.text isEqualToString:@""]) {
        [self.view makeToast:@"请输入金额"];
    } else {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.dimBackground = YES; //加层阴影
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"加载中...";
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            [self requestCategoryList:kBusinessTagGetIwFlollow];
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
        });
       
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)push {
    
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    
    [productCodeLabel removeFromSuperview];
    productCodeLabel = nil;
    [followText removeFromSuperview];
    followText = nil;
    
}

@end
