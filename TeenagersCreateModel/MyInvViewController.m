//
//  MyInvViewController.m
//  TeenagersCreateModel
//
//  Created by Yonghui Xiong on 14-11-5.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "MyInvViewController.h"
#import "AppDelegate.h"
#import "DetailInvViewController.h"

@interface MyInvViewController ()
{
    UITableView *tableView;
    NSString *start;
    NSString *startBak;
    NSString *limit;
    NSMutableArray *dataList;
    NSMutableArray *dataStatus;
    BOOL hasMore;
    UITableViewCell *moreCell;
    UILabel *totalLabel;
    
}
@end

@implementation MyInvViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
         self.navigationController.navigationBarHidden = YES;
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
    start = @"1";
    limit = @"10";
    
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
    navibarItem.title = @"我的投资";
    navibarItem.leftBarButtonItem= leftItem;
    // self.navigationItem.rightBarButtonItem = leftItem;
    [navibar pushNavigationItem:navibarItem animated:YES];
    [self.view addSubview:navibar];
    
   
    UILabel *invLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, 100, 40)];
    invLabel.text = @"投资总金额:";
    invLabel.backgroundColor = [UIColor whiteColor];
    invLabel.textColor = [ColorUtil colorWithHexString:@"3E3E3E"];
    invLabel.textAlignment = NSTextAlignmentRight;
    invLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:invLabel];
    
    totalLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 64, ScreenWidth - 100, 40)];
    totalLabel.textColor = [ColorUtil colorWithHexString:@"db0a0f"];
    totalLabel.backgroundColor = [UIColor whiteColor];
    totalLabel.textAlignment = NSTextAlignmentRight;
    totalLabel.font = [UIFont systemFontOfSize:14];
    totalLabel.text = @"￥:0.00";
    [self.view addSubview:totalLabel];
    
    
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, ScreenWidth, ScreenHeight - navibar.frame.size.height - 20)];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView setBackgroundColor:[UIColor clearColor]];    tableView.tableFooterView = [[UIView alloc] init];
    
    [self.view addSubview:tableView];
    
    //添加指示器及遮罩
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = YES; //加层阴影
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"加载中...";
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
         [self requestCategoryList:kBusinessTagGetMyinv];
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });
    //获取类别信息
   
    
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
#endif

}

-(void)push:(UIButton *)btn {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark - UITableView DataSource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([dataList count] == 0) {
        return 1;
    } else if (hasMore) {
        return [dataList count] + 1;
    } else {
        return [dataList count];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableV cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *RepairCellIdentifier = @"RepairCellIdentifier";
    UITableViewCell *cell;
    cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    if ([indexPath row] == [dataList count]) {
        moreCell = [tableView dequeueReusableCellWithIdentifier:@"loadMoreCell"];
        moreCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"loadMoreCell"];
        [moreCell setBackgroundColor:[UIColor clearColor]];
        moreCell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *toastLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 160, 59)];
        [toastLabel setFont:[UIFont systemFontOfSize:12]];
        toastLabel.backgroundColor = [UIColor clearColor];
        [toastLabel setTextColor:[ColorUtil colorWithHexString:@"999999"]];
        toastLabel.numberOfLines = 0;
        toastLabel.text = @"更多...";
        toastLabel.textAlignment = NSTextAlignmentCenter;
        [moreCell.contentView addSubview:toastLabel];
        return moreCell;
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:RepairCellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setBackgroundColor:[UIColor clearColor]];
            //添加背景View
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
            [backView setBackgroundColor:[ColorUtil colorWithHexString:@"fafafa"]];
    //品牌
            
            UILabel *brandLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 200, 30)];
            brandLabel.font = [UIFont boldSystemFontOfSize:13];
            [brandLabel setTextColor:[ColorUtil colorWithHexString:@"646464"]];
            [brandLabel setBackgroundColor:[UIColor clearColor]];
            brandLabel.text = [[dataList objectAtIndex:[indexPath row]] objectForKey:@"FID_CPMC"];
            [backView addSubview:brandLabel];
 //投资日期
            UILabel *dataLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 30, 200, 10)];
            dataLabel.font = [UIFont boldSystemFontOfSize:10];
            [dataLabel setTextColor:[ColorUtil colorWithHexString:@"646464"]];
            [dataLabel setBackgroundColor:[UIColor clearColor]];
        //日期格式转化
            NSMutableString *strDate = [[NSMutableString alloc] initWithString:[[dataList objectAtIndex:[indexPath row]] objectForKey:@"FID_RGRQ"]];
           // NSString *newStr = [strDate insertring:@"-" atIndex:3];
             [strDate insertString:@"-" atIndex:4];
            [strDate insertString:@"-" atIndex:(strDate.length - 2)];
            

            dataLabel.text = [NSString stringWithFormat:@"投资日期:%@",strDate];
            [backView addSubview:dataLabel];
            
// 状态
            UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(135, 30, 150, 10)];
            statusLabel.font = [UIFont boldSystemFontOfSize:10];
            [statusLabel setTextColor:[ColorUtil colorWithHexString:@"646464"]];
            [statusLabel setBackgroundColor:[UIColor clearColor]];
            for (NSDictionary *object in dataStatus) {
                if ([[object objectForKey:@"VALUE"] isEqualToString:[[dataList objectAtIndex:indexPath.row] objectForKey:@"FID_STATUS"]]) {
                  statusLabel.text = [NSString stringWithFormat:@"项目状态:%@",[object objectForKey:@"NAME"]];
                     [backView addSubview:statusLabel];
                }
            }
  //先判定status 是不是 =5 bing zt ！= 4或10
 //缴费按钮
            if ([[[dataList objectAtIndex:indexPath.row] objectForKey:@"FID_STATUS"] isEqualToString:@"5"]) {
                if ([[[dataList objectAtIndex:indexPath.row] objectForKey:@"FID_ZT"] isEqualToString:@"4"] == NO && [[[dataList objectAtIndex:indexPath.row] objectForKey:@"FID_ZT"] isEqualToString:@"10"] == NO) {
                    UIButton *paymentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    paymentBtn.tag = indexPath.row;
                    paymentBtn.frame = CGRectMake(ScreenWidth - 55, 10, 35, 25);
                    [paymentBtn setTitle:@"缴款" forState:UIControlStateNormal];
                    [paymentBtn addTarget:self action:@selector(paymentBtnMethods:) forControlEvents:UIControlEventTouchUpInside];
                    [backView addSubview:paymentBtn];
        //撤销按钮
                    UIButton *revokeBtn= [UIButton buttonWithType:UIButtonTypeCustom];
                    revokeBtn.frame = CGRectMake(ScreenWidth - 55, 45, 35, 25);
                    revokeBtn.tag = indexPath.row;
                    [revokeBtn setTitle:@"撤销" forState:UIControlStateNormal];
                    [revokeBtn addTarget:self action:@selector(revokeBtnMethods:) forControlEvents:UIControlEventTouchUpInside];
                    [backView addSubview:revokeBtn];
                    
                    
                }
            }
            
            
            //投资金额

            UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 50, 250, 30)];
            moneyLabel.font = [UIFont boldSystemFontOfSize:13];
            [moneyLabel setTextColor:[ColorUtil colorWithHexString:@"646464"]];
            [moneyLabel setBackgroundColor:[UIColor clearColor]];
            moneyLabel.text = [NSString stringWithFormat:@"投资金额:%@",[[dataList objectAtIndex:[indexPath row]] objectForKey:@"FID_RGJE"]];
            [backView addSubview:moneyLabel];
            
            
            
            UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 79, 320, 1)];
            [subView setBackgroundColor:[ColorUtil colorWithHexString:@"dcdcdc"]];
            if ([indexPath row] != [dataList count] - 1) {
                [backView addSubview:subView];
            }
            
            [cell.contentView addSubview:backView];
            
            
        }
       // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

//缴费按钮
-(void)paymentBtnMethods:(UIButton *)btn {
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
    [paraDic setObject:[[dataList objectAtIndex:btn.tag] objectForKey:@"FID_CPDM"] forKey:@"cpdm"];
    [paraDic setObject:[[dataList objectAtIndex:btn.tag] objectForKey:@"FID_WTH"] forKey:@"wth"];
    [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:kBusinessTagGetconfirmJK owner:self];

}

//撤销按钮
-(void)revokeBtnMethods:(UIButton *)btn{
    
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
    [paraDic setObject:[[dataList objectAtIndex:btn.tag] objectForKey:@"FID_CPDM"] forKey:@"cpdm"];
    [paraDic setObject:[[dataList objectAtIndex:btn.tag] objectForKey:@"FID_WTH"] forKey:@"wth"];
    [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:kBusinessTagGetCancelWt owner:self];
}


#pragma mark - Table Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == [dataList count]) {
        return 40;
    } else {
        return 80;
    }
    return 95;
}
- (void)tableView:(UITableView *)tbleView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [dataList count] + 1) {
        for (UILabel *label in [moreCell.contentView subviews]) {
            if ([label.text isEqualToString:@"正在加载中..."]) {
                
            } else {
                label.text = @"正在加载中...";
                //[self requestCategoryList:funCode start:@"" limit:rtKeyListStr tag:kBusinessTagGetFun2List];
                [tbleView deselectRowAtIndexPath:indexPath animated:YES];
            }
        }
    } else {
        DetailInvViewController *cv = [[DetailInvViewController alloc] init];
        cv.hidesBottomBarWhenPushed = YES;
        cv.dic = [dataList objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:cv animated:NO];
        
        
       // [self.delegate reloadTableView:[dataList objectAtIndex:[indexPath row]]];
        
    }
}
#pragma mark - Request Methods
//获取品牌列表
- (void)requestCategoryList:(kBusinessTag)_tag
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"请求品牌列表");
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
    [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:_tag owner:self];
    
}

#pragma mark - Recived Methods
//处理品牌列表
- (void)recivedCategoryList:(NSMutableArray *)dataArray withTotalPrice:(NSMutableDictionary *)dic withMyInv:(NSMutableArray *)myInv
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"处理品牌列表数据");
    
    totalLabel.text = [NSString stringWithFormat:@"￥%.2f",[[[dic objectForKey:@"object"] objectForKey:@"FID_ZZC"] floatValue]];
    
    
    if ([dataList count] > 0) {
        for (NSDictionary *object in myInv) {
            [dataList addObject:object];
        }
    } else {
        dataList = myInv;
    }
    
    if ([dataStatus count] > 0) {
        for (NSDictionary *object in dataArray) {
            [dataStatus addObject:object];
        }
    } else {
        dataStatus = dataArray;
    }
    
    [tableView reloadData];
    
}

#pragma mark - NetworkModuleDelegate Methods
-(void)beginPost:(kBusinessTag)tag{
    
}
-(void)endPost:(NSString *)result business:(kBusinessTag)tag{
    NSLog(@"%s %d 收到数据:%@", __FUNCTION__, __LINE__, result);
    NSMutableDictionary *jsonDic = [result JSONValue];
    NSMutableDictionary *totalPrice = [jsonDic objectForKey:@"totalPriceResult"];
    NSMutableArray *dataArray = [jsonDic objectForKey:@"xmztList"];
    NSMutableArray *myInvResult = [[jsonDic objectForKey:@"myInvResult"] objectForKey:@"object"];
   	if (tag==kBusinessTagGetMyinv ) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        if ([[totalPrice objectForKey:@"success"] boolValue] == 0) {
            //数据异常处理
            [self.view makeToast:@"获取投资失败"];
        } else {

            [self recivedCategoryList:dataArray withTotalPrice:totalPrice withMyInv:myInvResult];
        }
    }
    [[NetworkModule sharedNetworkModule] cancel:tag];
}
-(void)errorPost:(NSError *)err business:(kBusinessTag)tag{
    NSLog(@"%s Error:%@", __FUNCTION__, @"连接数据服务器超时");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法连接" message:@"您所在地的网络信号微弱，无法连接到服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    if (tag == kBusinessTagGetMyinv) {
       [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    [[NetworkModule sharedNetworkModule] cancel:tag];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

-(void)dealloc {
    [tableView removeFromSuperview];
    tableView = nil;
    start = nil;
    startBak = nil;
   limit = nil;
    [dataList removeAllObjects];
    dataList = nil;
     hasMore = Nil;
    [moreCell removeFromSuperview];
    moreCell = nil;
    [dataStatus removeAllObjects];
    dataStatus = nil;
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

@end
