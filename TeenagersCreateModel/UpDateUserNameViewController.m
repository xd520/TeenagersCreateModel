//
//  UpDateUserNameViewController.m
//  TeenagersCreateModel
//
//  Created by Yonghui Xiong on 14-11-6.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "UpDateUserNameViewController.h"
#import "MyInfoViewController.h"
#import "AppDelegate.h"
#import "Customer.h"

@interface UpDateUserNameViewController ()
{
    UITextField *dataTextField;
    MBProgressHUD *HUD;
}

@end

@implementation UpDateUserNameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

-(void)loadView {
    [super loadView];
     self.navigationController.navigationBarHidden = YES;
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
    
    UINavigationBar *navibar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 44)];
    navibar.userInteractionEnabled = YES;
    //navibar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navbar.png"]];
    [navibar setBackgroundImage:[UIImage imageNamed:@"title_bg"]  forBarMetrics:UIBarMetricsDefault];
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 12, 40, 20);
    [leftBtn setImage:[UIImage imageNamed:@"return_ico"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    rightBtn.frame = CGRectMake(0, 0, 40, 30);
    [rightBtn setTitle:@"修改" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    
    
    UINavigationItem *navibarItem = [[UINavigationItem alloc]init];
    navibarItem.title = @"修改用户名";
    navibarItem.leftBarButtonItem= leftItem;
    navibarItem.rightBarButtonItem = right;
    // self.navigationItem.rightBarButtonItem = leftItem;
    [navibar pushNavigationItem:navibarItem animated:YES];
    [self.view addSubview:navibar];
    
    
    //背景色
    [self.view setBackgroundColor:[ColorUtil colorWithHexString:@"ececec"]];
    
    dataTextField = [[UITextField alloc] initWithFrame:CGRectMake(23, 84, 274, 39)];
    [dataTextField setBackgroundColor:[UIColor clearColor]];
    [dataTextField setBackground:[[UIImage imageNamed:@"head_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch]];
    dataTextField.returnKeyType = UIReturnKeyDone;
    dataTextField.delegate = self;
    dataTextField.placeholder = @"请填写联系人姓名";
    [dataTextField setText:self.dataString];
    dataTextField.clearButtonMode = UITextFieldViewModeAlways;
    [dataTextField setFont:[UIFont systemFontOfSize:15]];
    [dataTextField setTextColor:[ColorUtil colorWithHexString:@"383838"]];
    [self.view addSubview:dataTextField];
    
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
#endif

    
}

#pragma mark - NavigationItem Methods
- (IBAction)action:(id)sender {
    [dataTextField resignFirstResponder];
    if ([dataTextField.text isEqualToString:@""]) {
        [self.view makeToast:@"请填写联系人姓名"];
    } else {
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        HUD.dimBackground = YES;
        HUD.delegate = self;
        HUD.labelText = @"提交中";
        [HUD show:YES];
        [self.view addSubview:HUD];
        [self requestUpdateLinkMan];
    }
}
#pragma mark - UITextField Delegate Methods
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}
#pragma mark - Request Methods
//请求修改联系人
- (void)requestUpdateLinkMan
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"请求修改联系人");
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];

    [paraDic setObject:dataTextField.text forKey:@"username"];
    [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:kBusinessTagGetUpdateUserName owner:self];
    
}
#pragma mark - Recived Methods
//处理修改联系人
- (void)recivedUpdateLinkMan
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"修改联系人");
    [HUD hide:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
    self.myinfoVC.userName.text = dataTextField.text;
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    Customer *custer = [delegate.array objectAtIndex:0];
    custer.name = nil;
    custer.name = dataTextField.text;

    [self.myinfoVC.view makeToast:@"修改成功"];
}
#pragma mark - NetworkModuleDelegate Methods
-(void)beginPost:(kBusinessTag)tag{
    
}
-(void)endPost:(NSString *)result business:(kBusinessTag)tag{
    NSLog(@"%s %d 收到数据:%@", __FUNCTION__, __LINE__, result);
    NSMutableDictionary *jsonDic = [result JSONValue];
    //NSMutableArray *dataArray = [jsonDic objectForKey:@"data"];
	if (tag==kBusinessTagGetUpdateUserName ) {
        [HUD hide:YES];
        if ([[jsonDic objectForKey:@"success"] boolValue] == NO) {
            //数据异常处理
            [self.view makeToast:@"提交失败"];
            //            subing = NO;
        } else {
            [self recivedUpdateLinkMan];
        }
    }
    [[NetworkModule sharedNetworkModule] cancel:tag];
}
-(void)errorPost:(NSError *)err business:(kBusinessTag)tag{
    NSLog(@"%s Error:%@", __FUNCTION__, @"连接数据服务器超时");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法连接" message:@"您所在地的网络信号微弱，无法连接到服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    if (tag==kBusinessTagGetUpdateUserName) {
        [HUD hide:YES];
    }
    [[NetworkModule sharedNetworkModule] cancel:tag];
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
    //[self.myinfoVC removeFromParentViewController];
    self.myinfoVC = nil;
    self.dataString = nil;
    [dataTextField removeFromSuperview];
    dataTextField = nil;
    [HUD removeFromSuperview];
    HUD = nil;
}


@end
