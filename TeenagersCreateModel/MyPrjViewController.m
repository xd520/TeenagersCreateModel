//
//  MyPrjViewController.m
//  TeenagersCreateModel
//
//  Created by Yonghui Xiong on 14-11-5.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "MyPrjViewController.h"
#import "AppDelegate.h"

@interface MyPrjViewController ()
{
    UITableView *tableView;
    NSString *start;
    NSString *startBak;
    NSString *limit;
    NSMutableArray *dataList;
    BOOL hasMore;
    UITableViewCell *moreCell;
    SRRefreshView   *_slimeView;
    
}
@end

@implementation MyPrjViewController

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
    navibarItem.title = @"我的项目";
    navibarItem.leftBarButtonItem= leftItem;
    // self.navigationItem.rightBarButtonItem = leftItem;
    [navibar pushNavigationItem:navibarItem animated:YES];
    [self.view addSubview:navibar];
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - navibar.frame.size.height - 20)];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView setBackgroundColor:[UIColor clearColor]];    tableView.tableFooterView = [[UIView alloc] init];
    
    [self.view addSubview:tableView];
    
    //加入下拉刷新
    _slimeView = [[SRRefreshView alloc] init];
    _slimeView.delegate = self;
    _slimeView.upInset = 0;
    _slimeView.slimeMissWhenGoingBack = YES;
    _slimeView.slime.bodyColor = [UIColor blackColor];
    _slimeView.slime.skinColor = [UIColor whiteColor];
    _slimeView.slime.lineWith = 1;
    _slimeView.slime.shadowBlur = 4;
    _slimeView.slime.shadowColor = [UIColor blackColor];
    [tableView addSubview:_slimeView];

    
    
    //添加指示器及遮罩
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = YES; //加层阴影
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"加载中...";
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        //获取类别信息
        [self requestCategoryList:start limit:limit tag:kBusinessTagGetMyprj];
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });
    

    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
#endif

}

#pragma mark - slimeRefresh delegate
- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    startBak = [NSString stringWithString:start];
    start = @"1";
    [self requestCategoryList:start limit:limit tag:kBusinessTagGetMyprjAgain];
}
#pragma mark - UIScrollView Delegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_slimeView scrollViewDidScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_slimeView scrollViewDidEndDraging];
}

- (void)tableView:(UITableView *)tbleView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == [dataList count]) {
        if (hasMore) {
            for (UILabel *label in [cell.contentView subviews]) {
                if ([label.text isEqualToString:@"*****正在加载*****"]) {
                    
                } else {
                    label.text = @"*****正在加载*****";
                    [self requestCategoryList:start limit:limit tag:kBusinessTagGetMyprj];
                    [tbleView deselectRowAtIndexPath:indexPath animated:YES];
                }
            }
        }
    }
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
- (UITableViewCell *)tableView:(UITableView *)tbleView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[tableView setScrollEnabled:NO]; tableView 不能滑动
    static NSString *RepairCellIdentifier = @"RepairCellIdentifier";
    UITableViewCell *cell;
    cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    if ([dataList count] == 0) {
        if (YES) {
            cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 50)];
            [backView setBackgroundColor:[ColorUtil colorWithHexString:@"ececec"]];
            //图标
            UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(131.5, 100, 57, 57)];
            [iconImageView setImage:[UIImage imageNamed:@"icon_none"]];
            [backView addSubview:iconImageView];
            //提示
            UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, iconImageView.frame.origin.y + iconImageView.frame.size.height + 27, 320, 15)];
            [tipLabel setFont:[UIFont systemFontOfSize:15]];
            [tipLabel setTextAlignment:NSTextAlignmentCenter];
            [tipLabel setTextColor:[ColorUtil colorWithHexString:@"404040"]];
            [tipLabel setText:@"没有任何创建项目哦~"];
            [backView addSubview:tipLabel];
            [cell.contentView addSubview:backView];
            
        }
    } else {
        if ([indexPath row] == [dataList count]) {
            moreCell = [tbleView dequeueReusableCellWithIdentifier:@"loadMoreCell"];
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
            cell = [tbleView dequeueReusableCellWithIdentifier:RepairCellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell setBackgroundColor:[UIColor clearColor]];
                //添加背景View
                UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
                [backView setBackgroundColor:[ColorUtil colorWithHexString:@"fdfdfd"]];
                
            //品牌
                
                UILabel *brandLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 200, 30)];
                brandLabel.font = [UIFont boldSystemFontOfSize:13];
                [brandLabel setTextColor:[ColorUtil colorWithHexString:@"646464"]];
                [brandLabel setBackgroundColor:[UIColor clearColor]];
                brandLabel.text = [[dataList objectAtIndex:[indexPath row]] objectForKey:@"CPMC"];
                [backView addSubview:brandLabel];
        //投资日期
                UILabel *dataLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 30, 200, 10)];
                dataLabel.font = [UIFont boldSystemFontOfSize:10];
                [dataLabel setTextColor:[ColorUtil colorWithHexString:@"646464"]];
                [dataLabel setBackgroundColor:[UIColor clearColor]];
            //日期格式转化
                NSMutableString *strDate = [[NSMutableString alloc] initWithString:[[dataList objectAtIndex:[indexPath row]] objectForKey:@"DJRQ"]];
                // NSString *newStr = [strDate insertring:@"-" atIndex:3];
                [strDate insertString:@"-" atIndex:4];
                [strDate insertString:@"-" atIndex:(strDate.length - 2)];
                
                
                dataLabel.text = [NSString stringWithFormat:@"申请时间:%@",strDate];
                [backView addSubview:dataLabel];
                
            // 状态
                if ([[[dataList objectAtIndex:[indexPath row]] objectForKey:@"KHH_LTR"] isEqualToString:@""] == NO) {
                    
              
                UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 30, 150, 10)];
                statusLabel.font = [UIFont boldSystemFontOfSize:10];
                [statusLabel setTextColor:[ColorUtil colorWithHexString:@"646464"]];
                [statusLabel setBackgroundColor:[UIColor clearColor]];
                
                statusLabel.text = [NSString stringWithFormat:@"领头人:%@",[[dataList objectAtIndex:[indexPath row]] objectForKey:@"KHH_LTR"]];
                [backView addSubview:statusLabel];
                
                }
                //先判定status 是不是 =5 bing zt ！= 4或10
                //修改按钮

                UIButton *paymentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                paymentBtn.tag = indexPath.row;
                paymentBtn.backgroundColor = [UIColor blueColor];
                paymentBtn.frame = CGRectMake(ScreenWidth - 75, 20, 60, 30);
                [paymentBtn setTitle:@"修改" forState:UIControlStateNormal];
                [paymentBtn addTarget:self action:@selector(paymentBtnMethods:) forControlEvents:UIControlEventTouchUpInside];
                //[backView addSubview:paymentBtn];
                
                //投资金额
                
                UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 50, 150, 30)];
                moneyLabel.font = [UIFont boldSystemFontOfSize:13];
                [moneyLabel setTextColor:[ColorUtil colorWithHexString:@"646464"]];
                [moneyLabel setBackgroundColor:[UIColor clearColor]];
                moneyLabel.text = [NSString stringWithFormat:@"融资金额:%@",[[dataList objectAtIndex:[indexPath row]] objectForKey:@"MJZJGM"]];
                [backView addSubview:moneyLabel];
                
    //已认购金额
                
                UILabel *buyLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 50, 150, 30)];
                buyLabel.font = [UIFont boldSystemFontOfSize:13];
                [buyLabel setTextColor:[ColorUtil colorWithHexString:@"646464"]];
                [buyLabel setBackgroundColor:[UIColor clearColor]];
                buyLabel.text = [NSString stringWithFormat:@"已认购金额:%@",[[dataList objectAtIndex:[indexPath row]] objectForKey:@"YRGJE"]];
                [backView addSubview:buyLabel];
                
                UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 79, 320, 1)];
                [subView setBackgroundColor:[ColorUtil colorWithHexString:@"dcdcdc"]];
                if ([indexPath row] != [dataList count] - 1) {
                    [backView addSubview:subView];
                }
                
                [cell.contentView addSubview:backView];
                
                
            }
        }
        return cell;
    }
    return cell;
}

-(void)paymentBtnMethods:(UIButton *)btn {
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
    [paraDic setObject:[[dataList objectAtIndex:btn.tag] objectForKey:@"FID_CPDM"] forKey:@"cpdm"];
    [paraDic setObject:[[dataList objectAtIndex:btn.tag] objectForKey:@"FID_WTH"] forKey:@"wth"];
    [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:kBusinessTagGetconfirmJK owner:self];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
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
    if (indexPath.row == [dataList count]) {
        for (UILabel *label in [moreCell.contentView subviews]) {
            if ([label.text isEqualToString:@"正在加载中..."]) {
                
            } else {
                label.text = @"正在加载中...";
                [self requestCategoryList:start limit:limit tag:kBusinessTagUserGetList];
                [tbleView deselectRowAtIndexPath:indexPath animated:YES];
            }
        }
    } else {
       // DetailViewController *goodsDetailViewController = [[DetailViewController alloc] init];
        ;
        // goodsDetailViewController.title = [[[dataList objectAtIndex:indexPath.row] objectForKey:@"DETAIL"] objectForKey:@"XMMC"];
       // goodsDetailViewController.titleName = [[[dataList objectAtIndex:indexPath.row] objectForKey:@"DETAIL"] objectForKey:@"XMMC"] ;
        //goodsDetailViewController.preductDes = [NSString stringWithFormat:@"发行日期：%@",[[[dataList objectAtIndex:indexPath.row] objectForKey:@"DETAIL"] objectForKey:@"XMJS"]];
       // goodsDetailViewController.desc = [NSString stringWithFormat:@"发行价：%@",[[[dataList objectAtIndex:indexPath.row] objectForKey:@"DETAIL"] objectForKey:@"LD"]];
       // goodsDetailViewController.image =  [NSString stringWithFormat:@"%@",[[[dataList objectAtIndex:indexPath.row] objectForKey:@"DETAIL"] objectForKey:@"LOGO"]];
       // goodsDetailViewController.hidesBottomBarWhenPushed = YES;
        [tbleView deselectRowAtIndexPath:indexPath animated:YES];
        //[self.navigationController pushViewController:goodsDetailViewController animated:YES];
    }
}

#pragma mark - Request Methods
//获取品牌列表
- (void)requestCategoryList:(NSString *)_start limit:(NSString *)_limit tag:(kBusinessTag)_tag
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"请求品牌列表");
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
    [paraDic setObject:_limit forKey:@"batchSize"];
    [paraDic setObject:_start forKey:@"batchNo"];
    [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:_tag owner:self];
    
}

#pragma mark - Recived Methods
//处理品牌列表
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
    if ([dataArray count] < 10) {
        hasMore = NO;
    } else {
        hasMore = YES;
        start = [NSString stringWithFormat:@"%d", [start intValue] + 1];
    }
    [tableView reloadData];
    [_slimeView endRefresh];
}

#pragma mark - NetworkModuleDelegate Methods
-(void)beginPost:(kBusinessTag)tag{
    
}
-(void)endPost:(NSString *)result business:(kBusinessTag)tag{
    NSLog(@"%s %d 收到数据:%@", __FUNCTION__, __LINE__, result);
    NSMutableDictionary *jsonDic = [result JSONValue];
    NSMutableArray *dataArray = [jsonDic objectForKey:@"object"];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
	if (tag==kBusinessTagGetMyprj ) {
       
        if ([[jsonDic objectForKey:@"success"] boolValue] == 0) {
            //数据异常处理
            if ([[jsonDic objectForKey:@"object"] isEqualToString:@"loginTimeout"] == YES) {
                
                LoginViewController *vc = [[LoginViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:NO];
                
            } else {
                
                [self.view makeToast:@"获取项目失败"];
            }
            
        } else {
            [self recivedCategoryList:dataArray];
        }
    }else if (tag == kBusinessTagGetMyprjAgain){
       
        [_slimeView endRefresh];
        if ([[jsonDic objectForKey:@"success"] boolValue] == 0) {
            //数据异常处理
            [self.view makeToast:@"刷新商品失败"];
        } else {
            [dataList removeAllObjects];
            [self recivedCategoryList:dataArray];
        }
    }
    [[NetworkModule sharedNetworkModule] cancel:tag];
}

-(void)errorPost:(NSError *)err business:(kBusinessTag)tag{
    NSLog(@"%s Error:%@", __FUNCTION__, @"连接数据服务器超时");
   
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法连接" message:@"您所在地的网络信号微弱，无法连接到服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
   if (tag == kBusinessTagGetMyprjAgain) {
        start = [NSString stringWithString:startBak];
        [_slimeView endRefresh];
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
    [_slimeView removeFromSuperview];
    _slimeView = nil;
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

@end
