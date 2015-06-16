//
//  RegisterCreaterViewController.m
//  TeenagersCreateModel
//
//  Created by Yonghui Xiong on 14-11-27.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "RegisterCreaterViewController.h"
#import "AppDelegate.h"
#import "QCheckBox.h"

@interface RegisterCreaterViewController ()
{
    QCheckBox *_check1;
    QCheckBox *_check2;
    NSString *rateStr1;
    NSString *rateStr2;
    UIView *view1;
    UIView *view2;
//个人
    UIScrollView *scrollView;
    UITextField *userName;
    UITextField *passWord;
    UITextField *name;
    UITextField *phoneNum;
    UITextField *passNum;
    UITextField *email;
    UITextField *fund;
    UITextField *company;
    UITextField *position;
    UITextField *photoID;
    UITextField *assetDocuments;
    UITextField *card;
    UIButton *personBtn;
//机构
    UIScrollView *scrollViewMore;
    
}
@end

@implementation RegisterCreaterViewController

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
    navibarItem.title = @"注册投资人";
    navibarItem.leftBarButtonItem= leftItem;
    // self.navigationItem.rightBarButtonItem = leftItem;
    [navibar pushNavigationItem:navibarItem animated:YES];
    [self.view addSubview:navibar];
    
//基本信息
    UILabel *base_infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10 + 64, 200, 16)];
    base_infoLabel.font = [UIFont boldSystemFontOfSize:16];
    base_infoLabel.text = @"基本信息";
    [self.view addSubview:base_infoLabel];
 //
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 39 + 60, 320, 1)];
    [subView setBackgroundColor:[ColorUtil colorWithHexString:@"dcdcdc"]];
    [self.view addSubview:subView];
//类别
    UILabel *classLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 122, 80, 14)];
    classLabel.text = @"类别:";
    classLabel.textAlignment = NSTextAlignmentRight;
    classLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:classLabel];
    
//按钮
    _check1 = [[QCheckBox alloc] initWithDelegate:self];
    _check1.frame = CGRectMake(105, 119,100,22);
    [_check1 setTitle:@"创业项目" forState:UIControlStateNormal];
    [_check1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _check1.tag = 1;
    [_check1.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [_check1 setChecked:YES];
    [self.view addSubview:_check1];
    
    _check2 = [[QCheckBox alloc] initWithDelegate:self];
    _check2.frame = CGRectMake(210,119,100,22);
    [_check2 setTitle:@"创业企业" forState:UIControlStateNormal];
    _check2.tag = 2;
    [_check2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_check2.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [self.view addSubview:_check2];
    
    view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 150, 320, ScreenHeight - 150)];
    view1.backgroundColor = [ColorUtil colorWithHexString:@"eeeeee"];
    //加入滑动视图
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, view1.frame.size.height)];
    //scrollView.backgroundColor = [UIColor grayColor];
    [scrollView setContentSize:CGSizeMake(ScreenWidth, 700)];
    [view1 addSubview:scrollView];
    
    [self.view addSubview:view1];
    
    view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 150, 320, ScreenHeight - 150)];
    view2.backgroundColor = [ColorUtil colorWithHexString:@"eeeeee"];
    view2.hidden = YES;
    [self.view addSubview:view2];
    
    [self reloadDataView];
}

-(void)reloadDataView {
    
    NSArray *arr = @[@"用户名:",@"密  码:",@"姓   名:",@"身份证号码:",@"手  机:",@"邮  箱:",@"个人信息",@"资  产:",@"公  司:",@"职  位:",@"身份证照片:",@"资产证明文件:",@"名  片:"];
    for (int i = 0; i < arr.count ; i++) {
        if (i == 6) {
            UILabel *baseLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40*i, 80, 40)];
            baseLabel.font = [UIFont boldSystemFontOfSize:16];
            baseLabel.text = [arr objectAtIndex:6];
            [scrollView addSubview:baseLabel];
            UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 40*i + 39, 320, 1)];
            [subView setBackgroundColor:[ColorUtil colorWithHexString:@"dcdcdc"]];
            [scrollView addSubview:subView];
            
        } else if (i > 6){
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 40*i + 20, 80, 40)];
            label.textAlignment = NSTextAlignmentRight;
            label.font = [UIFont systemFontOfSize:15];
            label.numberOfLines = 0;
            label.text = [arr objectAtIndex:i];
            [scrollView addSubview:label];
        } else {
            
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 40*i, 80, 40)];
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:15];
        label.numberOfLines = 0;
        label.text = [arr objectAtIndex:i];
        [scrollView addSubview:label];
        }
    }
    
    
    //用户名
    userName = [[UITextField alloc] initWithFrame:CGRectMake(100, 5, 200, 30)];
    userName.borderStyle = UITextBorderStyleLine;
    userName.clearButtonMode = UITextFieldViewModeWhileEditing;
    userName.delegate = self;
    userName.placeholder = @"请填写用户名";
    //@"字母开头，4~16位字符，可包含英文字母，数字、\"_\""
    userName.font = [UIFont systemFontOfSize:12];
    [scrollView addSubview:userName];
    //密码
    passWord= [[UITextField alloc] initWithFrame:CGRectMake(100, 45, 200, 30)];
    passWord.borderStyle = UITextBorderStyleLine;
    passWord.clearButtonMode = UITextFieldViewModeWhileEditing;
    passWord.secureTextEntry = YES;
    passWord.delegate = self;
    passWord.placeholder = @"请输入密码";
    passWord.font = [UIFont systemFontOfSize:12];
    [scrollView addSubview:passWord];
    
    //手机
    
    passNum = [[UITextField alloc] initWithFrame:CGRectMake(100, 85, 200, 30)];
    passNum.borderStyle = UITextBorderStyleLine;
    passNum.clearButtonMode = UITextFieldViewModeWhileEditing;
    passNum.delegate = self;
    passNum.placeholder = @"请填写有效掌控的手机号码";
    passNum.font = [UIFont systemFontOfSize:12];
    [scrollView addSubview:passNum];
    //邮箱
    email = [[UITextField alloc] initWithFrame:CGRectMake(100, 125, 200, 30)];
    email.borderStyle = UITextBorderStyleLine;
    email.clearButtonMode = UITextFieldViewModeWhileEditing;
    email.delegate = self;
    email.placeholder = @"请输入常用的邮箱";
    email.font = [UIFont systemFontOfSize:12];
    [scrollView addSubview:email];
    // 姓名
    name= [[UITextField alloc] initWithFrame:CGRectMake(100, 165, 150, 30)];
    name.borderStyle = UITextBorderStyleLine;
    name.clearButtonMode = UITextFieldViewModeWhileEditing;
    name.delegate = self;
    name.placeholder = @"请输入姓名";
    name.font = [UIFont systemFontOfSize:12];
    [scrollView addSubview:name];
    
    UIButton *testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    testBtn.frame = CGRectMake(260, 165, 50, 30);
    testBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [testBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    testBtn.backgroundColor = [UIColor grayColor];
    [testBtn setTitle:@"短信验证" forState:UIControlStateNormal];
    [scrollView addSubview:testBtn];
    
    
    //身份证号码
    phoneNum = [[UITextField alloc] initWithFrame:CGRectMake(100, 205 , 200, 30)];
    phoneNum.borderStyle = UITextBorderStyleLine;
    phoneNum.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneNum.delegate = self;
    phoneNum.placeholder = @"请输入身份证号";
    phoneNum.font = [UIFont systemFontOfSize:12];
    [scrollView addSubview:phoneNum];
    
//资产
    fund = [[UITextField alloc] initWithFrame:CGRectMake(100, 305 , 200, 30)];
    fund.borderStyle = UITextBorderStyleLine;
    fund.clearButtonMode = UITextFieldViewModeWhileEditing;
    fund.delegate = self;
    fund.placeholder = @"请输入资产";
    fund.font = [UIFont systemFontOfSize:12];
    [scrollView addSubview:fund];
//公司
    company= [[UITextField alloc] initWithFrame:CGRectMake(100, 345 , 200, 30)];
    company.borderStyle = UITextBorderStyleLine;
    company.clearButtonMode = UITextFieldViewModeWhileEditing;
    company.delegate = self;
    company.placeholder = @"请输入公司";
    company.font = [UIFont systemFontOfSize:12];
    [scrollView addSubview:company];
//职位
    position= [[UITextField alloc] initWithFrame:CGRectMake(100, 385 , 200, 30)];
    position.borderStyle = UITextBorderStyleLine;
    position.clearButtonMode = UITextFieldViewModeWhileEditing;
    position.delegate = self;
    position.placeholder = @"请输入职位";
    position.font = [UIFont systemFontOfSize:12];
    [scrollView addSubview:position];
//身份证照片
    photoID= [[UITextField alloc] initWithFrame:CGRectMake(100, 425 , 200, 30)];
    photoID.borderStyle = UITextBorderStyleLine;
    photoID.clearButtonMode = UITextFieldViewModeWhileEditing;
    photoID.delegate = self;
    photoID.placeholder = @"请上传身份证照片";
    photoID.font = [UIFont systemFontOfSize:12];
    [scrollView addSubview:photoID];
//资产证明文件
    assetDocuments = [[UITextField alloc] initWithFrame:CGRectMake(100, 465 , 200, 30)];
    assetDocuments.borderStyle = UITextBorderStyleLine;
    assetDocuments.clearButtonMode = UITextFieldViewModeWhileEditing;
    assetDocuments.delegate = self;
    assetDocuments.placeholder = @"请加入资产证明文件";
    assetDocuments.font = [UIFont systemFontOfSize:12];
    [scrollView addSubview:assetDocuments];
 //名片
    card= [[UITextField alloc] initWithFrame:CGRectMake(100, 505 , 200, 30)];
    card.borderStyle = UITextBorderStyleLine;
    card.clearButtonMode = UITextFieldViewModeWhileEditing;
    card.delegate = self;
    card.placeholder = @"请加入名片";
    card.font = [UIFont systemFontOfSize:12];
    [scrollView addSubview:card];
    
    
    personBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    personBtn.frame = CGRectMake(50, 575, 220, 40);
    personBtn.tag = 111111;
    personBtn.backgroundColor = [UIColor blueColor];
    [personBtn setTitle:@"注册" forState:UIControlStateNormal];
    [personBtn addTarget:self action:@selector(comfirmBtnMethods:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:personBtn];
    

    /*
    
    comfirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    comfirmBtn.frame = CGRectMake(50, 440, 220, 40);
    comfirmBtn.backgroundColor = [UIColor blueColor];
    comfirmBtn.tag = 111112;
    comfirmBtn.hidden = YES;
    [comfirmBtn setTitle:@"注册" forState:UIControlStateNormal];
    [comfirmBtn addTarget:self action:@selector(comfirmBtnMethods:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:comfirmBtn];
    
   
    
    */
    
    
    [scrollView setContentSize:CGSizeMake(ScreenWidth, 650)];
}

-(void)comfirmBtnMethods:(UIButton *)btn {

    
    
    
    
    

}

- (void)textFieldDidEndEditing:(UITextField *)textField{


}



- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    // foucsTextField = textField;
    scrollView.contentSize = CGSizeMake(320,650 +216);//原始滑动距离增加键盘高度
    CGPoint pt = [textField convertPoint:CGPointMake(0, 0) toView:scrollView];//把当前的textField的坐标映射到scrollview上
    if(scrollView.contentOffset.y-pt.y+150<=0)//判断最上面不要去滚动
        [scrollView setContentOffset:CGPointMake(0, pt.y-150) animated:YES];//华东
    
    
}


- (BOOL)textFieldShouldReturn:(UITextField*)theTextField
{
    {
        [theTextField resignFirstResponder];
        
        //开始动画
        [UIView beginAnimations:nil context:nil];
        //设定动画持续时间
        [UIView setAnimationDuration:0.3];
        scrollView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 150);
        scrollView.contentSize = CGSizeMake(ScreenWidth,650);
        //动画结束
        [UIView commitAnimations];
        
        
    }
    return YES;
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
            rateStr2 = @"";
            view2.hidden = YES;
            view1.hidden = NO;
        } else if (checkbox.tag == 2) {
            rateStr1 = @"";
            rateStr2 = @"1";
            view2.hidden = NO;
            view1.hidden = YES;
        }
    }
    
    NSLog(@"%@--676767--%@",rateStr1,rateStr2);
}




-(void)push:(UIButton *)btn {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}



@end
