//
//  SeniorInvestorsViewController.m
//  TeenagersCreateModel
//
//  Created by Yonghui Xiong on 14-11-12.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "SeniorInvestorsViewController.h"
#import "AppDelegate.h"
#import "Customer.h"


@interface SeniorInvestorsViewController ()
{
    UITextField *adreessText;
    UITextField *fundText;
    UITextField *sszbText;
    UITextField *phoneText;
    UITextField *userText;
    UIScrollView *scrollView;

    NSMutableArray *array1;
    NSMutableArray *array2;
    NSMutableArray *array3;
    UIView *baseView;
    UILabel *passPortLab;
    UILabel *faceLab;
    UIButton *passPortBtn;
    UIButton *faceBtn;
    int number;
}
@end

@implementation SeniorInvestorsViewController

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
    UIView *baseV = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    baseV.backgroundColor = [ColorUtil colorWithHexString:@"eeeeee"];
    //baseView.backgroundColor = [UIColor grayColor];
    self.view = baseV;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //相对于上面的接口，这个接口可以动画的改变statusBar的前景色
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    
    statusBarView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"title_bg"]];
    
    [self.view addSubview:statusBarView];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    array1 = [[NSMutableArray alloc] init];
    array2 = [[NSMutableArray alloc] init];
    array3 = [[NSMutableArray alloc] init];
    number = 0;
    UINavigationBar *navibar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 44)];
    navibar.userInteractionEnabled = YES;
    //navibar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navbar.png"]];
    //[navibar setBackgroundImage:[UIImage imageNamed:@"title_bg"]  forBarMetrics:UIBarMetricsDefault];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
        navibar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"title_bg"]];
        
    } else {
        navibar.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"title_bg"]];
    }

    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 12, 40, 20);
    [leftBtn setImage:[UIImage imageNamed:@"return_ico"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    UINavigationItem *navibarItem = [[UINavigationItem alloc]init];
    navibarItem.title = self.title;
    navibarItem.leftBarButtonItem= leftItem;
    // self.navigationItem.rightBarButtonItem = leftItem;
    [navibar pushNavigationItem:navibarItem animated:YES];
    [self.view addSubview:navibar];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    [scrollView setContentSize:CGSizeMake(ScreenWidth, 620)];
    
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    Customer *customer = [delegate.array objectAtIndex:0];
    if (customer.isHGTZR) {
       
        {
            
            NSArray *arr = @[@"注册地址:",@"注册资产(万元):",@"实收资本:",@"联系人:",@"电话号码:",@"组织机构代码附件:",@"营业执照附件:"];
            
            for (int i = 0; i < arr.count ; i++) {
                
                if (i == 6) {
                    UILabel *baseLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,20 + 40*i + 40, 80, 40)];
                    baseLabel.numberOfLines = 0;
                    baseLabel.textAlignment = NSTextAlignmentRight;
                    baseLabel.font = [UIFont boldSystemFontOfSize:14];
                    baseLabel.text = [arr objectAtIndex:i];
                    [scrollView addSubview:[UIView withLabel:baseLabel]];
                    
                    
                } else {
                    
                    UILabel *baseLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,20 + 40*i, 80, 40)];
                    baseLabel.numberOfLines = 0;
                    baseLabel.textAlignment = NSTextAlignmentRight;
                    baseLabel.font = [UIFont boldSystemFontOfSize:14];
                    baseLabel.text = [arr objectAtIndex:i];
                    [scrollView addSubview:[UIView withLabel:baseLabel]];
                }
            }
            
            //注册地址
            
            
            adreessText = [[UITextField alloc] initWithFrame:CGRectMake(100,90 - 64, 200, 30)];
            adreessText.borderStyle = UITextBorderStyleLine;
            adreessText.clearButtonMode = UITextFieldViewModeWhileEditing;
            adreessText.delegate = self;
            adreessText.placeholder = @"请输入地址";
            adreessText.font = [UIFont systemFontOfSize:12];
            [scrollView addSubview:adreessText];
            
            //资本
            fundText = [[UITextField alloc] initWithFrame:CGRectMake(100,130 - 64, 200, 30)];
            fundText.borderStyle = UITextBorderStyleLine;
            fundText.clearButtonMode = UITextFieldViewModeWhileEditing;
            fundText.delegate = self;
            fundText.placeholder = @"请输入资本";
            fundText.font = [UIFont systemFontOfSize:12];
            [scrollView addSubview:fundText];
            
            //实收资本
            sszbText = [[UITextField alloc] initWithFrame:CGRectMake(100,170 - 64, 200, 30)];
            sszbText.borderStyle = UITextBorderStyleLine;
            sszbText.clearButtonMode = UITextFieldViewModeWhileEditing;
            sszbText.delegate = self;
            sszbText.placeholder = @"请输入实收资本";
            sszbText.font = [UIFont systemFontOfSize:12];
            [scrollView addSubview:sszbText];
            
            //联系人
            phoneText = [[UITextField alloc] initWithFrame:CGRectMake(100,210 - 64, 200, 30)];
            phoneText.borderStyle = UITextBorderStyleLine;
            phoneText.clearButtonMode = UITextFieldViewModeWhileEditing;
            phoneText.delegate = self;
            phoneText.placeholder = @"请输入联系人";
            phoneText.font = [UIFont systemFontOfSize:12];
            [scrollView addSubview:phoneText];
            
            //电话号码
            userText = [[UITextField alloc] initWithFrame:CGRectMake(100,250 - 64, 200, 30)];
            userText.borderStyle = UITextBorderStyleLine;
            userText.clearButtonMode = UITextFieldViewModeWhileEditing;
            userText.delegate = self;
            userText.placeholder = @"请输入电话号码";
            userText.font = [UIFont systemFontOfSize:12];
            [scrollView addSubview:userText];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(320 - 70,290 - 64, 50, 30);
            btn.tag = 22220;
            btn.backgroundColor = [UIColor blueColor];
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            [btn setTitle:@"浏览" forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnMthods:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:btn];
            
            UILabel *labTip = [[UILabel alloc] initWithFrame:CGRectMake(100, 290 - 64, 150, 30)];
            labTip.font = [UIFont systemFontOfSize:10];
            labTip.text = @"(需上传1张，限制10兆以内)";
            [scrollView addSubview:labTip];
            
            
            UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
            btn2.frame = CGRectMake(320 - 70,370 - 64, 50, 30);
            btn2.tag = 22221;
            btn2.backgroundColor = [UIColor blueColor];
            btn2.titleLabel.font = [UIFont systemFontOfSize:12];
            [btn2 setTitle:@"浏览" forState:UIControlStateNormal];
            [btn2 addTarget:self action:@selector(btnMthods:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:btn2];
            
            labTip = [[UILabel alloc] initWithFrame:CGRectMake(100, 370 - 64, 150, 30)];
            labTip.font = [UIFont systemFontOfSize:10];
            labTip.text = @"(需上传1张，限制10兆以内)";
            [scrollView addSubview:labTip];
            
            passPortLab  = [[UILabel alloc] initWithFrame:CGRectMake(20 , 410 - 64, 80, 30)];
            passPortLab.textAlignment = NSTextAlignmentRight;
            passPortLab.font = [UIFont systemFontOfSize:14];
            [scrollView addSubview:passPortLab];
            
            passPortBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            passPortBtn.frame = CGRectMake(100 , 410 - 64, 50, 30);
            [passPortBtn setTitle:@"删除" forState:UIControlStateNormal];
            [passPortBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            passPortBtn.tag = 10000000;
            passPortBtn.hidden = YES;
            [passPortBtn addTarget:self action:@selector(cancerlMethods:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:passPortBtn];
            
            
            faceLab  = [[UILabel alloc] initWithFrame:CGRectMake(20 , 330 - 64, 80, 30)];
            faceLab.textAlignment = NSTextAlignmentRight;
            faceLab.font = [UIFont systemFontOfSize:14];
            //passPortLab.text = [array2 objectAtIndex:0];
            [scrollView addSubview:faceLab];
            
            faceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            faceBtn.frame = CGRectMake(100 , 330 - 64, 50, 30);
            [faceBtn setTitle:@"删除" forState:UIControlStateNormal];
            [faceBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            faceBtn.hidden = YES;
            faceBtn.tag = 10000001;
            [faceBtn addTarget:self action:@selector(cancerlMethods:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:faceBtn];
            
            UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            commitBtn.frame = CGRectMake(50, 450, 220, 40);
            commitBtn.backgroundColor = [ColorUtil colorWithHexString:@"37B3D9"];
            [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
            [commitBtn addTarget:self action:@selector(comfirmBtnMethodsAgain:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:commitBtn];
            
        }
        
        
        
    } else {
    
    NSArray *arr = @[@"注册地址:",@"注册资产(万元):",@"实收资本:",@"联系人:",@"电话号码:",@"组织机构代码附件:",@"营业执照附件:",@"法人代表身份证附件:"];
 
    
    for (int i = 0; i < arr.count ; i++) {
        
        if (i == 6) {
            UILabel *baseLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,20 + 40*i + 40, 80, 40)];
            baseLabel.numberOfLines = 0;
            baseLabel.textAlignment = NSTextAlignmentRight;
            baseLabel.font = [UIFont boldSystemFontOfSize:14];
            baseLabel.text = [arr objectAtIndex:i];
           [scrollView addSubview:[UIView withLabel:baseLabel]];
            
            
        } else if (i == 7) {
            
            UILabel *baseLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,20 + 40*i + 80, 80, 40)];
            baseLabel.numberOfLines = 0;
            baseLabel.textAlignment = NSTextAlignmentRight;
            baseLabel.font = [UIFont boldSystemFontOfSize:14];
            baseLabel.text = [arr objectAtIndex:7];
           [scrollView addSubview:[UIView withLabel:baseLabel]];
            
            
        } else {
        
        UILabel *baseLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,20 + 40*i, 80, 40)];
        baseLabel.numberOfLines = 0;
        baseLabel.textAlignment = NSTextAlignmentRight;
        baseLabel.font = [UIFont boldSystemFontOfSize:14];
        baseLabel.text = [arr objectAtIndex:i];
        [scrollView addSubview:[UIView withLabel:baseLabel]];
        }
    }
    
    //注册地址
    
    
    adreessText = [[UITextField alloc] initWithFrame:CGRectMake(100,90 - 64, 200, 30)];
    adreessText.borderStyle = UITextBorderStyleLine;
    adreessText.clearButtonMode = UITextFieldViewModeWhileEditing;
    adreessText.delegate = self;
    adreessText.placeholder = @"请输入地址";
    adreessText.font = [UIFont systemFontOfSize:12];
    [scrollView addSubview:adreessText];
    
    //资本
    fundText = [[UITextField alloc] initWithFrame:CGRectMake(100,130 - 64, 200, 30)];
    fundText.borderStyle = UITextBorderStyleLine;
    fundText.clearButtonMode = UITextFieldViewModeWhileEditing;
    fundText.delegate = self;
    fundText.placeholder = @"请输入资本";
    fundText.font = [UIFont systemFontOfSize:12];
    [scrollView addSubview:fundText];
    
    //实收资本
    sszbText = [[UITextField alloc] initWithFrame:CGRectMake(100,170 - 64, 200, 30)];
    sszbText.borderStyle = UITextBorderStyleLine;
    sszbText.clearButtonMode = UITextFieldViewModeWhileEditing;
    sszbText.delegate = self;
    sszbText.placeholder = @"请输入实收资本";
    sszbText.font = [UIFont systemFontOfSize:12];
    [scrollView addSubview:sszbText];
    
    //联系人
    phoneText = [[UITextField alloc] initWithFrame:CGRectMake(100,210 - 64, 200, 30)];
    phoneText.borderStyle = UITextBorderStyleLine;
    phoneText.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneText.delegate = self;
    phoneText.placeholder = @"请输入联系人";
    phoneText.font = [UIFont systemFontOfSize:12];
    [scrollView addSubview:phoneText];
    
    //电话号码
    userText = [[UITextField alloc] initWithFrame:CGRectMake(100,250 - 64, 200, 30)];
    userText.borderStyle = UITextBorderStyleLine;
    userText.clearButtonMode = UITextFieldViewModeWhileEditing;
    userText.delegate = self;
    userText.placeholder = @"请输入电话号码";
    userText.font = [UIFont systemFontOfSize:12];
    [scrollView addSubview:userText];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(320 - 70,290 - 64, 50, 30);
    btn.tag = 22220;
    btn.backgroundColor = [UIColor blueColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setTitle:@"浏览" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnMthods:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btn];
    
    UILabel *labTip = [[UILabel alloc] initWithFrame:CGRectMake(100, 290 - 64, 150, 30)];
    labTip.font = [UIFont systemFontOfSize:10];
    labTip.text = @"(需上传1张，限制10兆以内)";
    [scrollView addSubview:labTip];
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(320 - 70,370 - 64, 50, 30);
    btn2.tag = 22221;
    btn2.backgroundColor = [UIColor blueColor];
    btn2.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn2 setTitle:@"浏览" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btnMthods:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btn2];
    
    labTip = [[UILabel alloc] initWithFrame:CGRectMake(100, 370 - 64, 150, 30)];
    labTip.font = [UIFont systemFontOfSize:10];
    labTip.text = @"(需上传1张，限制10兆以内)";
    [scrollView addSubview:labTip];
    
    passPortLab  = [[UILabel alloc] initWithFrame:CGRectMake(20 , 410 - 64, 80, 30)];
    passPortLab.textAlignment = NSTextAlignmentRight;
    passPortLab.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:passPortLab];
    
    passPortBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    passPortBtn.frame = CGRectMake(100 , 410 - 64, 50, 30);
    [passPortBtn setTitle:@"删除" forState:UIControlStateNormal];
    [passPortBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    passPortBtn.tag = 10000000;
    passPortBtn.hidden = YES;
    [passPortBtn addTarget:self action:@selector(cancerlMethods:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:passPortBtn];
    
    
    
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(320 - 70,450 - 64, 50, 30);
    btn3.tag = 22222;
    btn3.backgroundColor = [UIColor blueColor];
    btn3.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn3 setTitle:@"浏览" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(btnMthods:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btn3];
    
    labTip = [[UILabel alloc] initWithFrame:CGRectMake(100, 450 - 64, 150, 30)];
    labTip.font = [UIFont systemFontOfSize:10];
    labTip.text = @"(需上传2张，限制10兆以内)";
    [scrollView addSubview:labTip];
    
    
    faceLab  = [[UILabel alloc] initWithFrame:CGRectMake(20 , 330 - 64, 80, 30)];
    faceLab.textAlignment = NSTextAlignmentRight;
    faceLab.font = [UIFont systemFontOfSize:14];
    //passPortLab.text = [array2 objectAtIndex:0];
    [scrollView addSubview:faceLab];
    
    faceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    faceBtn.frame = CGRectMake(100 , 330 - 64, 50, 30);
    [faceBtn setTitle:@"删除" forState:UIControlStateNormal];
    [faceBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    faceBtn.hidden = YES;
    faceBtn.tag = 10000001;
    [faceBtn addTarget:self action:@selector(cancerlMethods:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:faceBtn];
    
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.frame = CGRectMake(50, 500, 220, 40);
    commitBtn.backgroundColor = [ColorUtil colorWithHexString:@"37B3D9"];
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(comfirmBtnMethods:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:commitBtn];
    
    }
    
    [self.view addSubview:scrollView];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs;
    if(textField == fundText || textField == userText)
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


-(void)comfirmBtnMethodsAgain:(UIButton *)btn {
 
    if ([adreessText.text isEqualToString:@""]) {
        [self.view makeToast:@"请输入地址" duration:0.5 position:@"center"];
    } else if ([fundText.text isEqualToString:@""] ){
        
        [self.view makeToast:@"请输入年收入" duration:0.5 position:@"center"];
        
    } else if ( [sszbText.text isEqualToString:@""]){
        
        [self.view makeToast:@"请输入公司" duration:0.5 position:@"center"];
    } else if ([userText.text isEqualToString:@""] ){
        
        [self.view makeToast:@"请输入职位" duration:0.5 position:@"center"];
    } else if ([phoneText.text isEqualToString:@""] ){
        
        [self.view makeToast:@"请输入联系号码" duration:0.5 position:@"center"];
    } else if (array2.count != 1){
        
        [self.view makeToast:@"请上传组织机构代码附件" duration:0.5 position:@"center"];
        
    }else if (array3.count != 1){
        
        [self.view makeToast:@"请上传营业执照附件" duration:0.5 position:@"center"];
        
    } else {
        
        NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
        [paraDic setObject:@"1" forKey:@"jgbz"];
        [paraDic setObject:adreessText.text forKey:@"zcdz"];
        [paraDic setObject:fundText.text forKey:@"zczb"];
        [paraDic setObject:sszbText.text forKey:@"sszb"];
        [paraDic setObject:phoneText.text forKey:@"lxr"];
        [paraDic setObject:userText.text forKey:@"dhhm"];
        [paraDic setObject:[array3 objectAtIndex:0] forKey:@"fj1"];
        [paraDic setObject:[array2 objectAtIndex:0] forKey:@"fj2"];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.dimBackground = YES; //加层阴影
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"加载中...";
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:kBusinessTagGetSjTzr owner:self];
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
        });
        
        
        
    }
  

}
-(void)comfirmBtnMethods:(UIButton *)btn {
    if ([adreessText.text isEqualToString:@""]) {
        [self.view makeToast:@"请输入地址" duration:0.5 position:@"center"];
    } else if ([fundText.text isEqualToString:@""] ){
        
        [self.view makeToast:@"请输入年收入" duration:0.5 position:@"center"];
        
    } else if ( [sszbText.text isEqualToString:@""]){
        
        [self.view makeToast:@"请输入公司" duration:0.5 position:@"center"];
    } else if ([userText.text isEqualToString:@""] ){
        
        [self.view makeToast:@"请输入职位" duration:0.5 position:@"center"];
    } else if ([phoneText.text isEqualToString:@""] ){
        
        [self.view makeToast:@"请输入职位" duration:0.5 position:@"center"];
    }else if (array1.count != 2){
        
        [self.view makeToast:@"请上传身份证附件" duration:0.5 position:@"center"];
       
    } else if (array2.count != 1){
        
        [self.view makeToast:@"请上传资产证明文件" duration:0.5 position:@"center"];
        
    }else if (array3.count != 1){
        
        [self.view makeToast:@"请上传资产证明文件" duration:0.5 position:@"center"];
        
    } else {
        
        NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
        [paraDic setObject:@"1" forKey:@"jgbz"];
        [paraDic setObject:adreessText.text forKey:@"zcdz"];
        [paraDic setObject:fundText.text forKey:@"zczb"];
        [paraDic setObject:sszbText.text forKey:@"sszb"];
        [paraDic setObject:phoneText.text forKey:@"lxr"];
        [paraDic setObject:userText.text forKey:@"dhhm"];
        NSString *str;
        
        if (array1.count == 1) {
            str = [array1 objectAtIndex:0];
        } else if (array1.count == 2){
            
            str = [NSString stringWithFormat:@"%@|%@",[array1 objectAtIndex:0],[array1 objectAtIndex:1]];
            
        }
        [paraDic setObject:[array3 objectAtIndex:0] forKey:@"fj1"];
        [paraDic setObject:[array2 objectAtIndex:0] forKey:@"fj2"];
        [paraDic setObject:str forKey:@"fj3"];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.dimBackground = YES; //加层阴影
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"加载中...";
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:kBusinessTagGetSjTzr owner:self];
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
        });
        
        
        
    }
}





-(void)reloadImageView {
    
    if (array1.count > 0&& array1.count < 3) {
        baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 490 - 64, 320, 30)];
        baseView.backgroundColor = [UIColor clearColor];
        for (int i = 0; i < array1.count; i++) {
            
            
            
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20 + 160*i, 0, 80, 30)];
            lab.textAlignment = NSTextAlignmentRight;
            lab.font = [UIFont systemFontOfSize:14];
            lab.text = [array1 objectAtIndex:i];
            [baseView addSubview:lab];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(100 + 160*i, 0, 50, 30);
            [btn setTitle:@"删除" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            btn.tag = i;
            [btn addTarget:self action:@selector(cancerlBtnMethods:) forControlEvents:UIControlEventTouchUpInside];
            [baseView addSubview:btn];
            
        }
        [scrollView addSubview:baseView];
    }
    
}

-(void)cancerlBtnMethods:(UIButton *)btn {
    
    [array1 removeObjectAtIndex:btn.tag];
    [baseView removeFromSuperview];
    baseView = nil;
    
    [self reloadImageView];
    
}


-(void)cancerlMethods:(UIButton *)btn {
    
    if (btn.tag == 10000000) {
        [array2 removeAllObjects];
        passPortBtn.hidden = YES;
        passPortLab.text = @"";
    } else  if (btn.tag == 10000001) {
        [array3 removeAllObjects];
        faceBtn.hidden = YES;
        faceLab.text = @"";
    }
    
}




-(void)btnMthods:(UIButton *)btn {
    
    
    UIActionSheet *sheet;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
        
    } else {
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    sheet.tag = btn.tag;
    [sheet showInView:self.view];
    
    
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
        NSUInteger sourceType = 0;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:{
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    //hasLoadedCamera = YES;
                }
                    break;
                case 2:{
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    // hasLoadedCamera = YES;
                }
                    break;
            }
        }else {
            if (buttonIndex == 0) {
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        
        [self showcamera:sourceType withImagePickerTag:actionSheet.tag];
        
    
}

- (void)showcamera:(NSInteger)tag withImagePickerTag:(NSInteger )str {
  UIImagePickerController  *imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setDelegate:self];
    //imagePicker.title = str;
    [imagePicker.view setTag:str];
    NSLog(@"rrrr%@",imagePicker.title);
    //[imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [imagePicker setAllowsEditing:YES];
    imagePicker.sourceType = tag;
    [self presentViewController:imagePicker animated:YES completion:^{}];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [self scaleImage:[info objectForKey:UIImagePickerControllerEditedImage]];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    
    //NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
    if (picker.view.tag == 22220) {
        
        
        if (array3.count > 1||array3.count == 1) {
            [self.view makeToast:@"最多只能上传1张图片" duration:1 position:@"center"];
        } else {
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.dimBackground = YES; //加层阴影
            hud.mode = MBProgressHUDModeIndeterminate;
            hud.labelText = @"加载中...";
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                [[NetworkModule sharedNetworkModule]postBusinessReqWithParamtersAndFile:nil number:0  withFileName:@"IdCard"  fileData:imageData tag:kBusinessTagGetRegisterUpfile owner:self];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                });
            });
            
        }
    } else if (picker.view.tag == 22221) {
        if (array2.count > 1 || array2.count == 1) {
            [self.view makeToast:@"最多只能上传一张图片" duration:1 position:@"center"];
        } else {
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.dimBackground = YES; //加层阴影
            hud.mode = MBProgressHUDModeIndeterminate;
            hud.labelText = @"加载中...";
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                [[NetworkModule sharedNetworkModule]postBusinessReqWithParamtersAndFile:nil number:0 withFileName:@"propty" fileData:imageData tag:kBusinessTagGetRegisterUpfileAgin1 owner:self];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                });
            });
            
        }
        
        
        
    } else if (picker.view.tag == 22222) {
        if (array1.count > 2 || array1.count == 2) {
            [self.view makeToast:@"最多只能上传2张图片" duration:1 position:@"center"];
        } else {
            number++;
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.dimBackground = YES; //加层阴影
            hud.mode = MBProgressHUDModeIndeterminate;
            hud.labelText = @"加载中...";
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                [[NetworkModule sharedNetworkModule]postBusinessReqWithParamtersAndFile:nil number:number withFileName:@"card" fileData:imageData tag:kBusinessTagGetRegisterUpfileAgin2 owner:self];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                });
            });
            
        }
        
    }
    
}

//图片压缩

- (UIImage *)scaleImage:(UIImage *)image {
    int kMaxResolution = 1000;
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = roundf(bounds.size.width / ratio);
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = roundf(bounds.size.height * ratio);
        }
    }
    
    NSLog(@"boudns image =%@",NSStringFromCGRect(bounds));
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    
    switch(orient) {
        case UIImageOrientationUp:
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored:
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown:
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored:
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft:
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored:
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight:
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
            //        default:
            //            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}

#pragma mark - NetworkModuleDelegate Methods
-(void)beginPost:(kBusinessTag)tag{
    
}
-(void)endPost:(NSString *)result business:(kBusinessTag)tag{
    NSLog(@"%s %d 收到数据:%@", __FUNCTION__, __LINE__, result);
    NSMutableDictionary *jsonDic = [result JSONValue];
    
	if (tag==kBusinessTagGetRegisterUpfile ) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([[jsonDic objectForKey:@"success"] boolValue] == 0) {
            //数据异常处理
            [self.view makeToast:[jsonDic objectForKey:@"msg"]];
        } else {
            [self.view makeToast:@"上传成功1张"];
            [array3 addObject:[jsonDic objectForKey:@"object"]];
            faceLab.text = [jsonDic objectForKey:@"object"];
            faceBtn.hidden = NO;
            
        }
    } else if (tag==kBusinessTagGetRegisterUpfileAgin1) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([[jsonDic objectForKey:@"success"] boolValue] == 0) {
            //数据异常处理
            [self.view makeToast:[jsonDic objectForKey:@"msg"]];
        } else {
            
            [self.view makeToast:@"上传成功一张"];
            [array2 addObject:[jsonDic objectForKey:@"object"]];
            passPortLab.text = [jsonDic objectForKey:@"object"];
            passPortBtn.hidden = NO;
            
        }
    } else if (tag==kBusinessTagGetRegisterUpfileAgin2) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([[jsonDic objectForKey:@"success"] boolValue] == 0) {
            //数据异常处理
            [self.view makeToast:[jsonDic objectForKey:@"msg"]];
        } else {
            
            [self.view makeToast:[NSString stringWithFormat:@"上传成功%d张",number]];
            [array1 addObject:[jsonDic objectForKey:@"object"]];
            if (number == 1) {
                [self reloadImageView];
            } else {
                [baseView removeFromSuperview];
                baseView = nil;
                [self reloadImageView];
            }
            
        }
    } else if (tag==kBusinessTagGetSjTzr) {
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
    //if (tag == kBusinessTagGetRegisterUpfile) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    //}
    [[NetworkModule sharedNetworkModule] cancel:tag];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    // foucsTextField = textField;
    scrollView.contentSize = CGSizeMake(320,620 +216);//原始滑动距离增加键盘高度
    CGPoint pt = [textField convertPoint:CGPointMake(0, 0) toView:scrollView];//把当前的textField的坐标映射到scrollview上
    if(scrollView.contentOffset.y-pt.y+64<=0)//判断最上面不要去滚动
        [scrollView setContentOffset:CGPointMake(0, pt.y-64) animated:YES];//华东
    
    
}


- (BOOL)textFieldShouldReturn:(UITextField*)theTextField
{
    {
        [theTextField resignFirstResponder];
        
        //开始动画
        [UIView beginAnimations:nil context:nil];
        //设定动画持续时间
        [UIView setAnimationDuration:0.3];
        scrollView.frame = CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64);
        scrollView.contentSize = CGSizeMake(ScreenWidth,620);
        //动画结束
        [UIView commitAnimations];
        
        
    }
    return YES;
}





-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


-(void)push:(UIButton *)btn {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    [adreessText removeFromSuperview];
    adreessText = nil;
    [fundText removeFromSuperview];
    fundText = nil;
    [sszbText removeFromSuperview];
    sszbText = nil;
    [phoneText removeFromSuperview];
    phoneText = nil;
    [userText removeFromSuperview];
    userText = nil;
    [scrollView removeFromSuperview];
    scrollView = nil;
    [array1 removeAllObjects];
    array1 = nil;
    [array2 removeAllObjects];
    array2 = nil;
    [array3 removeAllObjects];
    array3 = nil;
    [baseView removeFromSuperview];
    baseView = nil;
    [passPortLab removeFromSuperview];
    passPortLab = nil;
    [faceLab removeFromSuperview];
    faceLab = nil;
    [passPortBtn removeFromSuperview];
    passPortBtn = nil;
    [faceBtn removeFromSuperview];
    faceBtn = nil;

}

@end
