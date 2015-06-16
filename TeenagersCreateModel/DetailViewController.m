//
//  DetailViewController.m
//  TeenagersCreateModel
//
//  Created by mac on 14-10-16.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "Customer.h"
#import "IWFollowViewController.h"
#import "IWLeaderViewController.h"

@interface DetailViewController ()
{
   
    float scrollViewHight;
    NSMutableArray *dataList;
    BOOL hasMore;
    UIView *view1;
    UIView *view2;
    UIView *view3;
    UISegmentedControl *segmentedControl;
    UIWebView *_webView2;
    UIWebView *_webView3;
   UIScrollView *scrollView;
}

@end

@implementation DetailViewController
@synthesize titleName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.hidesBackButton = YES;
        }
    return self;
}

-(void)loadView {
    [super loadView];
    UIView *baseView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    baseView.backgroundColor = [ColorUtil colorWithHexString:@"eeeeee"];
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
    
    self.navigationController.navigationBarHidden = YES;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
#endif
    
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, 44)];
    //navBar.backgroundColor = [UIColor redColor];
    [navBar setBackgroundImage:[UIImage imageNamed:@"title_bg"]  forBarMetrics:UIBarMetricsDefault];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
        navBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"title_bg"]];
        
    } else {
        navBar.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"title_bg"]];
    }
    
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 12, 40, 20);
    [leftBtn setImage:[UIImage imageNamed:@"return_ico"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    UINavigationItem *navibarItem = [[UINavigationItem alloc]init];
   // navibarItem.title = titleName;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 15, ScreenWidth - 70, 14)];
    nameLabel.text = titleName;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.font = [UIFont boldSystemFontOfSize:16];
    
    
    
    [navBar addSubview:nameLabel];
    // navibarItem.title = @"%@的派送单信息";
    navibarItem.leftBarButtonItem = leftItem;
    [navBar pushNavigationItem:navibarItem animated:YES];
    
    [self.view addSubview:navBar];
    
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"基本信息",@"团队信息",@"其他信息",nil];
    segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    
    segmentedControl.frame = CGRectMake(20, 69, ScreenWidth - 40, 40);
    
    segmentedControl.selectedSegmentIndex = 0;//设置默认选择项索引
    
    segmentedControl.tintColor = [UIColor blueColor];
    
    segmentedControl.multipleTouchEnabled = NO;
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBezeled;
    
    [segmentedControl addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];
    
    view1 = [[UIView alloc] initWithFrame:CGRectMake(0, segmentedControl.frame.origin.y + segmentedControl.frame.size.height + 5, ScreenWidth, ScreenHeight - segmentedControl.frame.origin.y - segmentedControl.frame.size.height )];
    //view1.backgroundColor = [UIColor redColor];
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFromView:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [view1 addGestureRecognizer:recognizer];
    [self.view addSubview:view1];
    
    view2 = [[UIView alloc] initWithFrame:CGRectMake(0, segmentedControl.frame.origin.y + segmentedControl.frame.size.height + 5, ScreenWidth, ScreenHeight - segmentedControl.frame.origin.y - segmentedControl.frame.size.height)];
    view2.backgroundColor = [UIColor blackColor];
    view2.hidden = YES;
    
    UISwipeGestureRecognizer *recognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFromView1:)];
    UISwipeGestureRecognizer *recognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFromView1:)];
    [recognizerRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [recognizerLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    
    [view2 addGestureRecognizer:recognizerLeft];
    [view2 addGestureRecognizer:recognizerRight];
    [self.view addSubview:view2];
    
    
    view3 = [[UIView alloc] initWithFrame:CGRectMake(0, segmentedControl.frame.origin.y + segmentedControl.frame.size.height + 5, ScreenWidth, ScreenHeight - segmentedControl.frame.origin.y - segmentedControl.frame.size.height)];
    //view3.backgroundColor = [UIColor brownColor];
    view3.hidden = YES;
    
    UISwipeGestureRecognizer *recognizer3 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFromView2:)];
    [recognizer3 setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [view3 addGestureRecognizer:recognizer3];
    
    [self.view addSubview:view3];
    [self.view addSubview:segmentedControl];
    
    [self reloadWebView];
}



-(void)reloadWebView {
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

   
    
    //添加指示器及遮罩
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = YES; //加层阴影
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"加载中...";
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [self requestCategoryList:kBusinessTagGetProjectDetail];
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });
    
    
    _webView2 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, view2.frame.size.height)];
    _webView2.delegate = self;
    //_webView.scalesPageToFit = YES;
    _webView2.backgroundColor = [UIColor grayColor];
    [view2 addSubview:_webView2];
    
    NSURL *url1 = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@/2",SERVERDETAIL2,delegate.numStr]];
    NSMutableURLRequest *request1 = [NSMutableURLRequest requestWithURL:url1];
    
    Customer *customer = [delegate.array objectAtIndex:0];
        NSString *cookieString = [NSString stringWithFormat:@"JSESSIONID=%@", customer.session_Id];
        
        [request1 setValue:cookieString forHTTPHeaderField:@"Cookie"];
        
        NSLog(@"inserted cookie into request: %@", customer.session_Id);
   
    
    [_webView2 loadRequest:request1];
    
    
    
    _webView3 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, view3.frame.size.height)];
    _webView3.delegate = self;
    //_webView.scalesPageToFit = YES;
    _webView3.backgroundColor = [UIColor grayColor];
    [view3 addSubview:_webView3];
    
    
    NSURL *url2 = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@/3",SERVERDETAIL3,delegate.numStr]];
    NSMutableURLRequest *request2 = [NSMutableURLRequest requestWithURL:url2];
     [request2 setValue:cookieString forHTTPHeaderField:@"Cookie"];
    [_webView3 loadRequest:request2];
   

}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];//自己添加的，原文没有提到。
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];//自己添加的，原文没有提到。
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}




/*
#pragma mark webview每次加载之前都会调用这个方法
// 如果返回NO，代表不允许加载这个请求
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    // 说明协议头是ios
    if ([@"ios" isEqualToString:request.URL.scheme]) {
        NSString *url = request.URL.absoluteString;
        NSRange range = [url rangeOfString:@":"];
        NSString *method = [request.URL.absoluteString substringFromIndex:range.location + 1];
        
        SEL selector = NSSelectorFromString(method);
        
        if ([self respondsToSelector:selector]) {
            [self performSelector:selector];
        }
        
        return NO;
    }
    
    return YES;
}

*/


-(void) segmentAction:(UISegmentedControl *)Seg{
    
    NSInteger Index = Seg.selectedSegmentIndex;
    NSLog(@"Index %li",(long)Index);
    if (Seg.selectedSegmentIndex == 0) {
        view2.hidden = YES;
        view1.hidden = NO;
        view3.hidden = YES;
    } else if (Seg.selectedSegmentIndex == 1){
        view1.hidden = YES;
        view2.hidden = NO;
        view3.hidden = YES;
        
    }else if (Seg.selectedSegmentIndex == 2){
        view3.hidden = NO;
        view1.hidden = YES;
        view2.hidden = YES;
        
    }
}

-(void)handleSwipeFromView:(UISwipeGestureRecognizer *)sender{
    if (sender.direction==UISwipeGestureRecognizerDirectionRight)
    {
        segmentedControl.selectedSegmentIndex = 1;
        view1.hidden = YES;
        view2.hidden = NO;
        view3.hidden = YES;
    }
}


-(void)handleSwipeFromView1:(UISwipeGestureRecognizer *)sender{
    if (sender.direction==UISwipeGestureRecognizerDirectionRight )
    {
        //segmentedControl.multipleTouchEnabled=NO;
        segmentedControl.selectedSegmentIndex = 2;
        view2.hidden = YES;
        view3.hidden = NO;
        view1.hidden = YES;
    }else if(sender.direction==UISwipeGestureRecognizerDirectionLeft) {
        segmentedControl.selectedSegmentIndex = 0;
        view2.hidden = YES;
        view1.hidden = NO;
        view3.hidden = YES;
    }
}


-(void)handleSwipeFromView2:(UISwipeGestureRecognizer *)sender{
    if (sender.direction==UISwipeGestureRecognizerDirectionLeft )
    {
        segmentedControl.selectedSegmentIndex = 1;
        view3.hidden = YES;
        view2.hidden = NO;
        view1.hidden = YES;
    }
}




- (void)requestCategoryList:(kBusinessTag)_tag
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"请求品牌列表");
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
    
    [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:_tag owner:self];
    
}



#pragma mark - Recived Methods
//处理修改联系人
- (void)recivedUpdateLinkMan:(NSMutableDictionary *)dataArray
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"修改联系人");
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, view1.frame.size.height)];
    [scrollView setContentSize:CGSizeMake(ScreenWidth, 10000)];
    
    //图片设置
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5 , ScreenWidth - 10, 150)];
    imageView.tag = 10000000;
    
    [imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVERURL,[[dataArray objectForKey:@"DETAIL_MAP"] objectForKey:@"LOGO"]]]
                   placeholderImage:[UIImage imageNamed:@"xd1"]
                            success:^(UIImage *image) {
                            }
                            failure:^(NSError *error) {
                                UIImageView *imageView1 = (UIImageView *)[(UIImageView *)self.view viewWithTag:10000000];
                                [imageView1 setImage:[UIImage imageNamed:@"xd1"]];
                                
                            }];
    
        [scrollView addSubview:imageView];
    
    //项目亮点
    UILabel *flashLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 170, 200, 16)];
    flashLabel.text = @"项目亮点:";
    flashLabel.font = [UIFont boldSystemFontOfSize:16];
    [scrollView addSubview:flashLabel];
    
    
    
    
    SHLUILabel *descPriceLabel = [[SHLUILabel alloc] init];
    descPriceLabel.text = [[dataArray objectForKey:@"DETAIL_MAP"] objectForKey:@"LD"];
    //使用自定义字体
    descPriceLabel.font = [UIFont boldSystemFontOfSize:13];    //设置字体颜色
    //descPriceLabel.textColor = [ColorUtil colorWithHexString:@"1b1b1b"];
    descPriceLabel.textColor = [UIColor blackColor];
    descPriceLabel.lineBreakMode = NSLineBreakByWordWrapping;
    descPriceLabel.linesSpacing = 2.0f;
    //0:6 1:7 2:8 3:9 4:10
    //linesSpacing_
    descPriceLabel.numberOfLines = 0;
    //根据字符串长度和Label显示的宽度计算出contentLab的高
    int descHeight = [descPriceLabel getAttributedStringHeightWidthValue:ScreenWidth - 40];
    NSLog(@"SHLLabel height:%d", descHeight);
    descPriceLabel.frame = CGRectMake(20.f, flashLabel.frame.origin.y + flashLabel.frame.size.height + 10, ScreenWidth - 40, descHeight);
    NSLog(@"%d",descHeight - 32);
    
    [scrollView addSubview:descPriceLabel];
    
    
    //项目描述
    
    UILabel *project_info = [[UILabel alloc] initWithFrame:CGRectMake(5, flashLabel.frame.origin.y + flashLabel.frame.size.height + 20 + descHeight, 200, 16)];
    project_info.text = @"项目简介:";
    project_info.font = [UIFont boldSystemFontOfSize:16];
    [scrollView addSubview:project_info];
    
    
    SHLUILabel *issuePriceLabel = [[SHLUILabel alloc] init];
    issuePriceLabel.text = [[dataArray objectForKey:@"DETAIL_MAP"] objectForKey:@"XMJS"];
    //使用自定义字体
    issuePriceLabel.font = [UIFont systemFontOfSize:13];    //设置字体颜色
    issuePriceLabel.textColor = [ColorUtil colorWithHexString:@"1b1b1b"];
    issuePriceLabel.lineBreakMode = NSLineBreakByWordWrapping;
    issuePriceLabel.linesSpacing = 2.0f;
    //0:6 1:7 2:8 3:9 4:10
    //linesSpacing_
    issuePriceLabel.numberOfLines = 0;
    //根据字符串长度和Label显示的宽度计算出contentLab的高
    int labelHeight = [issuePriceLabel getAttributedStringHeightWidthValue:ScreenWidth - 40];
    NSLog(@"SHLLabel height:%d", labelHeight);
    issuePriceLabel.frame = CGRectMake(20.f,project_info.frame.origin.y + project_info.frame.size.height + 10, ScreenWidth - 40, labelHeight);
    NSLog(@"%d",labelHeight - 32);
    
    [scrollView addSubview:issuePriceLabel];
    
   
    
    
    //项目描述
    /*
    SHLUILabel *issuePriceLabel1 = [[SHLUILabel alloc] init];
    issuePriceLabel1.text = @"xd";
    //使用自定义字体
    issuePriceLabel1.font = [UIFont systemFontOfSize:13];    //设置字体颜色
    issuePriceLabel1.textColor = [ColorUtil colorWithHexString:@"1b1b1b"];
    issuePriceLabel1.lineBreakMode = NSLineBreakByWordWrapping;
    issuePriceLabel1.linesSpacing = 0.0f;
    //0:6 1:7 2:8 3:9 4:10
    //linesSpacing_
    issuePriceLabel1.numberOfLines = 0;
    //根据字符串长度和Label显示的宽度计算出contentLab的高
    int labelHeight1 = [issuePriceLabel1 getAttributedStringHeightWidthValue:ScreenWidth - 40];
    NSLog(@"SHLLabel height:%d", labelHeight1);
    issuePriceLabel1.frame = CGRectMake(20.f,issuePriceLabel.frame.origin.y + issuePriceLabel.frame.size.height + 20 + descHeight, ScreenWidth - 40, labelHeight1);
    NSLog(@"%d",labelHeight - 32);
    
    [scrollView addSubview:issuePriceLabel1];
    */
    
   //我要领投
     UIButton *leaderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leaderBtn.frame = CGRectMake(20.f,project_info.frame.origin.y + project_info.frame.size.height + 60 + labelHeight, ScreenWidth - 40, 50);
    leaderBtn.tag = 200001;
    leaderBtn.backgroundColor = [ColorUtil colorWithHexString:@"37B3D9"];
    [leaderBtn setTitle:@"我要领投" forState:UIControlStateNormal];
    [leaderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leaderBtn addTarget:self action:@selector(followAndLeaderMethods:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:leaderBtn];
    
    //我要跟投
     UIButton *followBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    followBtn.frame = CGRectMake(20.f,project_info.frame.origin.y + project_info.frame.size.height + 130 + labelHeight, ScreenWidth - 40, 50);
    followBtn.tag = 200002;
    followBtn.backgroundColor = [ColorUtil colorWithHexString:@"37B3D9"];
    [followBtn setTitle:@"我要跟投" forState:UIControlStateNormal];
    [followBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [followBtn addTarget:self action:@selector(followAndLeaderMethods:) forControlEvents:UIControlEventTouchUpInside];
     [scrollView addSubview:followBtn];
    
    
    [scrollView setContentSize:CGSizeMake(ScreenWidth, issuePriceLabel.frame.origin.y + issuePriceLabel.frame.size.height + 90 + 20 + descHeight + labelHeight)];
    // [scrollView setContentSize:CGSizeMake(ScreenWidth,descPriceLabel.frame.origin.y + descPriceLabel.frame.size.height + 10)];
    //NSLog(@"yyyyyyyy%ld",(NSInteger)ScreenHeight);
    //NSLog(@"ffffff%ld",(NSInteger)(descPriceLabel.frame.origin.y + descPriceLabel.frame.size.height + 30));
    
    [view1 addSubview:scrollView];
    
  [MBProgressHUD hideHUDForView:self.view animated:YES];
}



-(void)followAndLeaderMethods:(UIButton *)btn{

    if (btn.tag == 200001) {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        Customer *customer = [delegate.array objectAtIndex:0];
        if (customer.isLTR) {
            
        IWLeaderViewController *cv = [[IWLeaderViewController alloc] init];
            cv.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:cv animated:NO];
            
            
            
        } else {
        
            [self.view makeToast:@"您还不是领头人，请先成为领头人！"];
        
        
        }
        
        
    } else if (btn.tag == 200002){
        
        IWFollowViewController *cv = [[IWFollowViewController alloc] init];
        cv.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cv animated:NO];
    
    
    }


}



#pragma mark - NetworkModuleDelegate Methods
-(void)beginPost:(kBusinessTag)tag{
    
}
-(void)endPost:(NSString *)result business:(kBusinessTag)tag{
    NSLog(@"%s %d 收到数据:%@", __FUNCTION__, __LINE__, result);
    NSMutableDictionary *jsonDic = [result JSONValue];
    NSMutableDictionary *dataArray = [jsonDic objectForKey:@"object"];
	if (tag==kBusinessTagGetProjectDetail ) {
        if ([[jsonDic objectForKey:@"success"] boolValue] == NO) {
            //数据异常处理
             [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.view makeToast:@"数据异常处理"];
            //            subing = NO;
        } else {
           
            [self recivedUpdateLinkMan:dataArray];
        }
    }
    [[NetworkModule sharedNetworkModule] cancel:tag];
}
-(void)errorPost:(NSError *)err business:(kBusinessTag)tag{
    NSLog(@"%s Error:%@", __FUNCTION__, @"连接数据服务器超时");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法连接" message:@"您所在地的网络信号微弱，无法连接到服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    if (tag==kBusinessTagGetProjectDetail) {
       [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    [[NetworkModule sharedNetworkModule] cancel:tag];
}





-(void) push:(UIButton *)btn{
    
    _webView2.delegate = nil;
    [_webView2 loadHTMLString:@"" baseURL:nil];
    [_webView2 stopLoading];
    [_webView2 removeFromSuperview];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    _webView2 = nil;
    
    _webView3.delegate = nil;
    [_webView3 loadHTMLString:@"" baseURL:nil];
    [_webView3 stopLoading];
    [_webView3 removeFromSuperview];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    _webView3 = nil;
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

-(void)dealloc {
    [scrollView removeFromSuperview];
    scrollView = nil;

    titleName = nil;
   dataList = nil;
    
    [view1 removeFromSuperview];
    view1 = nil;
    [view2 removeFromSuperview];
    view2 = nil;
    [view3 removeFromSuperview];
    view3 = nil;
    [segmentedControl removeFromSuperview];
    segmentedControl = nil;
    
    _webView2.delegate = nil;
    [_webView2 loadHTMLString:@"" baseURL:nil];
    [_webView2 stopLoading];
    [_webView2 removeFromSuperview];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    _webView2 = nil;
    
    _webView3.delegate = nil;
    [_webView3 loadHTMLString:@"" baseURL:nil];
    [_webView3 stopLoading];
    [_webView3 removeFromSuperview];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    _webView3 = nil;
  [[NSURLCache sharedURLCache] removeAllCachedResponses];
}



@end
