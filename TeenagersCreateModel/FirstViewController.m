//
//  FirstViewController.m
//  TeenagersCreateModel
//
//  Created by mac on 14-10-11.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "FirstViewController.h"
#import "ColorUtil.h"
#import "AppDelegate.h"
#import "ProjectIntroductionViewController.h"
#import "FirstPioneerViewController.h"
#import "IndividualCenterViewController.h"
#import "MyAccountViewController.h"
#import "AsyncImageView.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
#import "SGFocusImageFrame.h"
#import "SGFocusImageItem.h"
#import"DetailViewController.h"
#import "Customer.h"
#import "BankCardViewController.h"
#import "MyInvViewController.h"
#import "MyPrjViewController.h"


@interface FirstViewController ()
{
    NSString *start;
    NSString *limit;
    UIScrollView *scrollView;
    UIScrollView *backScrollView;
    NSMutableArray *slideImages;
    UIPageControl *pageControl;
    NSMutableArray *array;
    NSMutableArray *dataList;
    UIView *backView;
}

@end

@implementation FirstViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    //self.title = @"主  页";
        
    }
    return self;
}

-(void)loadView {
    [super loadView];
    UIView *baseView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    baseView.backgroundColor = [ColorUtil colorWithHexString:@"eeeeee"];
    self.view = baseView;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //[self performSelector:@selector(callFirstMethods:)];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
//过滤缓存
//    [[SDWebImageManager sharedManager] setCacheKeyFilter:^(NSURL *url)
//     {
//         url = [[NSURL alloc] initWithScheme:url.scheme host:url.host path:url.path];
//         return [url absoluteString];
//     }];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    start = @"1";
    limit = @"10";
    // 定时器 循环
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
    //获取AppDelegate
    self.appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
/*
    // 导航栏右边按钮的设置
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(ScreenWidth - 10 - 21, 12, 21, 21);
    [leftBtn setImage:[UIImage imageNamed:@"head_icon_back"] forState:UIControlStateNormal];
    //leftBtn.backgroundColor = [UIColor redColor];
    [leftBtn addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:leftBtn];
//    self.navigationItem.hidesBackButton = YES;
 */
    
    if ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    
    backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,  ScreenHeight - 49)];
    [backScrollView setContentSize:CGSizeMake(ScreenWidth, 550)];
    
    
    
    NSLog( @"%d",(int)ScreenHeight - 50);
    
   
    
    NSArray *arr = @[[UIImage imageNamed:@"account"],[UIImage imageNamed:@"bankcard"],[UIImage imageNamed:@"invest"],[UIImage imageNamed:@"program"]];
    NSArray *titleArr = @[@"开户",@"银行卡",@"我的投资",@"我的项目"];
    for (int i = 0; i < arr.count; i++) {
        
        UIView *icon = [[UIView alloc] initWithFrame:CGRectMake(16*(1 + i) + i*60, 279 + 15, 60, 60)];
        UIImageView *litter = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        litter.image = [arr objectAtIndex:i];
        [icon addSubview:litter];
        icon.layer.cornerRadius = icon.frame.size.width / 2;
        icon.clipsToBounds = YES;
        icon.layer.borderWidth = 3.0f;
        icon.layer.borderColor = [ColorUtil colorWithHexString:@"DCD8D3"].CGColor;
        icon.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callFirstMethods:)];
        icon.tag = i;
        //单点触摸
        singleTap.numberOfTouchesRequired = 1;
        //点击几次，如果是1就是单击
        singleTap.numberOfTapsRequired = 1;
        [icon addGestureRecognizer:singleTap];
        
        [backScrollView addSubview:icon];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(16*(1 + i) + i*60, 274 + 90, 60, 14)];
        lab.font = [UIFont boldSystemFontOfSize:14];
        lab.text = [titleArr objectAtIndex:i];
        lab.backgroundColor = [UIColor clearColor];
        lab.textColor = [ColorUtil colorWithHexString:@"252525"];
        lab.textAlignment = NSTextAlignmentCenter;
        [backScrollView addSubview:lab];
        
    }
 
    [self.view addSubview:backScrollView];
    //添加指示器及遮罩
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = YES; //加层阴影
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"加载中...";
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [self requestUpdateLinkMan];
        [self requestUpdateList];
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });

    
}

-(void)reloadView {

    
    
    backView = [[UIView alloc] initWithFrame:CGRectMake(0, 200 + 10, ScreenWidth, 75)];
    [backView setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5 , 80, 60)];
    imageView.tag =  100;
    //                [imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ICONSURL,[[[dataList objectAtIndex:indexPath.row] objectForKey:@"detail_url"] objectForKey:@"LOGO"]]]
    //                               placeholderImage:[UIImage imageNamed:@"xd1"]];
    [imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVERURL,[[[dataList objectAtIndex:0] objectForKey:@"detail_url"] objectForKey:@"LOGO"]]]
              placeholderImage:[UIImage imageNamed:@"xd1"]
                       success:^(UIImage *image) {
                           
                       }
                       failure:^(NSError *error) {
                           
                           UIImageView *imageView1 = (UIImageView *)[(UIImageView *)self.view viewWithTag:100];
                           [imageView1 setImage:[UIImage imageNamed:@"xd1"]];
                           
                       }];
    
    [backView addSubview:imageView];
    
    //品牌
    UILabel *brandLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 6, 220, 15)];
    brandLabel.font = [UIFont boldSystemFontOfSize:15];
    [brandLabel setTextColor:[ColorUtil colorWithHexString:@"1b1b1b"]];
    [brandLabel setBackgroundColor:[UIColor clearColor]];
    brandLabel.text = [[[dataList objectAtIndex:0] objectForKey:@"detail_url"] objectForKey:@"XMMC"];
    [backView addSubview:brandLabel];
    
    //行业
    UILabel *issuePriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 30, 100, 20)];
    issuePriceLabel.backgroundColor = [ColorUtil colorWithHexString:@"39b3d8"];
    issuePriceLabel.font = [UIFont boldSystemFontOfSize:14];
    [issuePriceLabel setTextColor:[UIColor whiteColor]];
    issuePriceLabel.textAlignment = NSTextAlignmentCenter;
    //[issuePriceLabel setBackgroundColor:[UIColor clearColor]];
    issuePriceLabel.text = [[dataList objectAtIndex:0] objectForKey:@"sshy"];
    [backView addSubview:issuePriceLabel];
    //地区
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 30, 80, 20)];
    dateLabel.backgroundColor = [ColorUtil colorWithHexString:@"2ade73"];
    dateLabel.font = [UIFont boldSystemFontOfSize:14];
    [dateLabel setTextColor:[UIColor whiteColor]];
    dateLabel.textAlignment = NSTextAlignmentCenter;
    //[dateLabel setBackgroundColor:[UIColor clearColor]];
    dateLabel.text = [[dataList objectAtIndex:0] objectForKey:@"szcs"];
    [backView addSubview:dateLabel];
    
    //项目亮点
    
    UILabel *codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 54, 220, 15)];
    codeLabel.font = [UIFont systemFontOfSize:10];
    //[codeLabel setTextColor:[ColorUtil colorWithHexString:@"1b1b1b"]];
    //[codeLabel setBackgroundColor:[UIColor lightGrayColor]];
    codeLabel.text = [[[dataList objectAtIndex:0] objectForKey:@"detail_url"] objectForKey:@"LD"];
    codeLabel.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:codeLabel];

   // UIView *hotView = [[UIView alloc] initWithFrame:CGRectMake(0, 200 + 5, ScreenWidth, 100)];
    //hotView.backgroundColor = [UIColor redColor];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callPhone:)];
    //单点触摸
    singleTap.numberOfTouchesRequired = 1;
    //点击几次，如果是1就是单击
    singleTap.numberOfTapsRequired = 1;
    [backView addGestureRecognizer:singleTap];
    
    [backScrollView addSubview:backView];
    
}

- (void)callPhone:(UITouch *)sender
{
    if (dataList.count) {
        
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.tagCountStr = @"5";
    if (delegate.array.count > 0) {
        Customer *custer = [delegate.array objectAtIndex:0];
        if (custer.loginSueccss) {
            DetailViewController *goodsDetailViewController = [[DetailViewController alloc] init];
            ;
            // goodsDetailViewController.title = [[[dataList objectAtIndex:indexPath.row] objectForKey:@"DETAIL"] objectForKey:@"XMMC"];
            goodsDetailViewController.titleName = [[[dataList objectAtIndex:0] objectForKey:@"detail_url"] objectForKey:@"XMMC"] ;
            if ([[dataList objectAtIndex:0] objectForKey:@"cpdm"] == [NSNull null]) {
                delegate.numStr = @"";
            } else {
                delegate.numStr = [[dataList objectAtIndex:0] objectForKey:@"cpdm"];
            }
            goodsDetailViewController.hidesBottomBarWhenPushed = YES;
           ;
            [self.navigationController pushViewController:goodsDetailViewController animated:NO];
        }else {
            // [self.view makeToast:@"请重新登陆"];
            LoginViewController *vc = [[LoginViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:NO];
            if ([[dataList objectAtIndex:0] objectForKey:@"cpdm"] == [NSNull null]) {
                delegate.numStr = @"";
            } else {
                delegate.numStr = [[dataList objectAtIndex:0] objectForKey:@"cpdm"];
            }

            
        }
    } else {
        
        LoginViewController *vc = [[LoginViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:NO];
       
        if ([[dataList objectAtIndex:0] objectForKey:@"cpdm"] == [NSNull null]) {
            delegate.numStr = @"";
        } else {
            delegate.numStr = [[dataList objectAtIndex:0] objectForKey:@"cpdm"];
        }
  
     }
    }else {
        
     [self requestUpdateList];
    
    }
}


-(void)callFirstMethods:(UIGestureRecognizer *)sender
{
    UIView *view = [sender view];
    
    if (view.tag == 0) {
        
        RegisterViewController *cv = [[RegisterViewController alloc] init];
        cv.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cv animated:NO];
        
    } else {
    
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (delegate.array.count > 0) {
    
    Customer *customer = [delegate.array objectAtIndex:0];
        if (customer.loginSueccss) {
              if (view.tag == 1){
                 
                BankCardViewController *cv = [[BankCardViewController alloc] init];
                cv.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:cv animated:NO];
            
            } else if (view.tag == 2){
             //delegate.tagCountStr = @"2";
                MyInvViewController *cv = [[MyInvViewController alloc] init];
                cv.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:cv animated:NO];
                
            }else if (view.tag == 3){
                
             //delegate.tagCountStr = @"3";
                MyPrjViewController *cv = [[MyPrjViewController alloc] init];
                cv.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:cv animated:NO];
                
            }
        } else {
            
           // [self.view makeToast:@"请先登陆" duration:1.0 position:@"center"];
            delegate.tagCountStr = [NSString stringWithFormat:@"%ld",view.tag];
            
            LoginViewController *cv = [[LoginViewController alloc] init];
            cv.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:cv animated:NO];
            
        }
        
    } else {
        
         delegate.tagCountStr = [NSString stringWithFormat:@"%ld",view.tag];
        
        LoginViewController *cv = [[LoginViewController alloc] init];
        cv.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cv animated:NO];
       //[self.view makeToast:@"请先登陆" duration:1.0 position:@"center"];
        
        
     }
    }
}


-(void)pushViewMethods:(UIButton *)btn {
    if (btn.tag == 2) {
       
        LoginViewController *cv = [[LoginViewController alloc] init];
        cv.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cv animated:NO];
    } else if (btn.tag == 1){
        
        //SecondViewController *cv = [[SecondViewController alloc] init];
        
        RegisterViewController *cv = [[RegisterViewController alloc] init];
        cv.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cv animated:NO];
    
    }
}


- (void)requestUpdateLinkMan
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"请求修改联系人");
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];

    [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:kBusinessTagGetBanner owner:self];
    
}

- (void)requestUpdateList
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"请求修改联系人");
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
    [paraDic setObject:start forKey:@"rowIndex"];
    [paraDic setObject:limit forKey:@"rowCount"];
    [paraDic setObject:@"2" forKey:@"type"];
    [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:kBusinessTagGetWYTZ owner:self];
    
}


    



#pragma mark - Recived Methods
//处理修改联系人
- (void)recivedUpdateLinkMan:(NSMutableArray *)dataArray
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"修改联系人");
    
    if ([slideImages count] > 0) {
        [slideImages removeAllObjects];
        for (NSDictionary *object in dataArray) {
            [slideImages addObject:object];
        }
    } else {
        slideImages = dataArray;
    }
    
     [MBProgressHUD hideHUDForView:self.view animated:YES];
 //保存数组的个数
    
    NSNumber *num = [NSNumber numberWithInteger:slideImages.count];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:num forKey:@"arrCount"];
    [userDefault synchronize];
    
    
    CGRect bound=CGRectMake(0, 0, ScreenWidth, 200);
    
    scrollView = [[UIScrollView alloc] initWithFrame:bound];
    scrollView.bounces = YES;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.userInteractionEnabled = YES;
 //隐藏水平滑动条
    scrollView.showsVerticalScrollIndicator = FALSE;
    scrollView.showsHorizontalScrollIndicator = FALSE;
    [scrollView flashScrollIndicators];
    [backScrollView addSubview:scrollView];
    
    
    // 初始化 pagecontrol
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0,180,ScreenWidth,10)]; // 初始化mypagecontrol
    [pageControl setCurrentPageIndicatorTintColor:[UIColor redColor]];
    [pageControl setPageIndicatorTintColor:[UIColor blackColor]];
    pageControl.numberOfPages = [slideImages count];
    pageControl.currentPage = 0;
    [pageControl addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged]; // 触摸mypagecontrol触发change这个方法事件
    [backScrollView addSubview:pageControl];
    array = [[NSMutableArray alloc] init];
    for (int i = 0; i < slideImages.count; i++) {
       UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth * i) + ScreenWidth, 0, ScreenWidth, 200)];
        [imageView1 setTag:i + 10000];
        [imageView1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVERURL,[[slideImages objectAtIndex:i] objectForKey:@"value"]]]
                       placeholderImage:[UIImage imageNamed:@"placeholder.png"]
        success:^(UIImage *image) {
            
            [[SDImageCache sharedImageCache] storeImage:image forKey:[NSString stringWithFormat:@"myCacheKey%d",i]];
            
            NSLog(@"%@",[NSString stringWithFormat:@"%@%@",SERVERURL,[[slideImages objectAtIndex:i] objectForKey:@"value"]]);
//一。图片存储到沙盒中
            /*
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
            NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"pic_%d.png", i]];   // 保存文件的名称
            [UIImagePNGRepresentation(image)writeToFile: filePath    atomically:YES];
            
            
            
//二。在plist中保存路径
            NSMutableDictionary *info = [[NSMutableDictionary alloc]init];
            [info setObject:filePath forKey:@"img"];
            //[info setObject:[NSString stringWithFormat:@"%ld",slideImages.count] forKey:@"count"];
           */
            
                                }
         
        failure:^(NSError *error) {
            
            UIImageView *icon = (UIImageView *)[(UIImageView *)self.view viewWithTag:i + 10000];
            icon.image = [UIImage imageNamed:@"xd1"];
            
                                          }];
        
        [scrollView addSubview:imageView1];
      
        
    }
    
    
    // 取数组最后一张图片 放在第0页
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    imgView.tag = 4 + 10000;
    [imgView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVERURL,[[slideImages objectAtIndex:slideImages.count - 1] objectForKey:@"value"]]]
               placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                        success:^(UIImage *image) {
 
                        }
     
                        failure:^(NSError *error) {

                            UIImageView *icon = (UIImageView *)[(UIImageView *)self.view viewWithTag:4 + 10000];
                            icon.image = [UIImage imageNamed:@"xd1"];
                            
                            
                        }];
    
    [scrollView addSubview:imgView];
    
    // 取数组第一张图片 放在最后1页
    
  UIImageView *imgViewl = [[UIImageView alloc] initWithFrame:CGRectMake((320 * ([slideImages count] + 1)) , 0, 320, 200)];
    imgViewl.tag = 5 + 10000;
    [imgViewl setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVERURL,[[slideImages objectAtIndex:0] objectForKey:@"value"]]]
            placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                     success:^(UIImage *image) {
                         
                     }
     
                     failure:^(NSError *error) {
                      
                         UIImageView *icon = (UIImageView *)[(UIImageView *)self.view viewWithTag:5 + 10000];
                         icon.image = [UIImage imageNamed:@"xd1"];
                         
                     }];
    
    // 添加第1页在最后 循环
    [scrollView addSubview:imgViewl];
    
    [scrollView setContentSize:CGSizeMake(320 * ([slideImages count] + 2), 200)]; //  +上第1页和第4页  原理：4-[1-2-3-4]-1
    [scrollView setContentOffset:CGPointMake(0, 0)];
    [scrollView scrollRectToVisible:CGRectMake(320,0,320,200) animated:NO]; // 默认从序号1位置放第1页 ，序号0位置位置放第4页
    
   
    
}

- (void)recivedCategoryList:(NSMutableArray *)dataArray
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"处理品牌列表数据");
    if ([dataList count] > 0) {
        for (NSDictionary *object in dataArray) {
            [dataList addObject:object];
        }
    } else {
        dataList = dataArray;
    }
       [MBProgressHUD hideHUDForView:self.view animated:YES];
      // [_slimeView endRefresh];
    if (backView) {
        [backView removeFromSuperview];
    }
    
    if (dataArray.count > 0) {
       [self reloadView];
        
    }
   
}


#pragma mark - NetworkModuleDelegate Methods
-(void)beginPost:(kBusinessTag)tag{
    
}
-(void)endPost:(NSString *)result business:(kBusinessTag)tag{
    NSLog(@"%s %d 收到数据:%@", __FUNCTION__, __LINE__, result);
    NSMutableDictionary *jsonDic = [result JSONValue];
    NSMutableArray *dataArray = [jsonDic objectForKey:@"object"];
	if (tag==kBusinessTagGetBanner ) {
       
        if ([[jsonDic objectForKey:@"success"] boolValue] == NO) {
            //数据异常处理
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.view makeToast:@"下载图片失败"];
            //            subing = NO;
        } else {
            [self recivedUpdateLinkMan:dataArray];
        }
    } else if (tag== kBusinessTagGetWYTZ){
        if ([[jsonDic objectForKey:@"success"] boolValue] == NO) {
            //数据异常处理
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.view makeToast:@"下载图片失败"];
            //            subing = NO;
        } else {
            [self recivedCategoryList:dataArray];
        }
    
    }
    
    [[NetworkModule sharedNetworkModule] cancel:tag];
}
-(void)errorPost:(NSError *)err business:(kBusinessTag)tag{
    NSLog(@"%s Error:%@", __FUNCTION__, @"连接数据服务器超时");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法连接" message:@"您所在地的网络信号微弱，无法连接到服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    if (tag==kBusinessTagGetBanner) {
     [MBProgressHUD hideHUDForView:self.view animated:YES];
    } else if (tag== kBusinessTagGetWYTZ){
       
            
            backView = [[UIView alloc] initWithFrame:CGRectMake(0, 200 + 10, ScreenWidth, 75)];
            
            UILabel *brandLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 6, 220, 15)];
            brandLabel.font = [UIFont boldSystemFontOfSize:15];
            [brandLabel setTextColor:[ColorUtil colorWithHexString:@"1b1b1b"]];
            [brandLabel setBackgroundColor:[UIColor clearColor]];
            brandLabel.text = @"无热门项目,请点击加载";
        backView.backgroundColor = [UIColor whiteColor];
            [backView addSubview:brandLabel];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callPhone:)];
        //单点触摸
        singleTap.numberOfTouchesRequired = 1;
        //点击几次，如果是1就是单击
        singleTap.numberOfTapsRequired = 1;
        [backView addGestureRecognizer:singleTap];
        
            [backScrollView addSubview:backView];
         [MBProgressHUD hideHUDForView:self.view animated:YES];

    }
    [[NetworkModule sharedNetworkModule] cancel:tag];
    
      if (slideImages.count == 0) {
        
          slideImages = [[NSMutableArray alloc] init];
          NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
          NSNumber *arr = [userDefault objectForKey:@"arrCount"];
          NSInteger count = [arr integerValue];
          if (count > 0) {
          
          for (int i = 0; i < count; i++) {
              UIImage *icon = [[SDImageCache sharedImageCache] imageFromKey:[NSString stringWithFormat:@"myCacheKey%d",i]];
              if (icon == nil) {
                  icon = [UIImage imageNamed:@"xd1"];
                [slideImages addObject:icon];
              } else {
              
              [slideImages addObject:icon];
          }
          }
                    
          CGRect bound=CGRectMake(0, 0, ScreenWidth, 200);
          
          scrollView = [[UIScrollView alloc] initWithFrame:bound];
              [scrollView setBackgroundColor:[UIColor grayColor]];
          scrollView.bounces = YES;
          scrollView.pagingEnabled = YES;
          scrollView.delegate = self;
          scrollView.userInteractionEnabled = YES;
          scrollView.showsVerticalScrollIndicator = FALSE;
          scrollView.showsHorizontalScrollIndicator = FALSE;
          [backScrollView addSubview:scrollView];
          
          // 初始化 pagecontrol
          pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0,180,ScreenWidth,10)]; // 初始化mypagecontrol
          [pageControl setCurrentPageIndicatorTintColor:[UIColor redColor]];
          [pageControl setPageIndicatorTintColor:[UIColor blackColor]];
          pageControl.numberOfPages = slideImages.count;
          pageControl.currentPage = 0;
          [pageControl addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged]; // 触摸mypagecontrol触发change这个方法事件
          [backScrollView addSubview:pageControl];
          
         
          for (int i = 0; i < slideImages.count; i++) {
              UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth * i) + ScreenWidth, 0, ScreenWidth, 200)];
              imageView1.image = [slideImages objectAtIndex:i];
                [scrollView addSubview:imageView1];
              
          }
          
          
          // 取数组最后一张图片 放在第0页
          
          UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
        // UIImageView *icon = [slideImages objectAtIndex:slideImages.count -1];
          imgView.image = [slideImages objectAtIndex:slideImages.count -1];
          [scrollView addSubview:imgView];
          
          // 取数组第一张图片 放在最后1页
          
          imgView = [[UIImageView alloc] initWithFrame:CGRectMake((320 * ([slideImages count] + 1)) , 0, 320, 200)];
          
         //icon = [slideImages objectAtIndex:0];
          imgView.image = [slideImages objectAtIndex:0];
          
          // 添加第1页在最后 循环
          [scrollView addSubview:imgView];
          
          [scrollView setContentSize:CGSizeMake(320 * ([slideImages count] + 2), 200)]; //  +上第1页和第4页  原理：4-[1-2-3-4]-1
          [scrollView setContentOffset:CGPointMake(0, 0)];
          [scrollView scrollRectToVisible:CGRectMake(320,0,320,200) animated:NO]; // 默认从序号1位置放第1页 ，序号0位置位置放第4页
          
          }
    }
}

#pragma mark -
- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame didSelectItem:(SGFocusImageItem *)item
{
    NSLog(@"%@ tapped", item.title);
}


// scrollview 委托函数
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pagewidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pagewidth/([slideImages count]+2))/pagewidth)+1;
    page --;  // 默认从第二页开始
    pageControl.currentPage = page;
}
// scrollview 委托函数
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollV
{
    CGFloat pagewidth = scrollView.frame.size.width;
    int currentPage = floor((scrollView.contentOffset.x - pagewidth/ ([slideImages count]+2)) / pagewidth) + 1;
    //    int currentPage_ = (int)self.scrollView.contentOffset.x/320; // 和上面两行效果一样
    //    NSLog(@"currentPage_==%d",currentPage_);
    if (currentPage==0)
    {
        [scrollView scrollRectToVisible:CGRectMake(320 * [slideImages count],0,320,200) animated:NO]; // 序号0 最后1页
    }
    else if (currentPage==([slideImages count]+1))
    {
        [scrollView scrollRectToVisible:CGRectMake(320,0,320,200) animated:NO]; // 最后+1,循环第1页
    }
}
// pagecontrol 选择器的方法
- (void)turnPage
{
    int page = (int)pageControl.currentPage; // 获取当前的page
    [scrollView scrollRectToVisible:CGRectMake(320*(page+1),0,320,200) animated:NO]; // 触摸pagecontroller那个点点 往后翻一页 +1
}
// 定时器 绑定的方法
- (void)runTimePage
{
    int page = (int)pageControl.currentPage; // 获取当前的page
    page++;
    page = page > (slideImages.count - 1) ? 0 : page ;
    pageControl.currentPage = page;
    [self turnPage];
}

#pragma mark - AsyncImageView Delegate Methods
- (void)succ:(AsyncImageView *)sender
{
    NSLog(@"****");
  //数据图片保存
   NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success = [fileManager createFileAtPath:[self dataFilePath] contents:nil attributes:nil];
    if (success) {
        NSLog(@"create success");
        
        array = [[NSMutableArray alloc] init];
        [array addObject:sender];
        [array writeToFile:[self dataFilePath] atomically:YES];
    }
    NSString *filePath = [self dataFilePath];
     if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
         [array addObject:sender];
         [array writeToFile:filePath atomically:YES];
     }
    
}

#pragma mark - 持久化保存数据方法

-(NSString *)dataFilePath {
    
    NSString *path = NSHomeDirectory();
     NSString *filePath = [path stringByAppendingPathComponent:@"data.plist"];
    return filePath;

}


- (void)fal:(NSError *)sender
{
    NSURL *url = [sender.userInfo objectForKey:@"NSLocalizedDescription"];
    int picCount = (int)[slideImages count];
    for (int i = 0; i < picCount; i ++) {
        if ([[slideImages objectAtIndex:i] isEqualToString:[url absoluteString]]) {
            AsyncImageView *imageView1 = (AsyncImageView *)[(AsyncImageView *)self.view viewWithTag:i + 10000];
            [imageView1 setImage:[UIImage imageNamed:@"xd1"]];
            
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
//模拟low-memory警告
    if ([self isViewLoaded] && self.view.window == nil) {
        self.view = nil;
    }
    //dataArray = nil;
    
}

-(void)dealloc {

    [scrollView removeFromSuperview];
    [pageControl removeFromSuperview];
    scrollView = nil;
    pageControl = nil;
    [array removeAllObjects];
    array = nil;
    [slideImages removeAllObjects];
    slideImages = nil;
    [backScrollView removeFromSuperview];
    backScrollView = nil;
    start = nil;
    limit = nil;
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

@end
