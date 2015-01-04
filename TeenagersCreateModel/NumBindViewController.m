//
//  NumBindViewController.m
//  TeenagersCreateModel
//
//  Created by Yonghui Xiong on 14-11-24.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "NumBindViewController.h"
#import "AppDelegate.h"
#import "Customer.h"
#import "KxMenu.h"


@interface NumBindViewController ()
{
    UIButton *bankNumTF;
    UITextField *intoBankTF;
    UITextField *bankpassWordTF;
    UITextField *setMoneyPassWord;
    UITextField *SelectLable;
    NSArray *array3;
    NSString *bankName;
    int count;
    UIImageView *isOpenView;
}
@end

@implementation NumBindViewController

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
    leftBtn.frame = CGRectMake(10, 12, 40, 20);
    [leftBtn setImage:[UIImage imageNamed:@"return_ico"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    UINavigationItem *navibarItem = [[UINavigationItem alloc]init];
    navibarItem.title = @"银行卡绑定";
    navibarItem.leftBarButtonItem= leftItem;
    // self.navigationItem.rightBarButtonItem = leftItem;
    [navibar pushNavigationItem:navibarItem animated:YES];
    [self.view addSubview:navibar];
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    Customer *customer = [delegate.array objectAtIndex:0];
    
 // 持卡人
    UILabel *haveCardLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 87, 80, 29)];
    haveCardLable.font = [UIFont systemFontOfSize:15];
    haveCardLable.textAlignment = NSTextAlignmentRight;
    haveCardLable.text = @"持卡人:";
    [self.view addSubview:haveCardLable];
    
    UILabel *haveCardNameLable = [[UILabel alloc] initWithFrame:CGRectMake(95, 87, 180, 29)];
    haveCardNameLable.font = [UIFont systemFontOfSize:14];
    haveCardNameLable.textAlignment = NSTextAlignmentLeft;
    haveCardNameLable.text = customer.name;
    [self.view addSubview:haveCardNameLable];
    
    
    //绑定银行卡
    UILabel *bdBankNumLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 94 + 40, 80, 15)];
    bdBankNumLable.font = [UIFont systemFontOfSize:15];
    bdBankNumLable.textAlignment = NSTextAlignmentRight;
    bdBankNumLable.text = @"银行:";
    [self.view addSubview:bdBankNumLable];
    
    bankNumTF = [[UIButton alloc] initWithFrame:CGRectMake(95, 94 - 7.5 + 40, ScreenWidth - 95 - 20, 30)];
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
    //SelectLable.backgroundColor = [UIColor redColor];
    SelectLable.enabled = NO;
    SelectLable.placeholder = @"请选择银行";
   // SelectLable.text = @"请选择银行";
    [bankNumTF addSubview:SelectLable];
    
    isOpenView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - 95 - 20 - 30 + 5, 5/2 + 5, 15, 15)];
    isOpenView.image = [UIImage imageNamed:@"dropdown.png"];
    [bankNumTF addSubview:isOpenView];
    
    [self.view addSubview:bankNumTF];
    
    
    //转入金额
    UILabel *intoBankLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 94 - 7.5 + 30 +17.5 + 40, 80, 15)];
    intoBankLable.font = [UIFont systemFontOfSize:15];
    intoBankLable.textAlignment = NSTextAlignmentRight;
    intoBankLable.text = @"银行卡号:";
    [self.view addSubview:intoBankLable];
    
    intoBankTF = [[UITextField alloc] initWithFrame:CGRectMake(95, 134 - 7.5 + 40, ScreenWidth - 95 - 20, 30)];
    intoBankTF.font = [UIFont systemFontOfSize:11];
    intoBankTF.backgroundColor = [UIColor whiteColor];
    intoBankTF.borderStyle = UITextBorderStyleLine;
    intoBankTF.clearButtonMode = UITextFieldViewModeAlways;
    intoBankTF.placeholder = @"请输入要转入的金额";
    intoBankTF.delegate = self;
    [self.view addSubview:intoBankTF];
    
    
    
    //银行密码
    
    UILabel *passWordBankLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 174 + 40, 80, 15)];
    passWordBankLable.font = [UIFont systemFontOfSize:15];
    passWordBankLable.textAlignment = NSTextAlignmentRight;
    passWordBankLable.text = @"银行密码:";
    [self.view addSubview:passWordBankLable];
    
    bankpassWordTF = [[UITextField alloc] initWithFrame:CGRectMake(95, 174 - 7.5 + 40, ScreenWidth - 95 - 20, 30)];
    bankpassWordTF.font = [UIFont systemFontOfSize:11];
    bankpassWordTF.backgroundColor = [UIColor whiteColor];
    bankpassWordTF.borderStyle = UITextBorderStyleLine;
    bankpassWordTF.placeholder = @"请输入银行卡密码";
    bankpassWordTF.clearButtonMode = UITextFieldViewModeAlways;
    bankpassWordTF.secureTextEntry = YES;
    bankpassWordTF.delegate = self;
    [self.view addSubview:bankpassWordTF];
    
  
   
    //重置资金密码
    
    UILabel *setpassWordBankLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 174 + 80 - 12.5, 80, 40)];
    setpassWordBankLable.font = [UIFont systemFontOfSize:15];
    setpassWordBankLable.numberOfLines = 0;
    setpassWordBankLable.textAlignment = NSTextAlignmentRight;
    setpassWordBankLable.text = @"重置资金密码:";
    [self.view addSubview:setpassWordBankLable];
    
    setMoneyPassWord = [[UITextField alloc] initWithFrame:CGRectMake(95, 174 - 7.5 + 80, ScreenWidth - 95 - 20, 30)];
    setMoneyPassWord.font = [UIFont systemFontOfSize:11];
    setMoneyPassWord.backgroundColor = [UIColor whiteColor];
    setMoneyPassWord.borderStyle = UITextBorderStyleLine;
    setMoneyPassWord.placeholder = @"请输入重置资金密码";
    setMoneyPassWord.clearButtonMode = UITextFieldViewModeAlways;
    setMoneyPassWord.secureTextEntry = YES;
    setMoneyPassWord.delegate = self;
    [self.view addSubview:setMoneyPassWord];
    
    
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.frame = CGRectMake(50, 234 + 80, ScreenWidth - 100, 50);
    [commitBtn setTitle:@"绑定" forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitBtn.backgroundColor = [UIColor blueColor];
    [commitBtn addTarget:self action:@selector(commitBtnMethods:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitBtn];
    
    
    
}

-(void)reloadDDList {
    if (_ddList) {
        [_ddList removeFromParentViewController];
    }
    _ddList = [[DDList alloc] initWithStyle:UITableViewStylePlain];
	_ddList._delegate = self;
    
	[self.view addSubview:_ddList.view];
	[_ddList.view setFrame:CGRectMake(95, 94 - 7.5 + 70, ScreenWidth - 115, 0)];
    //[self setDDListHidden:NO];
    count = 0;
    
}


- (void)setDDListHidden:(BOOL)hidden {
	NSInteger height = hidden ? 0 : 100;
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:.2];
	[_ddList.view setFrame:CGRectMake(95, 94 - 7.5 + 70, ScreenWidth - 115, height)];
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
                  fromRect:CGRectMake(95, 72, 200, 80)
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
        
    } else if ([intoBankTF.text isEqualToString:@""]) {
    [self.view makeToast:@"请输入卡号"];
    
    } else if ([bankpassWordTF.text isEqualToString:@""]) {
        [self.view makeToast:@"请输入银行密码"];
        
    } else if (setMoneyPassWord.text.length < 6) {
        [self.view makeToast:@"请输入资金密码6~8位"];
        
    }else if ([setMoneyPassWord.text isEqualToString:@""]) {
        [self.view makeToast:@"请输入资金密码"];
        
    }else if (setMoneyPassWord.text.length > 8) {
        [self.view makeToast:@"请输入资金密码6~8位"];
        
    }else {
        
        //添加指示器及遮罩
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.dimBackground = YES; //加层阴影
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"加载中...";
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            [self requestCategoryList:bankName yhzh:intoBankTF.text yhmm:bankpassWordTF.text czzj:setMoneyPassWord.text tag:kBusinessTagGetBankBD];
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
        });
    }
    
}

#pragma mark - Request Methods
//获取品牌列表
- (void)requestCategoryList:(NSString *)yhdm yhzh:(NSString *)yhzh  yhmm:(NSString *)yhmm czzj:(NSString *)czzj tag:(kBusinessTag)_tag
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"请求品牌列表");
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
    [paraDic setObject:yhdm forKey:@"yhdm"];
    [paraDic setObject:yhzh forKey:@"yhzh"];
    [paraDic setObject:yhmm forKey:@"wbzhmm"];
    [paraDic setObject:czzj forKey:@"set_zjmm"];
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
    
	if (tag==kBusinessTagGetBankBD ) {
       [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([[jsonDic objectForKey:@"success"] boolValue] == 0) {
            //数据异常处理
            [self.view makeToast:@"绑定失败"];
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
    if (tag == kBusinessTagGetBankBD) {
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
    
    [_ddList removeFromParentViewController];
    _ddList = nil;
    
    
    [bankNumTF removeFromSuperview];
    bankNumTF = nil;
    [intoBankTF removeFromSuperview];
    intoBankTF = nil;
    [bankpassWordTF removeFromSuperview];
    bankpassWordTF = nil;
    SelectLable.delegate = nil;
    [SelectLable removeFromSuperview];
    SelectLable = nil;
    [setMoneyPassWord removeFromSuperview];
    setMoneyPassWord = nil;
    
    array3 = nil;
    bankName = nil;
   
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

@end
