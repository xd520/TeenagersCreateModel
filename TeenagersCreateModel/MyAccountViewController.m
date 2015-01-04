//
//  MyAccountViewController.m
//  TeenagersCreateModel
//
//  Created by mac on 14-10-11.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "MyAccountViewController.h"
#import "AppDelegate.h"
#import "NewsDetailViewController.h"

@interface MyAccountViewController ()
{
//tableView  中的元素
  
    NSMutableArray *dataList;
    BOOL hasMore;
    UITableViewCell *moreCell;
   UITableView *table;
   SRRefreshView   *_slimeView;
}

@end

@implementation MyAccountViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      // self.title = @"资讯";
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
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    // 导航栏右边按钮的设置
    /*
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(ScreenWidth - 31, 12, 21, 21);
    [leftBtn setImage:[UIImage imageNamed:@"head_icon_back"] forState:UIControlStateNormal];
    //[leftBtn addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:leftBtn];
     */
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
#endif
    
    //添加tableView
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 50)];
    [table setDelegate:self];
    [table setDataSource:self];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [table setBackgroundColor:[UIColor clearColor]];
    table.tableFooterView = [[UIView alloc] init];
    
    [self.view addSubview:table];
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
    [table addSubview:_slimeView];
    
    
        //添加指示器及遮罩
   MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading.";
    
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [self requestCategoryList:kBusinessTagGetZXZX];
        dispatch_async(dispatch_get_main_queue(), ^{
           
        });
    });
    
    

}

#pragma mark - slimeRefresh delegate
- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = YES;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"加载中...";
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
       [self requestCategoryList:kBusinessTagGetZXZXAgain];
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });
    
   
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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
            cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setBackgroundColor:[UIColor clearColor]];
            //添加背景View
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
            [backView setBackgroundColor:[ColorUtil colorWithHexString:@"fafafa"]];
            //品牌
           
                UILabel *brandLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 285, 39)];
                brandLabel.font = [UIFont boldSystemFontOfSize:13];
                [brandLabel setTextColor:[ColorUtil colorWithHexString:@"646464"]];
                [brandLabel setBackgroundColor:[UIColor clearColor]];
                brandLabel.text = [[dataList objectAtIndex:[indexPath row]] objectForKey:@"BT"];
                [backView addSubview:brandLabel];

                UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 39, 320, 1)];
                [subView setBackgroundColor:[ColorUtil colorWithHexString:@"dcdcdc"]];
                if ([indexPath row] != [dataList count] - 1) {
                    [backView addSubview:subView];
                }
                
                [cell.contentView addSubview:backView];
                
                
            }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([indexPath row] == [dataList count]) {
        return 40;
    } else {
        return 40;
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
                [self requestCategoryList:kBusinessTagGetZXZX];
                [tbleView deselectRowAtIndexPath:indexPath animated:YES];
            }
        }
    } else {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
        
        NewsDetailViewController *goodsDetailViewController = [[NewsDetailViewController alloc] init];

 goodsDetailViewController.name = [[dataList objectAtIndex:indexPath.row] objectForKey:@"BT"];
        goodsDetailViewController.ID = [[dataList objectAtIndex:indexPath.row] objectForKey:@"ID"];

       goodsDetailViewController.hidesBottomBarWhenPushed = YES;
        [tbleView deselectRowAtIndexPath:indexPath animated:YES];
        [self.navigationController pushViewController:goodsDetailViewController animated:NO];
    }
}


#pragma mark - Request Methods
//获取品牌列表
- (void)requestCategoryList:(kBusinessTag)_tag
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"请求品牌列表");
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
    
    //获取类别信息
    //[paraDic setObject:_start forKey:@"areaId"];
    
    [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:_tag owner:self];
    
}

#pragma mark - Recived Methods
//处理品牌列表
- (void)recivedCategoryList:(NSMutableArray *)dataArray
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"处理品牌列表数据");
    
    dataList = dataArray;
    
   // [HUD hide:YES];
     [MBProgressHUD hideHUDForView:self.view animated:YES];
    [table reloadData];
    [_slimeView endRefresh];
}

#pragma mark - NetworkModuleDelegate Methods
-(void)beginPost:(kBusinessTag)tag{
    
}
-(void)endPost:(NSString *)result business:(kBusinessTag)tag{
    NSLog(@"%s %d 收到数据:%@", __FUNCTION__, __LINE__, result);
    NSMutableDictionary *jsonDic = [result JSONValue];
    NSMutableArray *dataArray = [jsonDic objectForKey:@"object"];
	if (tag==kBusinessTagGetZXZX ) {
        //[HUD hide:YES];
        if ([[jsonDic objectForKey:@"success"] boolValue] == 0) {
            //数据异常处理
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.view makeToast:@"获取品牌失败"];
           
        } else {
            [self recivedCategoryList:dataArray];
        }
    }  else if (tag==kBusinessTagGetZXZXAgain) {
       // [HUD hide:YES];
         [_slimeView endRefresh];
        if ([[jsonDic objectForKey:@"success"] boolValue] == 0) {
            //数据异常处理
            [self.view makeToast:@"获取品牌失败"];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        } else {
            [dataList removeAllObjects];
            [self recivedCategoryList:dataArray];
        }
    }
    [[NetworkModule sharedNetworkModule] cancel:tag];
}

-(void)errorPost:(NSError *)err business:(kBusinessTag)tag{
    NSLog(@"%s Error:%@", __FUNCTION__, @"连接数据服务器超时");
    //[HUD hide:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法连接" message:@"您所在地的网络信号微弱，无法连接到服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    if (tag == kBusinessTagGetZXZX) {
       [MBProgressHUD hideHUDForView:self.view animated:YES];
    } else if (tag == kBusinessTagGetZXZXAgain) {
     [MBProgressHUD hideHUDForView:self.view animated:YES];
        [_slimeView endRefresh];
    
    }
    
    
    [[NetworkModule sharedNetworkModule] cancel:tag];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

-(void)dealloc {
    [_slimeView removeFromSuperview];
    _slimeView = nil;
    [table removeFromSuperview];
    table = nil;
    [moreCell removeFromSuperview];
    [dataList removeAllObjects];
    dataList = nil;
    moreCell = nil;
 [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

@end
