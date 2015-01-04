//
//  BankCardViewController.m
//  TeenagersCreateModel
//
//  Created by Yonghui Xiong on 14-11-10.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "BankCardViewController.h"
#import "AppDelegate.h"
#import "NumBindViewController.h"

@interface BankCardViewController ()
{
    UITableView *tableView;
    NSString *start;
    NSString *startBak;
    NSString *limit;
    NSMutableArray *dataList;
    BOOL hasMore;
    UITableViewCell *moreCell;
    
}
@end

@implementation BankCardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        dataList = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)loadView {
    //[super loadView];
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
    
    [self.navigationController setNavigationBarHidden:YES];
    UINavigationBar *navibar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 44)];
   // navibar.userInteractionEnabled = YES;
    //navibar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navbar.png"]];
    [navibar setBackgroundImage:[UIImage imageNamed:@"title_bg"]  forBarMetrics:UIBarMetricsDefault];
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 12, 40, 20);
    //leftBtn.tag = 1;
    [leftBtn setImage:[UIImage imageNamed:@"return_ico"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
   // UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    [navibar addSubview:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    rightBtn.frame = CGRectMake(ScreenWidth - 40, 10, 21, 21);
    //rightBtn.tag = 2;
    //[rightBtn setImage:[UIImage imageNamed:@"head_icon_back"] forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    
    [navibar addSubview:rightBtn];
    
   // UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    
    
    UINavigationItem *navibarItem = [[UINavigationItem alloc]init];
    navibarItem.title = @"银行卡号";
   // navibarItem.leftBarButtonItem= leftItem;
    // navibarItem.rightBarButtonItem= rightItem;
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

    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView setBackgroundColor:[UIColor clearColor]];
    tableView.tableFooterView = [[UIView alloc] init];
    
    [self.view addSubview:tableView];
    
    //添加指示器及遮罩
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = YES; //加层阴影
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"加载中...";
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        //获取类别信息
        [self requestCategoryList:kBusinessTagGetBankInfo];
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
    static NSString *RepairCellIdentifier = @"RepairCellIdentifier";
    UITableViewCell *cell;
    cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
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
        toastLabel.text = @"您的账户未绑定银行卡...";
        toastLabel.textAlignment = NSTextAlignmentCenter;
        [moreCell.contentView addSubview:toastLabel];
        return moreCell;
    } else {
        cell = [tbleView dequeueReusableCellWithIdentifier:RepairCellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 320, 65)];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setBackgroundColor:[UIColor clearColor]];
            //添加背景View
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 65)];
            [backView setBackgroundColor:[ColorUtil colorWithHexString:@"fafafa"]];
            //品牌
                UILabel *brandLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 250, 39)];
                brandLabel.font = [UIFont boldSystemFontOfSize:15];
                [brandLabel setTextColor:[ColorUtil colorWithHexString:@"646464"]];
                [brandLabel setBackgroundColor:[UIColor clearColor]];
                brandLabel.text = [NSString stringWithFormat:@"帐号:%@",[[dataList objectAtIndex:[indexPath row]] objectForKey:@"yhzh"]];
                [backView addSubview:brandLabel];
  
 //资金帐号
            UILabel *zjzhLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 39, 200, 13)];
            zjzhLabel.font = [UIFont boldSystemFontOfSize:13];
            [zjzhLabel setTextColor:[ColorUtil colorWithHexString:@"646464"]];
            [zjzhLabel setBackgroundColor:[UIColor clearColor]];
            zjzhLabel.text = [NSString stringWithFormat:@"资金帐号:%@",[[dataList objectAtIndex:[indexPath row]] objectForKey:@"zjzh"]];
            [backView addSubview:zjzhLabel];
            
  //币种
           
            UILabel *bzLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 40, 100, 12)];
            bzLabel.font = [UIFont boldSystemFontOfSize:12];
            [bzLabel setTextColor:[ColorUtil colorWithHexString:@"646464"]];
            bzLabel.textAlignment = NSTextAlignmentRight;
            [bzLabel setBackgroundColor:[UIColor clearColor]];
            bzLabel.text = [NSString stringWithFormat:@"币种:%@",[[dataList objectAtIndex:[indexPath row]] objectForKey:@"bz"]];
            [backView addSubview:bzLabel];
            
            
            
                UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 39, 320, 1)];
                [subView setBackgroundColor:[ColorUtil colorWithHexString:@"dcdcdc"]];
                if ([indexPath row] != [dataList count] - 1) {
                    [backView addSubview:subView];
                }
                
                [cell.contentView addSubview:backView];
                
        }
    }
    return cell;
}
#pragma mark - Table Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == [dataList count]) {
        return 40;
    } else {
        return 65;
    }
    return 95;
}
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [dataList count] + 1) {
        for (UILabel *label in [moreCell.contentView subviews]) {
            if ([label.text isEqualToString:@"正在加载中..."]) {
                
            } else {
                label.text = @"正在加载中...";
               // [self requestCategoryList:funCode start:@"" limit:rtKeyListStr tag:kBusinessTagGetFun2List];
                //[tableView deselectRowAtIndexPath:indexPath animated:YES];
            }
        }
    } else {
        
        
        
        
       // [self.delegate reloadTableView:[dataList objectAtIndex:[indexPath row]]];
        //[self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - Request Methods
//获取品牌列表
- (void)requestCategoryList:(kBusinessTag)_tag
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"请求品牌列表");
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
    [paraDic setObject:@"JSYH" forKey:@"yhdm"];

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
    [tableView reloadData];
}
#pragma mark - NetworkModuleDelegate Methods
-(void)beginPost:(kBusinessTag)tag{
    
}
-(void)endPost:(NSString *)result business:(kBusinessTag)tag{
    NSLog(@"%s %d 收到数据:%@", __FUNCTION__, __LINE__, result);
    NSMutableDictionary *jsonDic = [result JSONValue];
   
	if (tag==kBusinessTagGetBankInfo ) {
       [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([[jsonDic objectForKey:@"success"] boolValue] == 0) {
            
            if ([[jsonDic objectForKey:@"msg"] isEqualToString:@"无银证转账对应关系"] == 0) {
                //数据异常处理
                [self.view makeToast:@"获取品牌失败"];
            } else {
              [self.view makeToast:[jsonDic objectForKey:@"msg"]];
            }
            
            
        } else {
           //[self.view makeToast:[jsonDic objectForKey:@"msg"]];
            NSMutableArray *dataArray = [jsonDic objectForKey:@"records"];
            [self recivedCategoryList:dataArray];
        }

    }
    [[NetworkModule sharedNetworkModule] cancel:tag];
}

-(void)errorPost:(NSError *)err business:(kBusinessTag)tag{
    NSLog(@"%s Error:%@", __FUNCTION__, @"连接数据服务器超时");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法连接" message:@"您所在地的网络信号微弱，无法连接到服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    if (tag == kBusinessTagGetBankInfo) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    [[NetworkModule sharedNetworkModule] cancel:tag];
}

-(void)push {
    
[self.navigationController popViewControllerAnimated:YES];
    
}


-(void)push:(UIButton *)btn {
    if (dataList.count == 1) {
        [self.view makeToast:@"目前只能绑定一张银行卡" duration:0.5 position:@"center"];
    } else {
        NumBindViewController *vc = [[NumBindViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

}

@end
