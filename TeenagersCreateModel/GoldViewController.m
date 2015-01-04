//
//  GoldViewController.m
//  TeenagersCreateModel
//
//  Created by Yonghui Xiong on 14-11-10.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "GoldViewController.h"
#import "AppDelegate.h"
#import "KxMenu.h"

@interface GoldViewController (){
    UIButton *bankNumTF;
    UITextField *SelectLable;
    NSArray *array3;
    NSString *bankName;
    UITextField *accountNum;
    UITextField *password;
    UITextField *moneyPassword;
    int count;
    UIImageView *isOpenView;
    
}
@end

@implementation GoldViewController

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
    
    bankName = @"";
    UINavigationBar *navibar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 44)];
    navibar.userInteractionEnabled = YES;
    //navibar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navbar.png"]];
    [navibar setBackgroundImage:[UIImage imageNamed:@"title_bg"]  forBarMetrics:UIBarMetricsDefault];
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 12, 40, 20);
    [leftBtn setImage:[UIImage imageNamed:@"return_ico"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    UINavigationItem *navibarItem = [[UINavigationItem alloc]init];
    navibarItem.title = @"出金";
    navibarItem.leftBarButtonItem= leftItem;
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
    //银行卡号
    UILabel *accountLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 101, 75, 14)];
    accountLab.text = @"绑定银行:";
    accountLab.font = [UIFont boldSystemFontOfSize:14];
    [self.view addSubview:accountLab];
    
    bankNumTF = [[UIButton alloc] initWithFrame:CGRectMake(95, 90, ScreenWidth - 115, 35)];
   bankNumTF.layer.borderWidth = 1;
    bankNumTF.layer.borderColor = [[UIColor blackColor] CGColor];
    //bankNumTF.layer.cornerRadius = 5;
    bankNumTF.backgroundColor = [UIColor whiteColor];
    //[bankNumTF setTitle:@"请输入银行" forState:UIControlStateNormal];
    [bankNumTF addTarget:self action:@selector(showDDList:) forControlEvents:UIControlEventTouchUpInside];
    SelectLable = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 95 - 50, 30)];
    SelectLable.font = [UIFont systemFontOfSize:12];
    SelectLable.textAlignment = NSTextAlignmentLeft;
    //SelectLable.textColor = [ColorUtil colorWithHexString:@"7f7f7f"];
    //SelectLable.backgroundColor = [UIColor grayColor];
    SelectLable.placeholder = @"请选择银行";
    SelectLable.enabled = NO;
   // SelectLable.text = @"请选择银行";
    [bankNumTF addSubview:SelectLable];
    isOpenView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - 95 - 20 - 30 + 5, 5/2 + 5, 15, 15)];
    isOpenView.image = [UIImage imageNamed:@"dropdown.png"];
    [bankNumTF addSubview:isOpenView];
    
    
    [self.view addSubview:bankNumTF];

    
    
    
//银行卡号
    UILabel *zcjeLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 146, 75, 14)];
    zcjeLab.text = @"转出金额:";
    zcjeLab.font = [UIFont boldSystemFontOfSize:14];
    [self.view addSubview:zcjeLab];
    accountNum = [[UITextField alloc] initWithFrame:CGRectMake(95, 136, ScreenWidth - 115, 35)];
    [accountNum setBackgroundColor:[UIColor whiteColor]];
    accountNum.borderStyle = UITextBorderStyleLine;
    //[accountNum setBackground:[[UIImage imageNamed:@"head_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch]];
    accountNum.returnKeyType = UIReturnKeyDone;
    accountNum.delegate = self;
    accountNum.placeholder = @"请填写金额";
    //[accountNum setText:self.dataString];
    accountNum.clearButtonMode = UITextFieldViewModeAlways;
    [accountNum setFont:[UIFont systemFontOfSize:13]];
    [accountNum setTextColor:[ColorUtil colorWithHexString:@"383838"]];
    [self.view addSubview:accountNum];
    
    UILabel *tipBankLabel = [[UILabel alloc] initWithFrame:CGRectMake(195, 176 , ScreenWidth - 195 - 20, 10)];
    tipBankLabel.font = [UIFont systemFontOfSize:10];
    tipBankLabel.textColor = [ColorUtil colorWithHexString:@"7f7f7f"];
    tipBankLabel.text = @"单位:(元)";
    tipBankLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:tipBankLabel];
    
    
//密码
    UILabel *passwordLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 151 + 55, 75, 14)];
    passwordLab.text = @"资金密码:";
    passwordLab.font = [UIFont boldSystemFontOfSize:14];
    [self.view addSubview:passwordLab];
    password = [[UITextField alloc] initWithFrame:CGRectMake(95, 151 + 45, ScreenWidth - 115, 35)];
    [password setBackgroundColor:[UIColor whiteColor]];
    password.borderStyle = UITextBorderStyleLine;
    //[password setBackground:[[UIImage imageNamed:@"head_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch]];
    password.returnKeyType = UIReturnKeyDone;
    password.delegate = self;
    password.placeholder = @"请填写资金密码";
    //[password setText:self.dataString];
    password.clearButtonMode = UITextFieldViewModeAlways;
    [password setFont:[UIFont systemFontOfSize:13]];
    [password setTextColor:[ColorUtil colorWithHexString:@"383838"]];
    [self.view addSubview:password];
    
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.frame = CGRectMake(50, 234 + 40, ScreenWidth - 100, 50);
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitBtn.backgroundColor = [UIColor blueColor];
    [commitBtn addTarget:self action:@selector(commitBtnMethods:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitBtn];
    
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs;
    if(textField == accountNum)
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



-(void)reloadDDList {
    _ddList = [[DDList alloc] initWithStyle:UITableViewStylePlain];
	_ddList._delegate = self;
    
	[self.view addSubview:_ddList.view];
	[_ddList.view setFrame:CGRectMake(95, 90 + 35, ScreenWidth - 115, 0)];
    //[self setDDListHidden:YES];
    count = 0;
    
}


- (void)setDDListHidden:(BOOL)hidden {
	NSInteger height = hidden ? 0 : 100;
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:.2];
	[_ddList.view setFrame:CGRectMake(95, 90 + 35, ScreenWidth - 115, height)];
	[UIView commitAnimations];
}

#pragma mark PassValue protocol
- (void)passValue:(NSString *)value{
	if (value) {
		SelectLable.text = value;
		[self setDDListHidden:YES];
        isOpenView.image = [UIImage imageNamed:@"dropdown.png"];
        count = 0;
	}
	else {
		
	}
}

- (void)passBankCode:(NSString *)value{
    bankName = value;
}



-(void)showDDList:(UIButton *)btn {
    if (count%2 == 0) {
        if (_ddList) {
            [_ddList removeFromParentViewController];
            
        }
        [self reloadDDList];
        isOpenView.image = [UIImage imageNamed:@"dropup.png"];
        [self setDDListHidden:NO];
        
    } else {
        isOpenView.image = [UIImage imageNamed:@"dropdown.png"];
        [self setDDListHidden:YES];
    }
    count++;
    
    
}


- (void)showMenu:(UIButton *)sender
{
    NSMutableArray *array2 = [[NSMutableArray alloc] init];
    array3 = @[@{@"identfy":@"JSYH",@"name":@"建设银行"}];
    for (int i = 0; i < array3.count; i++) {
        KxMenuItem *kx =
        [KxMenuItem menuItem:[[array3 objectAtIndex:i] objectForKey:@"name"]
                       image:[UIImage imageNamed:@"action_icon"]
                      target:self
                      action:@selector(pushMenuItem:)];
        // kx.target = [NSString stringWithFormat:@"%i",i];
        
        [array2 addObject:kx];
    }
    
    
    [KxMenu showMenuInView:self.view
                  fromRect:CGRectMake(95, 35, 200, 80)
                 menuItems:array2];
    [KxMenu setTintColor:[UIColor whiteColor]];
}

- (void) pushMenuItem:(KxMenuItem *)sender
{
    for (int i = 0;i< array3.count;i++) {
        for (NSString *str in [[array3 objectAtIndex:i] allObjects]) {
            if ([str isEqualToString:sender.title]) {
                bankName = [[array3 objectAtIndex:i] objectForKey:@"identfy"];
            }
        }
    }
    
    
    [SelectLable setText:sender.title];
    
    
    NSLog(@"999999%@", bankName);
}





-(void)commitBtnMethods:(id)sender {
    if ([bankName isEqualToString:@""]) {
        [self.view makeToast:@"请选择银行"];
        
    } else if ([accountNum.text isEqualToString:@""]) {
        [self.view makeToast:@"请输入银行密码"];
        
    }else if ([password.text isEqualToString:@""]) {
        [self.view makeToast:@"请输入银行密码"];
        
    } else {
        
        //添加指示器及遮罩
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.dimBackground = YES; //加层阴影
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"加载中...";
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
           [self requestCategoryList:bankName zcje:accountNum.text zjmm:password.text tag:kBusinessTagGetBankCJAgain];
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
        });
    }
    
    
}

#pragma mark - Request Methods
//获取品牌列表
- (void)requestCategoryList:(NSString *)yhdm  zcje:(NSString *)zcje   zjmm:(NSString *)zjmm tag:(kBusinessTag)_tag
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"请求品牌列表");
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
    [paraDic setObject:yhdm forKey:@"yhdm"];
    [paraDic setObject:zcje forKey:@"zzje"];
    [paraDic setObject:zjmm forKey:@"zjmm"];
    [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:_tag owner:self];
    
}

#pragma mark - Recived Methods
//处理品牌列表
- (void)recivedCategoryList:(NSMutableArray *)dataArray
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"处理品牌列表数据");
    
}
#pragma mark - NetworkModuleDelegate Methods
-(void)beginPost:(kBusinessTag)tag{
    
}
-(void)endPost:(NSString *)result business:(kBusinessTag)tag{
    NSLog(@"%s %d 收到数据:%@", __FUNCTION__, __LINE__, result);
    NSMutableDictionary *jsonDic = [result JSONValue];
    
	if (tag==kBusinessTagGetBankCJAgain ) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([[jsonDic objectForKey:@"success"] boolValue] == 0) {
            //数据异常处理
            [self.view makeToast:[jsonDic objectForKey:@"msg"]];
        } else {
            [self.view makeToast:[jsonDic objectForKey:@"msg"]];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    [[NetworkModule sharedNetworkModule] cancel:tag];
}
-(void)errorPost:(NSError *)err business:(kBusinessTag)tag{
    NSLog(@"%s Error:%@", __FUNCTION__, @"连接数据服务器超时");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法连接" message:@"您所在地的网络信号微弱，无法连接到服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    if (tag == kBusinessTagGetBankCJAgain) {
       [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    [[NetworkModule sharedNetworkModule] cancel:tag];
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
     [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

-(void)dealloc {
   [accountNum removeFromSuperview];
    accountNum = nil;
    [password removeFromSuperview];
    password = nil;
    [bankNumTF removeFromSuperview];
    bankNumTF = nil;
    [SelectLable removeFromSuperview];
    SelectLable = nil;
 
    array3 = nil;
    bankName = nil;
       
    
}

@end
