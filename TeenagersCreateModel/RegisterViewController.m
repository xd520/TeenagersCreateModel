//
//  RegisterViewController.m
//  TeenagersCreateModel
//
//  Created by Yonghui Xiong on 14-11-12.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "RegisterViewController.h"
#import "AppDelegate.h"
#import "QCheckBox.h"

@interface RegisterViewController ()
{
    UIScrollView *scrollView;
    QCheckBox *_check1;
    QCheckBox *_check2;
//个人
    UIView *view1;
    UITextField *userName;
    UITextField *passWord;
    UITextField *passWordAgain;
    UITextField *name;
    UITextField *phoneNum;
    UITextField *passNum;
    UITextField *email;
    UIView *checkView;
    UITextField *checkText;
    UIButton *personBtn;
//机构
    UIView *view2;
    UITextField *userNameTap;
    UITextField *passWordTap;
    UITextField *passWordAgainTap;
    UITextField *lessName;
    UITextField *allName;
    UITextField *codeTap;
    UITextField *personTap;
    UITextField *passNumTap;
    UITextField *phoneNumTap;
    UITextField *emailTap;
    UITextField *checkTextTap;
    
   
    NSString *rateStr1;
    NSString *rateStr2;
    
    UILabel *nameLabel;
    UILabel *passNumLabel;
    UILabel *codeLabel;
    UILabel *personLabel;
    UITextField *cede;
    UITextField *person;
    
    UIButton *comfirmBtn;
    
    
   
    
}
@end

@implementation RegisterViewController

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
    rateStr1 = @"";
    rateStr2 = @"";
    
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
    UINavigationItem *navibarItem = [[UINavigationItem alloc]init];
    navibarItem.title = @"注册创建人";
    navibarItem.leftBarButtonItem= leftItem;
    // self.navigationItem.rightBarButtonItem = leftItem;
    [navibar pushNavigationItem:navibarItem animated:YES];
    [self.view addSubview:navibar];
    
    //加入滑动视图
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    //scrollView.backgroundColor = [UIColor grayColor];
    [scrollView setContentSize:CGSizeMake(ScreenWidth, 600)];
//类别
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10,26, 80, 14)];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentRight;
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"类  别:";
    [scrollView addSubview:label];
    
    
    _check1 = [[QCheckBox alloc] initWithDelegate:self];
    _check1.frame = CGRectMake(105, 22,100,22);
    [_check1 setTitle:@"创业项目" forState:UIControlStateNormal];
    [_check1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _check1.tag = 1;
    [_check1.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [_check1 setChecked:YES];
    [scrollView addSubview:_check1];
    
    _check2 = [[QCheckBox alloc] initWithDelegate:self];
    _check2.frame = CGRectMake(200,22,100,22);
    [_check2 setTitle:@"创业企业" forState:UIControlStateNormal];
    _check2.tag = 2;
    [_check2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_check2.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    
    
    [scrollView addSubview:_check2];
    
    view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 54, ScreenWidth, 560)];
    //view1.hidden = YES;
    [scrollView addSubview:view1];
    view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 54, ScreenWidth, 560)];
    view2.hidden = YES;
    [scrollView addSubview:view2];
    
    [self.view addSubview:scrollView];

    [self reloadDataView];
    [self reloadViewTap];
    
}

#pragma mark - QCheckBoxDelegate

- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked {
    
    //只能单选或不选
    if (_check2.checked == YES && _check1.checked == YES) {
        if (_check1 ==checkbox) {
            [_check2 setChecked:NO];
        } else {
            [_check1 setChecked:NO];
            
        }
    }
    
    
    if (checked == 1) {
        if (checkbox.tag == 1) {
            rateStr1 = @"0";
            view1.hidden = NO;
            view2.hidden = YES;
            
            
            
        } else if (checkbox.tag == 2) {
          
            rateStr2 = @"1";
            view2.hidden = NO;
            view1.hidden = YES;
            
        }
    }
    
    
     NSLog(@"%@--676767--%@",rateStr1,rateStr2);
}




-(void)reloadDataView {
    
    
    NSArray *arr = @[@"用户名:",@"密  码:",@"确认密码:",@"姓  名:",@"身份证号码:",@"手  机:",@"邮  箱:",@"手机验证码:"];
    for (int i = 0; i < arr.count ; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 40*i, 80, 40)];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:14];
        label.text = [arr objectAtIndex:i];
        [view1 addSubview:label];
        
    }
    
//用户名
    userName = [[UITextField alloc] initWithFrame:CGRectMake(100, 5, 200, 30)];
    userName.borderStyle = UITextBorderStyleLine;
    userName.clearButtonMode = UITextFieldViewModeWhileEditing;
    userName.delegate = self;
    userName.placeholder = @"请填写用户名";
    //@"字母开头，4~16位字符，可包含英文字母，数字、\"_\""
    userName.font = [UIFont systemFontOfSize:12];
    [view1 addSubview:userName];
//密码
    passWord= [[UITextField alloc] initWithFrame:CGRectMake(100, 45, 200, 30)];
    passWord.borderStyle = UITextBorderStyleLine;
    passWord.clearButtonMode = UITextFieldViewModeWhileEditing;
    passWord.secureTextEntry = YES;
    passWord.delegate = self;
    passWord.placeholder = @"请输入密码";
    passWord.font = [UIFont systemFontOfSize:12];
    [view1 addSubview:passWord];
  
//确认密码
    passWordAgain = [[UITextField alloc] initWithFrame:CGRectMake(100, 85, 200, 30)];
    passWordAgain.borderStyle = UITextBorderStyleLine;
    passWordAgain.clearButtonMode = UITextFieldViewModeWhileEditing;
    passWordAgain.secureTextEntry = YES;
    passWordAgain.delegate = self;
    passWordAgain.placeholder = @"请再一次输入密码";
    passWordAgain.font = [UIFont systemFontOfSize:12];
    [view1 addSubview:passWordAgain];
    
//身份证号码
    phoneNum= [[UITextField alloc] initWithFrame:CGRectMake(100, 125, 200, 30)];
    phoneNum.borderStyle = UITextBorderStyleLine;
    phoneNum.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneNum.delegate = self;
    phoneNum.tag = 1;
    phoneNum.placeholder = @"请输入身份证号";
    phoneNum.font = [UIFont systemFontOfSize:12];
    [view1 addSubview:phoneNum];
    
// 姓名
    name= [[UITextField alloc] initWithFrame:CGRectMake(100, 165, 200, 30)];
    name.borderStyle = UITextBorderStyleLine;
    name.clearButtonMode = UITextFieldViewModeWhileEditing;
    name.delegate = self;
    name.placeholder = @"请输入姓名";
    name.font = [UIFont systemFontOfSize:12];
    [view1 addSubview:name];
    
//手机
    
    passNum = [[UITextField alloc] initWithFrame:CGRectMake(100, 205, 200, 30)];
    passNum.borderStyle = UITextBorderStyleLine;
    passNum.clearButtonMode = UITextFieldViewModeWhileEditing;
    passNum.tag = 2;
    passNum.delegate = self;
    passNum.placeholder = @"请填写有效掌控的手机号码";
    passNum.font = [UIFont systemFontOfSize:12];
    [view1 addSubview:passNum];
//邮箱
    email = [[UITextField alloc] initWithFrame:CGRectMake(100, 245, 200, 30)];
    email.borderStyle = UITextBorderStyleLine;
    email.clearButtonMode = UITextFieldViewModeWhileEditing;
    email.delegate = self;
    email.placeholder = @"请输入常用的邮箱";
    email.font = [UIFont systemFontOfSize:12];
    [view1 addSubview:email];
    
    
    checkText = [[UITextField alloc] initWithFrame:CGRectMake(100, 285, 110, 30)];
    checkText.borderStyle = UITextBorderStyleLine;
    checkText.clearButtonMode = UITextFieldViewModeWhileEditing;
    checkText.delegate = self;
    checkText.placeholder = @"请填写验证码";
    checkText.font = [UIFont systemFontOfSize:12];
    [view1 addSubview:checkText];
    
    UIButton *checkBtn = [[UIButton alloc] initWithFrame:CGRectMake(220, 285, 80, 30)];
    checkBtn.backgroundColor = [UIColor grayColor];
    [checkBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    checkBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [checkBtn addTarget:self action:@selector(checkBtnMethods:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:checkBtn];
    
    
    

    personBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    personBtn.frame = CGRectMake(50, 360, 220, 40);
    personBtn.tag = 111111;
    personBtn.backgroundColor = [UIColor blueColor];
    [personBtn setTitle:@"注册" forState:UIControlStateNormal];
    [personBtn addTarget:self action:@selector(comfirmBtnMethods:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:personBtn];
    
    


    
    
    
    //[self checkLoadView];
    
     //[scrollView setContentSize:CGSizeMake(ScreenWidth, 600)];
}


-(void)reloadViewTap {

    NSArray *arr = @[@"用户名:",@"密  码:",@"确认密码:",@"法定机构简称:",@"法定机构全称:",@"营业执照编码:",@"法定代表人:",@"法定代表人身份证号码:",@"手  机:",@"邮  箱:",@"手机验证码:"];
    for (int i = 0; i < arr.count ; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 40*i, 80, 40)];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:14];
        label.text = [arr objectAtIndex:i];
        [view2 addSubview:label];
        
    }
    
    //用户名
    userNameTap = [[UITextField alloc] initWithFrame:CGRectMake(100, 5, 200, 30)];
    userNameTap.borderStyle = UITextBorderStyleLine;
    userNameTap.clearButtonMode = UITextFieldViewModeWhileEditing;
    userNameTap.delegate = self;
    userNameTap.placeholder = @"请填写用户名";
    //@"字母开头，4~16位字符，可包含英文字母，数字、\"_\""
    userNameTap.font = [UIFont systemFontOfSize:12];
    [view2 addSubview:userNameTap];
    //密码
    passWordTap= [[UITextField alloc] initWithFrame:CGRectMake(100, 45, 200, 30)];
    passWordTap.borderStyle = UITextBorderStyleLine;
    passWordTap.clearButtonMode = UITextFieldViewModeWhileEditing;
    passWordTap.secureTextEntry = YES;
    passWordTap.delegate = self;
    passWordTap.placeholder = @"请输入密码";
    passWordTap.font = [UIFont systemFontOfSize:12];
    [view2 addSubview:passWordTap];
    
    //确认密码
    passWordAgainTap = [[UITextField alloc] initWithFrame:CGRectMake(100, 85, 200, 30)];
    passWordAgainTap.borderStyle = UITextBorderStyleLine;
    passWordAgainTap.clearButtonMode = UITextFieldViewModeWhileEditing;
    passWordAgainTap.secureTextEntry = YES;
    passWordAgainTap.delegate = self;
    passWordAgainTap.placeholder = @"请再一次输入密码";
    passWordAgainTap.font = [UIFont systemFontOfSize:12];
    [view2 addSubview:passWordAgainTap];
    
    //法机构简称
    lessName = [[UITextField alloc] initWithFrame:CGRectMake(100, 125, 200, 30)];
    lessName.borderStyle = UITextBorderStyleLine;
    lessName.clearButtonMode = UITextFieldViewModeWhileEditing;
    lessName.delegate = self;
    lessName.tag = 1;
    lessName.placeholder = @"请输入法机构简称";
    lessName.font = [UIFont systemFontOfSize:12];
    [view2 addSubview:lessName];
    
    //法机构全称
    allName = [[UITextField alloc] initWithFrame:CGRectMake(100, 165, 200, 30)];
    allName.borderStyle = UITextBorderStyleLine;
    allName.clearButtonMode = UITextFieldViewModeWhileEditing;
    allName.delegate = self;
    allName.placeholder = @"请输入法机构全称";
    allName.font = [UIFont systemFontOfSize:12];
    [view2 addSubview:allName];
    
    //营业执照编码
    
    codeTap = [[UITextField alloc] initWithFrame:CGRectMake(100, 205, 200, 30)];
    codeTap.borderStyle = UITextBorderStyleLine;
    codeTap.clearButtonMode = UITextFieldViewModeWhileEditing;
    codeTap.tag = 2;
    codeTap.delegate = self;
    codeTap.placeholder = @"请输入营业执照编码";
    codeTap.font = [UIFont systemFontOfSize:12];
    [view2 addSubview:codeTap];
    
//法定代表人
    personTap = [[UITextField alloc] initWithFrame:CGRectMake(100, 245, 200, 30)];
    personTap.borderStyle = UITextBorderStyleLine;
    personTap.clearButtonMode = UITextFieldViewModeWhileEditing;
    personTap.delegate = self;
    personTap.placeholder = @"请输入法定代表人";
    personTap.font = [UIFont systemFontOfSize:12];
    [view2 addSubview:personTap];
    
//法定代表人身份证号码
    passNumTap = [[UITextField alloc] initWithFrame:CGRectMake(100, 285, 200, 30)];
    passNumTap.borderStyle = UITextBorderStyleLine;
    passNumTap.clearButtonMode = UITextFieldViewModeWhileEditing;
    passNumTap.delegate = self;
    passNumTap.placeholder = @"请输入法定代表人身份证号码";
    passNumTap.font = [UIFont systemFontOfSize:12];
    [view2 addSubview:passNumTap];
    
//手机
    phoneNumTap = [[UITextField alloc] initWithFrame:CGRectMake(100, 325, 200, 30)];
    phoneNumTap.borderStyle = UITextBorderStyleLine;
    phoneNumTap.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneNumTap.delegate = self;
    phoneNumTap.placeholder = @"请输入手机号码";
    phoneNumTap.font = [UIFont systemFontOfSize:12];
    [view2 addSubview:phoneNumTap];
//邮箱
    emailTap = [[UITextField alloc] initWithFrame:CGRectMake(100, 365, 200, 30)];
    emailTap.borderStyle = UITextBorderStyleLine;
    emailTap.clearButtonMode = UITextFieldViewModeWhileEditing;
    emailTap.delegate = self;
    emailTap.placeholder = @"请输入有效掌控的邮箱";
    emailTap.font = [UIFont systemFontOfSize:12];
    [view2 addSubview:emailTap];
    
    checkTextTap = [[UITextField alloc] initWithFrame:CGRectMake(100, 405, 110, 30)];
    checkTextTap.borderStyle = UITextBorderStyleLine;
    checkTextTap.clearButtonMode = UITextFieldViewModeWhileEditing;
    checkTextTap.delegate = self;
    checkTextTap.placeholder = @"请填写验证码";
    checkTextTap.font = [UIFont systemFontOfSize:12];
    [view2 addSubview:checkTextTap];
    
    UIButton *checkBtn = [[UIButton alloc] initWithFrame:CGRectMake(220, 405, 80, 30)];
    checkBtn.backgroundColor = [UIColor grayColor];
    [checkBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    checkBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [checkBtn addTarget:self action:@selector(checkBtnMethods:) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:checkBtn];
    
    
    
    comfirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    comfirmBtn.frame = CGRectMake(50, 470, 220, 40);
    comfirmBtn.backgroundColor = [UIColor blueColor];
    comfirmBtn.tag = 111112;
    [comfirmBtn setTitle:@"注册" forState:UIControlStateNormal];
    [comfirmBtn addTarget:self action:@selector(comfirmBtnMethods:) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:comfirmBtn];

}






- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


-(BOOL)checkEmail:(NSString *)str{
    NSString *emailRegEx =
    @"(?:[A-Za-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[A-Za-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[A-Za-z0-9](?:[a-"
    @"z0-9-]*[A-Za-z0-9])?\\.)+[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[A-Za-z0-9-]*[A-Za-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    if (![emailTest evaluateWithObject:str]){
        //[self.view makeToast:@"请输入正确的邮箱" duration:1.0 position:@"center"];
        return NO;
    } else {
    
    return YES;
    }
}


-(void)checkLoadView {
    
    checkView = [[UIView alloc] initWithFrame:CGRectMake(0, 340, 320, 30)];
    UILabel *checkLabel =  [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
    checkLabel.textAlignment = NSTextAlignmentRight;
    checkLabel.font = [UIFont systemFontOfSize:15];
    checkLabel.text = @"手机验证码:";
    [checkView addSubview:checkLabel];
    checkText = [[UITextField alloc] initWithFrame:CGRectMake(110, 0, 110, 30)];
    checkText.borderStyle = UITextBorderStyleLine;
    checkText.clearButtonMode = UITextFieldViewModeWhileEditing;
    checkText.delegate = self;
    checkText.placeholder = @"请填写验证码";
    checkText.font = [UIFont systemFontOfSize:12];
    [checkView addSubview:checkText];
    
    UIButton *checkBtn = [[UIButton alloc] initWithFrame:CGRectMake(230, 0, 80, 30)];
    checkBtn.backgroundColor = [UIColor grayColor];
    [checkBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    checkBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [checkBtn addTarget:self action:@selector(checkBtnMethods:) forControlEvents:UIControlEventTouchUpInside];
    [checkView addSubview:checkBtn];

    [scrollView addSubview:checkView];

}


-(void)checkLoadViewData {
    
    checkView = [[UIView alloc] initWithFrame:CGRectMake(0, 420, 320, 30)];
    UILabel *checkLabel =  [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
    checkLabel.textAlignment = NSTextAlignmentRight;
    checkLabel.font = [UIFont systemFontOfSize:15];
    checkLabel.text = @"手机验证码:";
    [checkView addSubview:checkLabel];
    checkText = [[UITextField alloc] initWithFrame:CGRectMake(110, 0, 110, 30)];
    checkText.borderStyle = UITextBorderStyleLine;
    checkText.clearButtonMode = UITextFieldViewModeWhileEditing;
    checkText.delegate = self;
    checkText.placeholder = @"请填写验证码";
    checkText.font = [UIFont systemFontOfSize:12];
    [checkView addSubview:checkText];
    
    UIButton *checkBtn = [[UIButton alloc] initWithFrame:CGRectMake(230, 0, 80, 30)];
    checkBtn.backgroundColor = [UIColor grayColor];
    [checkBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    checkBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [checkBtn addTarget:self action:@selector(checkBtnMethods:) forControlEvents:UIControlEventTouchUpInside];
    [checkView addSubview:checkBtn];
    
    [scrollView addSubview:checkView];
    
}

-(void)checkBtnMethods:(UIButton *)btn {
    if ([passNum.text isEqualToString:@""]) {
        [self.view makeToast:@"请输入手机号" duration:0.5 position:@"center"];
    } else {
    
        NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
        [paraDic setObject:passNum.text forKey:@"mobile"];
        
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.dimBackground = YES; //加层阴影
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"加载中...";
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:kBusinessTagGetYzm owner:self];
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
        });
    }

}


-(void)comfirmBtnMethods:(UIButton *)btn {
    
    if (_check1.checked || _check2.checked) {
    
    if (btn.tag == 111111) {
        if ([userName.text isEqualToString:@""]) {
            [self.view makeToast:@"请输入用户名"];
        } else if ([passWord.text isEqualToString:@""]){
        [self.view makeToast:@"请输入密码"];
        }else if ([passWordAgain.text isEqualToString:@""]){
            [self.view makeToast:@"请输入正确的密码"];
        } else if ([phoneNum.text isEqualToString:@""]){
            [self.view makeToast:@"请输入手机号码"];
        } else if ([email.text isEqualToString:@""]){
            [self.view makeToast:@"请输入邮箱"];
        } else if ([name.text isEqualToString:@""]){
            [self.view makeToast:@"请输入姓名"];
        } else if ([passNum.text isEqualToString:@""]){
            [self.view makeToast:@"请输入身份证号码"];
        }else if ([checkText.text isEqualToString:@""]){
            [self.view makeToast:@"请输入验证码"];
        } else {
        
            
            //添加指示器及遮罩
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.dimBackground = YES; //加层阴影
            hud.mode = MBProgressHUDModeIndeterminate;
            hud.labelText = @"加载中...";
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                [self requestPersonRegister:rateStr1 yhm:userName.text khmc:name.text zjbh:phoneNum.text mobile:passNum.text email:email.text psw:passWord.text sjyzm:checkText.text tag:kBusinessTagGetRZF];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                });
            });
        
        }
        
        
    } else if (btn.tag == 111112){
    
        if ([userNameTap.text isEqualToString:@""]) {
            [self.view makeToast:@"请输入用户名"];
        } else if ([passWordTap.text isEqualToString:@""]){
            [self.view makeToast:@"请输入密码"];
        }else if ([passWordAgainTap.text isEqualToString:@""]){
            [self.view makeToast:@"请输入正确的密码"];
        } else if ([phoneNumTap.text isEqualToString:@""]){
            [self.view makeToast:@"请输入手机号码"];
        } else if ([emailTap.text isEqualToString:@""]){
            [self.view makeToast:@"请输入邮箱"];
        } else if ([lessName.text isEqualToString:@""]){
          [self.view makeToast:@"请输入法定机构简称"];
        }else if ([allName.text isEqualToString:@""]){
            [self.view makeToast:@"请输入法定机构全称"];
        }  else if ([passNumTap.text isEqualToString:@""]){
            [self.view makeToast:@"请输入法定代表人身份证号码"];
        }else if ([codeTap.text isEqualToString:@""]){
           [self.view makeToast:@"请输入营业执照编码"];
        }else if ([personTap.text isEqualToString:@""]){
           [self.view makeToast:@"请输入法定代表人"];
        }else if ([checkTextTap.text isEqualToString:@""]){
            [self.view makeToast:@"请输入法定代表人"];
        } else {
            
           
            //添加指示器及遮罩
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.dimBackground = YES; //加层阴影
            hud.mode = MBProgressHUDModeIndeterminate;
            hud.labelText = @"加载中...";
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                [self requestConfirmRegister:rateStr2 yhm:userNameTap.text khmc:lessName.text khqc:allName.text zjbh:phoneNumTap.text mobile:passNumTap.text email:emailTap.text psw:passWordTap.text frdb:personTap.text frdb_zjbh:codeTap.text sjyzm:checkTextTap.text tag:kBusinessTagGetRZF];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                });
            });
            
        }
        
    }
    
    } else {
    
     [self.view makeToast:@"请选择类别" duration:1.0 position:@"center"];
    }
}


//获取品牌列表
- (void)requestPersonRegister:(NSString *)yhdm yhm:(NSString *)yhzh  khmc:(NSString *)yhmm zjbh:(NSString *)zjbh  mobile:(NSString *)mobile email:(NSString *)eml  psw:(NSString *)psw sjyzm:(NSString *)sjyzm  tag:(kBusinessTag)_tag
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"请求品牌列表");
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
    [paraDic setObject:yhdm forKey:@"jgbz"];
    [paraDic setObject:yhzh forKey:@"yhm"];
    [paraDic setObject:yhmm forKey:@"khmc"];
    [paraDic setObject:@"0" forKey:@"zjlb"];
    [paraDic setObject:zjbh forKey:@"zjbh"];
    [paraDic setObject:mobile forKey:@"mobile"];
    [paraDic setObject:eml forKey:@"email"];
    [paraDic setObject:psw forKey:@"psw"];
    [paraDic setObject:sjyzm forKey:@"sjyzm"];
    
    [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:_tag owner:self];
    
}

- (void)requestConfirmRegister:(NSString *)yhdm yhm:(NSString *)yhzh  khmc:(NSString *)yhmm  khqc:(NSString *)khqc zjbh:(NSString *)zjbh  mobile:(NSString *)mobile email:(NSString *)eml  psw:(NSString *)psw frdb:(NSString *)frdb  frdb_zjbh:(NSString *)frdb_zjbh sjyzm:(NSString *)sjyzm tag:(kBusinessTag)_tag
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"请求品牌列表");
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
    [paraDic setObject:yhdm forKey:@"jgbz"];
    [paraDic setObject:yhzh forKey:@"yhm"];
    [paraDic setObject:yhmm forKey:@"khmc"];
    [paraDic setObject:@"0" forKey:@"zjlb"];
    [paraDic setObject:zjbh forKey:@"zjbh"];
    [paraDic setObject:mobile forKey:@"mobile"];
    [paraDic setObject:eml forKey:@"email"];
    [paraDic setObject:psw forKey:@"psw"];
    
    [paraDic setObject:frdb forKey:@"frdb"];
    [paraDic setObject:@"0" forKey:@"zjlb_frdb"];
    [paraDic setObject:frdb_zjbh forKey:@"zjbh_frdb"];
    [paraDic setObject:sjyzm forKey:@"sjyzm"];
    [paraDic setObject:khqc forKey:@"khqc"];
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
    
	if (tag==kBusinessTagGetRZF ) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([[jsonDic objectForKey:@"success"] boolValue] == 0) {
            //数据异常处理
            [self.view makeToast:[jsonDic objectForKey:@"msg"]];
        } else {
            [self.view makeToast:@"注册成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else if (tag == kBusinessTagGetUpdateUserName) {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([[jsonDic objectForKey:@"success"] boolValue] == 0) {
            //数据异常处理
            [self.view makeToast:[jsonDic objectForKey:@"msg"] duration:1.0 position:@"center"];
            userName.text = @"";
        } else {
            [self.view makeToast:[jsonDic objectForKey:@"msg"] duration:1.0 position:@"center"];
           
        }
    }else if (tag == kBusinessTagGetUpdateUserNameAgain) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([[jsonDic objectForKey:@"success"] boolValue] == 0) {
            //数据异常处理
            [self.view makeToast:[jsonDic objectForKey:@"msg"] duration:1.0 position:@"center"];
            userNameTap.text = @"";
        } else {
            [self.view makeToast:[jsonDic objectForKey:@"msg"] duration:1.0 position:@"center"];
            
        }
    } else if (tag == kBusinessTagGetYzm) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([[jsonDic objectForKey:@"success"] boolValue] == 0) {
            //数据异常处理
            [self.view makeToast:[jsonDic objectForKey:@"msg"] duration:1.0 position:@"center"];
            passNum.text = @"";
            passNumTap.text = @"";
        } else {
            
           [self.view makeToast:[jsonDic objectForKey:@"msg"] duration:1.0 position:@"center"];
            
        }
    } else if (tag == kBusinessTagGetYzmobile) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([[jsonDic objectForKey:@"success"] boolValue] == 0) {
            //数据异常处理
            [self.view makeToast:[jsonDic objectForKey:@"msg"] duration:1.0 position:@"center"];
            phoneNum.text = @"";
        } else {
            
            if ([[jsonDic objectForKey:@"msg"] isEqualToString:@"手机号已被使用"]) {
              [self.view makeToast:[jsonDic objectForKey:@"msg"] duration:1.0 position:@"center"];
                 phoneNum.text = @"";
            } else {
            
            [self.view makeToast:[jsonDic objectForKey:@"msg"] duration:1.0 position:@"center"];
           
            }
        }
    } else if (tag == kBusinessTagGetYzmobileAgain) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([[jsonDic objectForKey:@"success"] boolValue] == 0) {
            //数据异常处理
            [self.view makeToast:[jsonDic objectForKey:@"msg"] duration:1.0 position:@"center"];
            phoneNumTap.text = @"";
        } else {
            
            if ([[jsonDic objectForKey:@"msg"] isEqualToString:@"手机号已被使用"]) {
                [self.view makeToast:[jsonDic objectForKey:@"msg"] duration:1.0 position:@"center"];
                phoneNumTap.text = @"";
            } else {
                
                [self.view makeToast:[jsonDic objectForKey:@"msg"] duration:1.0 position:@"center"];
                
            }
        }
    }else if (tag == kBusinessTagGetYzzjbh) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([[jsonDic objectForKey:@"success"] boolValue] == 0) {
            //数据异常处理
            [self.view makeToast:[jsonDic objectForKey:@"msg"] duration:1.0 position:@"center"];
            passNum.text = @"";
        } else {
            [self.view makeToast:[jsonDic objectForKey:@"msg"] duration:1.0 position:@"center"];
            
        }
    } else if (tag == kBusinessTagGetYzzjbhAgain) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([[jsonDic objectForKey:@"success"] boolValue] == 0) {
            //数据异常处理
            [self.view makeToast:[jsonDic objectForKey:@"msg"] duration:1.0 position:@"center"];
            passNumTap.text = @"";
        } else {
            [self.view makeToast:[jsonDic objectForKey:@"msg"] duration:1.0 position:@"center"];
            
        }
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

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == passWord ) {
        if (passWord.text.length < 6||passWord.text.length > 8) {
            //[self.view makeToast:@"请输入6~8字符"];
            [self.view makeToast:@"请输入6~8字符" duration:1.0 position:@"center"];
            passWord.text = @"";
        }
    } else if (textField == passWordTap) {
        if (passWordTap.text.length < 6||passWordTap.text.length > 8) {
            //[self.view makeToast:@"请输入6~8字符"];
            [self.view makeToast:@"请输入6~8字符" duration:1.0 position:@"center"];
            passWordTap.text = @"";
        }
    } else if (textField == passWordAgain){
        if ([passWordAgain.text isEqualToString:@""] ||![passWordAgain.text isEqualToString:passWord.text]) {
            
            [self.view makeToast:@"请输入正确的密码" duration:1.0 position:@"center"];
            passWordAgain.text = @"";
            
        }
    } else if (textField == passWordAgainTap){
        if ([passWordAgainTap.text isEqualToString:@""] ||![passWordAgainTap.text isEqualToString:passWordTap.text]) {
            
            [self.view makeToast:@"请输入正确的密码" duration:1.0 position:@"center"];
            passWordAgainTap.text = @"";
            
        }
        
    }else if (textField == email){
        if ([email.text isEqualToString:@""] ||![self checkEmail:email.text]) {
            
          [self.view makeToast:@"请输入有效邮箱" duration:1.0 position:@"center"];
            email.text = @"";
            
            }
    }else if (textField == emailTap){
        if ([emailTap.text isEqualToString:@""] ||![self checkEmail:emailTap.text]) {
            
            [self.view makeToast:@"请输入有效邮箱" duration:1.0 position:@"center"];
            emailTap.text = @"";
            
        }
    } else if (textField == userNameTap){
        
        if (userNameTap.text.length < 3||userNameTap.text.length > 16) {
            //[self.view makeToast:@"请输入6~8字符"];
            [self.view makeToast:@"请输入3~16字符" duration:1.0 position:@"center"];
            userNameTap.text = @"";
        }else {
            
            NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
            [paraDic setObject:userNameTap.text forKey:@"username"];
            [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:kBusinessTagGetUpdateUserNameAgain owner:self];
            
        }
    }else if (textField == userName){
    
        if (userName.text.length < 3||userName.text.length > 16) {
            //[self.view makeToast:@"请输入6~8字符"];
            [self.view makeToast:@"请输入3~16字符" duration:1.0 position:@"center"];
            userName.text = @"";
        }else {
            
            NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
            [paraDic setObject:userName.text forKey:@"username"];
                [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:kBusinessTagGetUpdateUserName owner:self];
        
        }
    }else if (textField == phoneNumTap){
        if (phoneNumTap.text.length != 11) {
            
            [self.view makeToast:@"请输入正确手机号" duration:1.0 position:@"center"];
            phoneNumTap.text = @"";
            
        } else {
            //手机验证
            BOOL success = [self isMobileNumber:phoneNumTap.text];
            if (success) {
                
                NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
                [paraDic setObject:phoneNumTap.text forKey:@"mobile"];
                [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:kBusinessTagGetYzmobileAgain owner:self];
                
            }  else {
                [self.view makeToast:@"请输入正确手机号" duration:1.0 position:@"center"];
                phoneNumTap.text = @"";
                
            }
        }
        
    } else if (textField == phoneNum){
        if (phoneNum.text.length != 11) {
          
            [self.view makeToast:@"请输入正确手机号" duration:1.0 position:@"center"];
            phoneNum.text = @"";
            
        } else {
  //手机验证
            BOOL success = [self isMobileNumber:phoneNum.text];
            if (success) {
                
                NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
                [paraDic setObject:phoneNum.text forKey:@"mobile"];
                [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:kBusinessTagGetYzmobile owner:self];
                
            }  else {
            [self.view makeToast:@"请输入正确手机号" duration:1.0 position:@"center"];
             phoneNum.text = @"";
            
            }
        }
    
    } else if (textField == passNum){
        if (passNum.text.length == 18 || passNum.text.length == 15) {
            
            NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
            [paraDic setObject:passNum.text forKey:@"zjbh"];
            [paraDic setObject:@"0" forKey:@"zjlb"];
            [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:kBusinessTagGetYzzjbh owner:self];
           
        } else {
//证件验证
            [self.view makeToast:@"请输入正确身份证号" duration:1.0 position:@"center"];
            passNum.text = @"";
        }
        
    } else if (textField == passNumTap){
        if (passNumTap.text.length == 18 || passNumTap.text.length == 15) {
            
            NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
            [paraDic setObject:passNumTap.text forKey:@"zjbh"];
            [paraDic setObject:@"0" forKey:@"zjlb"];
            [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:kBusinessTagGetYzzjbhAgain owner:self];
            
        } else {
            //证件验证
            [self.view makeToast:@"请输入正确身份证号" duration:1.0 position:@"center"];
            passNumTap.text = @"";
        }
        
    }
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
   // foucsTextField = textField;
    scrollView.contentSize = CGSizeMake(320,600 +216);//原始滑动距离增加键盘高度
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
        scrollView.contentSize = CGSizeMake(ScreenWidth,600);
        //动画结束
        [UIView commitAnimations];
        
        
    }
    return YES;
}


-(void)push:(UIButton *)btn {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //[self.view endEditing:YES];
    [userName resignFirstResponder];
    [name resignFirstResponder];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

-(void)dealloc {
    [userName removeFromSuperview];
    userName =nil;
    [passWord removeFromSuperview];
    passWord =nil;
    [name removeFromSuperview];
    name =nil;
    [phoneNum removeFromSuperview];
    phoneNum =nil;
    [passNum removeFromSuperview];
    passNum =nil;
    [email removeFromSuperview];
    email =nil;
    [_check1 removeFromSuperview];
    _check1 =nil;
    [_check2 removeFromSuperview];
    _check2 =nil;
    rateStr1 = nil;
    rateStr2 = nil;
    [nameLabel removeFromSuperview];
    nameLabel =nil;
    [passNumLabel removeFromSuperview];
    passNumLabel =nil;
    [codeLabel removeFromSuperview];
    codeLabel =nil;
    [personLabel removeFromSuperview];
    personLabel =nil;
    [cede removeFromSuperview];
    cede =nil;
    [person removeFromSuperview];
    person =nil;
    
    [comfirmBtn removeFromSuperview];
    comfirmBtn =nil;
    [personBtn removeFromSuperview];
    personBtn =nil;
    [checkView removeFromSuperview];
    checkView =nil;
    [checkText removeFromSuperview];
    checkText =nil;
    
}


@end
