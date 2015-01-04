//
//  LoginViewController.m
//  FinancialExpert
//
//  Created by mac on 14-9-22.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "Base64.h"
#import "OpenUDID.h"
#import "Customer.h"
#import "IndividualCenterViewController.h"
#import "MyInfoViewController.h"
#import "RegisterViewController.h"
#import "RegisterCreaterViewController.h"


@interface LoginViewController ()
{
    int count;
}
@end

@implementation LoginViewController
@synthesize customerName;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.customerName = @"欢迎来到投资管理系统!!!!";
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
    count = 0;
   
    
    //相对于上面的接口，这个接口可以动画的改变statusBar的前景色
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    
    statusBarView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"title_bg"]];
    
    [self.view addSubview:statusBarView];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
   
    
    
   
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
#endif
    
    UINavigationBar *navibar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 44)];
    navibar.userInteractionEnabled = YES;
    //navibar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navbar.png"]];
    [navibar setBackgroundImage:[UIImage imageNamed:@"title_bg"]  forBarMetrics:UIBarMetricsDefault];
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 12, 40, 20);
    //leftBtn.center = CGPointMake(with/2,hight/2);
    [leftBtn setImage:[UIImage imageNamed:@"return_ico"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    UINavigationItem *navibarItem = [[UINavigationItem alloc]init];
    navibarItem.title = @"登录";
    navibarItem.leftBarButtonItem= leftItem;
    // self.navigationItem.rightBarButtonItem = leftItem;
    [navibar pushNavigationItem:navibarItem animated:YES];
    [self.view addSubview:navibar];
    

    
    UIView *numLable = [[UIView alloc] initWithFrame:CGRectMake(0, 84 , ScreenWidth, 100)];
    numLable.userInteractionEnabled = YES;
    numLable.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"head_bg"]];
    UIImageView *fenxian = [[UIImageView alloc] initWithFrame:CGRectMake(20, 50, ScreenWidth, 1)];
    fenxian.image = [UIImage imageNamed:@"line_fenge"];
    [numLable addSubview:fenxian];
    numLable.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:numLable];
    
    phoneNum = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 20, 20)];
    phoneNum.image = [UIImage imageNamed:@"icon_zcdh_nor"];
    [numLable addSubview:phoneNum];
    
    phoneNumText = [[UITextField alloc] initWithFrame:CGRectMake(49, 0, ScreenWidth - 50, 50)];
    phoneNumText.clearButtonMode = UITextFieldViewModeAlways;
    phoneNumText.placeholder = @"手机号码";
    phoneNumText.font = [UIFont systemFontOfSize:14];
    phoneNumText.textColor = [ColorUtil colorWithHexString:@"5e5f63"];
    phoneNumText.keyboardType = UIKeyboardTypeNamePhonePad;
    phoneNumText.delegate = self;
    [numLable addSubview:phoneNumText];
    
    passWordText = [[UITextField alloc] initWithFrame:CGRectMake(49, 50, ScreenWidth - 50, 49)];
    passWordText.delegate = self;
    passWordText.clearButtonMode = UITextFieldViewModeAlways;
    passWordText.font = [UIFont systemFontOfSize:14];
    passWordText.textColor = [ColorUtil colorWithHexString:@"5e5f63"];
    passWordText.keyboardType = UIKeyboardTypeNamePhonePad;
    passWordText.secureTextEntry = YES;
    passWordText.placeholder = @"密码";
    [numLable addSubview:passWordText];
    
    _button1 =[UIButton buttonWithType:UIButtonTypeCustom];
    _button1.frame = CGRectMake(30, 195, 27, 27);
    [_button1 addTarget:self action:@selector(defaultCheck:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button1];
    
    UILabel *remenberPassWordLable = [[UILabel alloc] initWithFrame:CGRectMake(62, 195 + 7, 60, 13)];
    remenberPassWordLable.font = [UIFont systemFontOfSize:13];
    remenberPassWordLable.text = @"记住密码";
    [self.view addSubview:remenberPassWordLable];
    
    UIButton *registerBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    //registerBtn.frame = CGRectMake(140, 200, 75, 15);
    registerBtn.frame = CGRectMake(225, 200, 75, 15);
    [registerBtn setTitle:@"注册创建人" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(defaultCheck:)
          forControlEvents:UIControlEventTouchUpInside];
    registerBtn.tag = 11;
    [self.view addSubview:registerBtn];
    
    UIButton *registerCreaterBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    registerCreaterBtn.frame = CGRectMake(235, 200, 75, 15);
    registerCreaterBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [registerCreaterBtn setTitle:@"注册投资人" forState:UIControlStateNormal];
    [registerCreaterBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [registerCreaterBtn addTarget:self action:@selector(defaultCheck:)
          forControlEvents:UIControlEventTouchUpInside];
    registerCreaterBtn.tag = 12;
    //[self.view addSubview:registerCreaterBtn];
    
    
    passWord = [[UIImageView alloc] initWithFrame:CGRectMake(20, 65, 20, 20)];
    passWord.image = [UIImage imageNamed:@"icon_zcmm_nor"];
    [numLable addSubview:passWord];
    
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(92, 195 + 37 , ScreenWidth - 184, 47);
    //initWithFrame:CGRectMake(0, 0, 21, 21)];
    [loginBtn setImage:[UIImage imageNamed:@"btn_dl"] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    [self readUserInfo];
    
    
//    //添加指示器及遮罩
//    HUD = [[MBProgressHUD alloc] initWithView:self.view];
//    HUD.dimBackground = YES;
//    HUD.delegate = self;
//    HUD.labelText = @"登录中";
//    [HUD hide:YES];
//    [self.view addSubview:HUD];

//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.mode = MBProgressHUDModeAnnularDeterminate;
//    hud.labelText = @"Loading";
//    [self doSomethingInBackgroundWithProgressCallback:^(float progress) {
//        hud.progress = progress;
//    } completionCallback:^{
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//    }];
    
    
    
}


-(void)saveData {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:phoneNumText.text forKey:@"name"];
    [userDefault setObject:passWordText.text forKey:@"password"];
    [userDefault setBool:self.button1.selected forKey:@"isRemember"];
    [userDefault synchronize];
    
}

-(void)readUserInfo {
    //读取用户信息，是否保存信息状态和登陆状态
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    phoneNumText.text = [userDefault objectForKey:@"name"];
    passWordText.text = [userDefault objectForKey:@"password"];
    BOOL isOpen = [userDefault boolForKey:@"isRemember"];
    
    [self.button1 setSelected:isOpen];              //设置与退出时相同的状态
    [self.button1 setImage:[UIImage imageNamed:@"select_0.png"] forState:UIControlStateNormal];
    [self.button1 setImage:[UIImage imageNamed:@"select_1.png"] forState:UIControlStateSelected];
}

-(void)removeUserInfo {
    //当不保存用户信息时，清除记录
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:@"name"];
    [userDefault removeObjectForKey:@"password"];
    [userDefault removeObjectForKey:@"isRemember"];
}

-(void)defaultCheck:(UIButton *)button {
    if (button.tag == 11) {
        RegisterViewController *cv = [[RegisterViewController alloc] init];
        cv.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cv animated:NO];
    } else if (button.tag == 12) {
    
        RegisterCreaterViewController *cv = [[RegisterCreaterViewController alloc] init];
        cv.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cv animated:NO];
    
    } else {
    if (self.button1.selected == YES) {
        //设置按钮点击事件，是否保存用户信息，点击一次改变它的状态---selected,normal,同时在不同状态显示不同图片
        [self.button1 setSelected:NO];
        [self.button1 setImage:[UIImage imageNamed:@"select_0.png"] forState:UIControlStateNormal];
    }else {
        [self.button1 setSelected:YES];
        [self.button1 setImage:[UIImage imageNamed:@"select_1.png"] forState:UIControlStateSelected];
    }
    }
}



#pragma mark - UITextField Delegate Methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (phoneNumText == textField) {
        phoneNum.image = [UIImage imageNamed:@"icon_zcdh_pre"];
    } else if (passWordText == textField) {
        passWord.image = [UIImage imageNamed:@"icon_zcmm_pre"];
        //[passWordText becomeFirstResponder];
        //[passWordText becomeFirstResponder];
    }
}



- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (phoneNumText == textField) {
        phoneNum.image = [UIImage imageNamed:@"icon_zcdh_nor"];
    } else if(passWordText == textField){
        passWord.image = [UIImage imageNamed:@"icon_zcmm_nor"];
    }
}

#pragma mark - UITextField Delegate Methods
- (void)resignKeyboard:(id)sender
{
    [phoneNumText resignFirstResponder];
    [passWordText resignFirstResponder];
    
}


#pragma mark - Request Methods
//请求登陆
- (void)requestLogin:(NSString *)_userName withPass:(NSString *)_password tag:(kBusinessTag)_tag
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"请求登陆");
    NSString* openUDID = [OpenUDID value];
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
    [paraDic setObject:_userName forKey:@"username"];
    [paraDic setObject:_password forKey:@"password"];
    [paraDic setObject:openUDID forKey:@"mac"];
    
    [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:_tag owner:self];
    
    
    if (self.button1.selected == YES) {
        [self saveData];
        //[self.button2 setSelected:NO];
    }else {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [self removeUserInfo];
        [userDefault setBool:self.button1.selected forKey:@"isRemember"];
        [userDefault synchronize];
    }
    
}

#pragma mark - Recived Methods
//处理登陆信息
- (void)recivedLogin:(NSMutableDictionary *)data
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"处理登陆信息");
    
    
    
    //if ([[data objectForKey:@"khh"]  isEqualToString:@""] == 0) {
    //登陆失败处理
    //[HUD hide:YES];
    //[self.view makeToast:[data objectForKey:@"returnMsg"]];
    
    // } else {
    // NSLog(@"%@",data);
    //[HUD hide:YES];
    //InvestViewController *controller = [[InvestViewController alloc] init];
    //controller.leveyTabBarController.selectedIndex = 1;
    //AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    // ProductList *product = [ProductList productUserId:[data objectForKey:@"userId"]];
    //[delegate.arrayList addObject:product];
    //FirstViewController *controller = [[FirstViewController alloc] init];
    //[self.navigationController pushViewController:controller animated:YES];
    // }
    
}

#pragma mark - NetworkModuleDelegate Methods
-(void)beginPost:(kBusinessTag)tag{
    
}
-(void)endPost:(NSString *)result business:(kBusinessTag)tag{
    NSLog(@"%s %d 收到数据:%@", __FUNCTION__, __LINE__, result);
    NSMutableDictionary *jsonDic = [result JSONValue];
    //NSMutableArray *dataArray = [jsonDic objectForKey:@"objec"];
	if (tag==kBusinessTagUserLogin ) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
        if ([[jsonDic objectForKey:@"success"] boolValue] == 0) {
            //数据异常处理
            [self.view makeToast:[jsonDic objectForKey:@"msg"]];
            NSLog(@"%@",self.customerName);
            //[self.myViewController.loginLabel setText:@"欢迎来到投资管理系统!!!!"];

        } else {
            
            BOOL logRueslt = [[jsonDic objectForKey:@"success"] boolValue];
            NSString *khh = [[jsonDic objectForKey:@"object"] objectForKey:@"khh"];
             NSString *khid = [[[jsonDic objectForKey:@"object"] objectForKey:@"userInfo"] objectForKey:@"FID_JGBZ"];
             NSString *khxm = [[jsonDic objectForKey:@"object"] objectForKey:@"khxm"];
            BOOL isltr = [[[jsonDic objectForKey:@"object"] objectForKey:@"isLTR"] boolValue];
            BOOL isGJTZR = [[[jsonDic objectForKey:@"object"] objectForKey:@"isGJTZR"] boolValue];
            BOOL isHGTZR = [[[jsonDic objectForKey:@"object"] objectForKey:@"isHGTZR"] boolValue];
            NSString *fieldNum = [[[jsonDic objectForKey:@"object"] objectForKey:@"userInfo"] objectForKey:@"FID_ZJBH"];
             NSString *fid_zw = [[[jsonDic objectForKey:@"object"] objectForKey:@"userInfo"] objectForKey:@"FID_ZW"];
             NSString *phoneNu = [[[jsonDic objectForKey:@"object"] objectForKey:@"userInfo"] objectForKey:@"FID_MOBILE"];
             NSString *email = [[[jsonDic objectForKey:@"object"] objectForKey:@"userInfo"] objectForKey:@"FID_EMAIL"];
             NSString *name = [[[jsonDic objectForKey:@"object"] objectForKey:@"userInfo"] objectForKey:@"YHM"];
            NSString *_session_Id = [[jsonDic objectForKey:@"object"] objectForKey:@"sessionId"];
            NSString *_companyName = [[[jsonDic objectForKey:@"object"] objectForKey:@"userInfo"] objectForKey:@"FID_GSMC"];
            NSString *_yearGold = [[[jsonDic objectForKey:@"object"] objectForKey:@"userInfo"] objectForKey:@"NSR"];
            NSString *_fund = [[[jsonDic objectForKey:@"object"] objectForKey:@"userInfo"] objectForKey:@"FID_ZCED"];
            
            
              BOOL isTZRQX = [[[[jsonDic objectForKey:@"object"] objectForKey:@"userInfo"] objectForKey:@"TZRQX"] boolValue];
            
            
            if ([[[[jsonDic objectForKey:@"object"] objectForKey:@"userInfo"] objectForKey:@"TX"] isEqualToString:@""]) {
                UIImage *image1 = [UIImage imageWithData:[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/res/images/photo.jpg",SERVERURL]]]];
                
                 
                Customer *customer = [Customer CustomerInformation:khxm withsessionId:khid withId:khh withSueccss:logRueslt withGJTZR:isGJTZR withTZRQX:isTZRQX withLTR:isltr withHGTZR:isHGTZR withfieldNum:fieldNum withfid_zw:fid_zw withphoneNum:phoneNu withemail:email withname:name withicon:image1 withyearGold:(NSString *)_yearGold withsession_Id:(NSString *)_session_Id withcompanyName:(NSString *)_companyName withfund:(NSString *)_fund];
                AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                if (delegate.array.count > 0) {
                    [delegate.array removeLastObject];
                }
                [delegate.array addObject:customer];
                
            } else {
                UIImage *image1 = [UIImage imageWithData:[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/lbdocument/showImg?type=cxzctzqx&catch=false&id=%@",SERVERURL,khh]]]];
                
                Customer *customer = [Customer CustomerInformation:khxm withsessionId:khid withId:khh withSueccss:logRueslt withGJTZR:isGJTZR withTZRQX:isTZRQX withLTR:isltr withHGTZR:isHGTZR withfieldNum:fieldNum withfid_zw:fid_zw withphoneNum:phoneNu withemail:email withname:name withicon:image1 withyearGold:(NSString *)_yearGold withsession_Id:(NSString *)_session_Id withcompanyName:(NSString *)_companyName withfund:(NSString *)_fund];
                AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                if (delegate.array.count > 0) {
                    [delegate.array removeAllObjects];
                }
                [delegate.array addObject:customer];
            
            
            }
            
            [self.view makeToast:[jsonDic objectForKey:@"msg"]];
            
            [self.myViewController.loginLabel setText:[NSString stringWithFormat:@"欢迎您，%@，登录成功！",[[jsonDic objectForKey:@"object"] objectForKey:@"khxm"]]];
                      
            [self.navigationController popViewControllerAnimated:YES];
            
            
            
            
        }
    }
   [[NetworkModule sharedNetworkModule] cancel:tag];
}

-(void)requestDataImage {
    NSString * url = @"http://192.168.1.57:8021/res/images/photo.jpg?";
    NSDictionary * dic = @{@"id":@"000800000019"};
    for (NSString * key in dic.allKeys) {
        url = [url stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[dic objectForKey:key]]];
    }
    NSRange range = [url rangeOfString:@"&" options:NSBackwardsSearch];
    url = [url stringByReplacingCharactersInRange:range withString:@""];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
        self.myViewController.headImage.image = [UIImage imageWithData:data];
         NSLog(@"image  == %@,%@",connectionError,response);
        
     }];
    
    
}




-(void)errorPost:(NSError *)err business:(kBusinessTag)tag{
    NSLog(@"%s Error:%@", __FUNCTION__, @"连接数据服务器超时");
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法连接" message:@"您所在地的网络信号微弱，无法连接到服务器" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [[NetworkModule sharedNetworkModule] cancel:tag];
}

-(void) loginButton{
    
    [phoneNumText resignFirstResponder];
    [passWordText resignFirstResponder];
    NSLog(@"%@",phoneNumText.text);
    NSLog(@"%@",passWordText.text);
    
    if ([phoneNumText.text isEqualToString:@""] || phoneNumText.text == nil) {
        [self.view makeToast:@"请输入帐号"];
        //[phoneNumText becomeFirstResponder];
        
    } else if ([passWordText.text isEqualToString:@""] || passWordText.text == nil) {
        [self.view makeToast:@"请输入密码"];
        //[passWordText becomeFirstResponder];
    } else {
        [self resignKeyboard:nil];
        //调用单例的网络模块执行登陆
        Base64 * passwordBase64 = [Base64 encodeBase64String:passWordText.text];
        NSLog(@"%@",passwordBase64.strBase64);
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.dimBackground = YES; //加层阴影
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"加载中...";
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
             [self requestLogin:phoneNumText.text withPass:passwordBase64.strBase64 tag:kBusinessTagUserLogin];
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
        });
        
        
    }
    
}

#pragma mark - 消除键盘

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [phoneNumText resignFirstResponder];
    [passWordText resignFirstResponder];
}

-(void)push:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];

}



/*
-(void) push:(UIButton *)btn{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    if (delegate.loginArray.count > 0) {
        Customer *cumer = [delegate.loginArray objectAtIndex:0];
        if (cumer.loginSueccss == 1) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        } else {
        MyMineViewController *controller = [[MyMineViewController alloc] init];
        controller.leveyTabBarController.selectedIndex = 3;
    }
    } else {
        if (self.myViewController.leveyTabBarController.selectedIndex == 3) {
             [self.navigationController popToRootViewControllerAnimated:YES];
            
        } else if(self.investViewController.leveyTabBarController.selectedIndex == 1) {
            MyMineViewController *controller = [[MyMineViewController alloc] init];
            //controller.leveyTabBarController.tabBarHidden = NO;
            controller.leveyTabBarController.selectedIndex = 3;
       
        } 
    }
    
}

*/

#pragma Memory Mothehs

-(void)dealloc {
    [phoneNumText removeFromSuperview];
    [passWordText removeFromSuperview];
    [passWord removeFromSuperview];
    [phoneNum removeFromSuperview];
    [self.button1 removeFromSuperview];
    passWordText = nil;
    [_button1 removeFromSuperview];
    _button1 = nil;
    passWord = nil;
    phoneNum = nil;
    self.myViewController = nil;
    self.customerName = nil;
    self.receiveData = nil;
   [[NSURLCache sharedURLCache] removeAllCachedResponses]; 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   [[NSURLCache sharedURLCache] removeAllCachedResponses];
}


@end
