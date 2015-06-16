//
//  ProjectIntroductionViewController.m
//  TeenagersCreateModel
//
//  Created by mac on 14-10-11.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "ProjectIntroductionViewController.h"
#import "AppDelegate.h"
#import "DropDownListView.h"
#import "DetailViewController.h"
#import "Customer.h"
#import "UIImageView+WebCache.h"
#import "LoginViewController.h"


@interface ProjectIntroductionViewController ()
{
   //筛选条件 导航条
 NSMutableArray *chooseArray ;
    
  //tableView  中的元素
    UITableView *tableView;
    NSString *start;
    NSString *startBak;
    NSString *limit;
    NSMutableArray *dataList;
    BOOL hasMore;
    UITableViewCell *moreCell;
    SRRefreshView   *_slimeView;
    UIButton *classBtn;
    UIPopoverListView *industryList;
    UIPopoverListView *proviceList;
    UIPopoverListView *statusList;
    UIPopoverListView *cityList;
    
    NSMutableArray *industry;
    NSMutableArray *provce;
    NSMutableArray *status;
    NSMutableArray *City;
    
    NSString *industryStr;
    NSString *areaStr;
    NSString *statusStr;
    NSString *cityStr;
    UIView *chooseView;
    UISearchBar *searchBar;
    UIButton *cancelBtn;
    
    UIButton *statusBtn;
    UIButton *proviceBtn;
    UIButton *industryBtn;
    UILabel *statusLabel;
    UILabel *proviceLabel;
    UILabel *industryLabel;
    
}
@end

@implementation ProjectIntroductionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       // self.title = @"我要投资";
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = nil;
       
    }
    return self;
}

-(void)loadView {
    [super loadView];
    UIView *baseView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    
   // darkGrayColor;
   //lightGrayColor;
    baseView.backgroundColor = [ColorUtil colorWithHexString:@"eeeeee"];
    //baseView.backgroundColor = [UIColor lightGrayColor];
    self.view = baseView;
}

//-(void)viewDidAppear:(BOOL)animated{
//    [industryList reloadInputViews];
//
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
     self.navigationController.navigationBar.userInteractionEnabled = NO;
    start = @"1";
    limit = @"10";
    
    industryStr = @"";
    areaStr = @"";
    statusStr = @"";
    cityStr = @"";
    startBak = @"";
 // 导航栏右边按钮的设置
    self.navigationController.navigationBar.userInteractionEnabled = YES;
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(ScreenWidth - 45, 7, 35, 30);
    [leftBtn setImage:[UIImage imageNamed:@"android_search_icon"] forState:UIControlStateNormal];
    //leftBtn.backgroundColor = [UIColor redColor];
    [leftBtn addTarget:self action:@selector(push1:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:leftBtn];
    
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
//    self.navigationItem.rightBarButtonItem = leftItem;
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
#endif
    
    cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(ScreenWidth - 50, 0, 50, 40);
    cancelBtn.hidden = YES;
    cancelBtn.backgroundColor = [ColorUtil colorWithHexString:@"cac9ce"];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [cancelBtn addTarget:self action:@selector(cancelMtthods:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    
    
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width - 50, 40)];
    searchBar.delegate = self;
    searchBar.showsScopeBar = NO;
    searchBar.barStyle = UISearchBarStyleDefault;
    searchBar.placeholder = @"请输入要搜索的东西";
    searchBar.keyboardType=UIKeyboardTypeNamePhonePad;
    searchBar.hidden = YES;
    
//    searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:searchBar contentsController:self];
//    //searchDisplayController.active = NO;
//    //searchDisplayController.searchResultsDataSource = self;
//    //searchDisplayController.searchResultsDelegate = self;
    
    [self.view addSubview:searchBar];
    
    // 筛选条件框的设置
    chooseView = [[UIView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 40)];
    chooseView.backgroundColor = [UIColor redColor];
// 行业
    industryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    industryBtn.frame = CGRectMake(0, 0, ScreenWidth/3, 40);
    //[industryBtn setTitle:@"行业" forState:UIControlStateNormal];
    [industryBtn setBackgroundImage:[UIImage imageNamed:@"111"] forState:UIControlStateNormal];
    
    
    industryBtn.tag = 1;
    [industryBtn addTarget:self action:@selector(popClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    industryLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, ScreenWidth/3 - 20, 40)];
    industryLabel.text = @"行业";
    industryLabel.backgroundColor = [UIColor clearColor];
    industryLabel.font = [UIFont systemFontOfSize:16];
    industryLabel.textAlignment = NSTextAlignmentCenter;
    [industryBtn addSubview:industryLabel];
    
    
    
    [chooseView addSubview:industryBtn];
//省份
    proviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    proviceBtn.frame = CGRectMake(ScreenWidth/3, 0, ScreenWidth/3, 40);
    //[proviceBtn setTitle:@"地区" forState:UIControlStateNormal];
     [proviceBtn setBackgroundImage:[UIImage imageNamed:@"111"] forState:UIControlStateNormal];
    proviceBtn.tag = 2;
    [proviceBtn addTarget:self action:@selector(popClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    proviceLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, ScreenWidth/3 - 20, 40)];
    proviceLabel.text = @"地区";
    proviceLabel.backgroundColor = [UIColor clearColor];
    proviceLabel.font = [UIFont systemFontOfSize:16];
    proviceLabel.textAlignment = NSTextAlignmentCenter;
    [proviceBtn addSubview:proviceLabel];
    
    
    [chooseView addSubview:proviceBtn];
 //状态
   statusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    statusBtn.frame = CGRectMake(2*ScreenWidth/3, 0, ScreenWidth/3, 40);
    //[statusBtn setTitle:@"规划" forState:UIControlStateNormal];
     [statusBtn setBackgroundImage:[UIImage imageNamed:@"111"] forState:UIControlStateNormal];
    statusBtn.tag = 3;
    [statusBtn addTarget:self action:@selector(popClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, ScreenWidth/3 - 20, 40)];
    statusLabel.text = @"项目阶段";
    statusLabel.backgroundColor = [UIColor clearColor];
    statusLabel.font = [UIFont systemFontOfSize:16];
    statusLabel.textAlignment = NSTextAlignmentCenter;
    [statusBtn addSubview:statusLabel];
    
    [chooseView addSubview:statusBtn];
    
    
    
    [self.view addSubview:chooseView];

    //添加tableView
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,chooseView.frame.origin.y + chooseView.frame.size.height, ScreenWidth, ScreenHeight - 64 - 30 - 60 - 4)];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView setBackgroundColor:[UIColor clearColor]];
    tableView.tableFooterView = [[UIView alloc] init];
    
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
    hud.dimBackground = YES;
    hud.delegate = self;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"加载中...";
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [self requestCategoryList:start limit:limit tag:kBusinessTagUserGetList];
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });
    
    
    
}

#pragma  mark UISearceBar Delegate Methods
- (void)searchBarSearchButtonClicked:(UISearchBar *)seachBar
{
    [seachBar resignFirstResponder];
    
   
        NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
        [paraDic setObject:searchBar.text forKey:@"title"];
        [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:kBusinessTagUserGetEndRefreshList owner:self];
        hasMore = NO;
    NSLog(@"nishi  sb %@",searchBar.text);
    chooseView.hidden = NO;
    cancelBtn.hidden = YES;
    //[chooseView removeFromSuperview];
    searchBar.hidden = YES;
    //[searchBar removeFromSuperview];
}



-(void)cancelMtthods:(UIButton *)btn {

    [searchBar resignFirstResponder];
    chooseView.hidden = NO;
    searchBar.hidden = YES;
    cancelBtn.hidden = YES;
    //[btn removeFromSuperview];
}




- (void)popClickAction:(UIButton *)sender
{
    if (sender.tag == 1) {
        [industryBtn setBackgroundImage:[UIImage imageNamed:@"222"] forState:UIControlStateNormal];
    [self requestTableList:kBusinessTagGetIndustry];   
       
    } else if (sender.tag == 2){
        [proviceBtn setBackgroundImage:[UIImage imageNamed:@"222"] forState:UIControlStateNormal];
        [self requestTableList:kBusinessTagGetProvince];
        
    }else if (sender.tag == 3){
        [statusBtn setBackgroundImage:[UIImage imageNamed:@"222"] forState:UIControlStateNormal];
        [self requestTableList:kBusinessTagGetStatus];
        
    }
    
}

#pragma mark - UIPopoverListViewDataSource

- (UITableViewCell *)popoverListView:(UIPopoverListView *)popoverListView
                    cellForIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                    reuseIdentifier:identifier];
    
    NSInteger row = indexPath.row;
    if (popoverListView.tag == 100001) {
        cell.textLabel.text = [[industry objectAtIndex:row] objectForKey:@"mc"];
    } else if (popoverListView.tag == 100002){
       cell.textLabel.text = [[provce objectAtIndex:row] objectForKey:@"xzqymc"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (popoverListView.tag == 100003){
        cell.textLabel.text = [[status objectAtIndex:row] objectForKey:@"value"];
    } else if (popoverListView.tag == 100004){
        cell.textLabel.text = [[City objectAtIndex:row] objectForKey:@"xzqymc"];
    }
    
    return cell;
}

- (NSInteger)popoverListView:(UIPopoverListView *)popoverListView
       numberOfRowsInSection:(NSInteger)section
{
    NSInteger row;
    if (popoverListView.tag == 100001) {
        row = industry.count;

    } else if (popoverListView.tag == 100002){
        row = provce.count;

    } else if (popoverListView.tag == 100003){
       row = status.count;
    } else if (popoverListView.tag == 100004){
        row = City.count;
    }
    
    return row;
}

#pragma mark - UIPopoverListViewDelegate
- (void)popoverListView:(UIPopoverListView *)popoverListView
     didSelectIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s : %ld", __func__, (long)indexPath.row);
    
    if (popoverListView.tag == 100001) {
        industryStr = [[industry objectAtIndex:indexPath.row] objectForKey:@"id"];
        [industryBtn setBackgroundImage:[UIImage imageNamed:@"111"] forState:UIControlStateNormal];
        [industryLabel setText:[[industry objectAtIndex:indexPath.row] objectForKey:@"mc"]];
    } else if (popoverListView.tag == 100002){
        areaStr = [[provce objectAtIndex:indexPath.row] objectForKey:@"xzqydm"];
        NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
        [paraDic setObject:areaStr forKey:@"code"];
        [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:kBusinessTagGetCity owner:self];
        
        
    } else if (popoverListView.tag == 100003){
        statusStr = [[status objectAtIndex:indexPath.row] objectForKey:@"label"];
        [statusLabel setText:[[status objectAtIndex:indexPath.row] objectForKey:@"value"]];
        [statusBtn setBackgroundImage:[UIImage imageNamed:@"111"] forState:UIControlStateNormal];
    } else if (popoverListView.tag == 100004){
        cityStr = [[City objectAtIndex:indexPath.row] objectForKey:@"xzqydm"];
        [proviceLabel setText:[[City objectAtIndex:indexPath.row] objectForKey:@"xzqymc"]];
        [proviceBtn setBackgroundImage:[UIImage imageNamed:@"111"] forState:UIControlStateNormal];
    }
    
    
   
    
    //添加指示器及遮罩
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = YES;
    hud.delegate = self;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"加载中...";
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        hasMore = NO;
       [self requestCategoryListAgain:industryStr area:cityStr status:statusStr tag:kBusinessTagUserGetEndRefreshList];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });
    
    
}

- (CGFloat)popoverListView:(UIPopoverListView *)popoverListView
   heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}





#pragma mark - slimeRefresh delegate
- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    startBak = [NSString stringWithString:start];
    start = @"1";
    industryStr = @"";
    areaStr = @"";
    statusStr = @"";
    cityStr = @"";
    [industryLabel setText:@"行业"];
     [proviceLabel setText:@"地区"];
     [statusLabel setText:@"项目阶段"];
    
     [self requestCategoryList:start limit:limit tag:kBusinessTagUserGetListAgain];
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
                     [self requestCategoryList:start limit:limit tag:kBusinessTagUserGetList];
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
            tipLabel.backgroundColor = [UIColor clearColor];
            [tipLabel setText:@"没有任何商品哦~"];
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
                cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 70)];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell setBackgroundColor:[UIColor clearColor]];
                //添加背景View
                UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, ScreenWidth, 69)];
                [backView setBackgroundColor:[UIColor whiteColor]];
               
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5 , 80, 60)];
                imageView.tag = indexPath.row + 100;
//                [imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ICONSURL,[[[dataList objectAtIndex:indexPath.row] objectForKey:@"detail_url"] objectForKey:@"LOGO"]]]
//                               placeholderImage:[UIImage imageNamed:@"xd1"]];
                [imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVERURL,[[[dataList objectAtIndex:indexPath.row] objectForKey:@"detail_url"] objectForKey:@"LOGO"]]]
                               placeholderImage:[UIImage imageNamed:@"xd1"]
            success:^(UIImage *image) {
                                            
                                        }
            failure:^(NSError *error) {
                
                UIImageView *imageView1 = (UIImageView *)[(UIImageView *)self.view viewWithTag:indexPath.row + 100];
                [imageView1 setImage:[UIImage imageNamed:@"xd1"]];
                
            }];
            
                 [backView addSubview:imageView];
               
                //品牌
                UILabel *brandLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 6, 220, 15)];
                brandLabel.font = [UIFont boldSystemFontOfSize:15];
                [brandLabel setTextColor:[ColorUtil colorWithHexString:@"1b1b1b"]];
                [brandLabel setBackgroundColor:[UIColor clearColor]];
                brandLabel.text = [[[dataList objectAtIndex:indexPath.row] objectForKey:@"detail_url"] objectForKey:@"XMMC"];
                [backView addSubview:brandLabel];
                //发行价
                /*
                SHLUILabel *issuePriceLabel = [[SHLUILabel alloc] init];
                issuePriceLabel.text = [NSString stringWithFormat:@"项目简介：%@",[[[dataList objectAtIndex:indexPath.row] objectForKey:@"DETAIL"] objectForKey:@"LD"]];
                //使用自定义字体
                issuePriceLabel.font = [UIFont systemFontOfSize:10];    //设置字体颜色
                issuePriceLabel.textColor = [ColorUtil colorWithHexString:@"1b1b1b"];
                issuePriceLabel.lineBreakMode = NSLineBreakByWordWrapping;
                issuePriceLabel.linesSpacing = 0.0f;
                //0:6 1:7 2:8 3:9 4:10
                //linesSpacing_
                issuePriceLabel.numberOfLines = 0;
                //根据字符串长度和Label显示的宽度计算出contentLab的高
                int labelHeight = [issuePriceLabel getAttributedStringHeightWidthValue:150];
                NSLog(@"SHLLabel height:%d", labelHeight);
                issuePriceLabel.frame = CGRectMake(80.f, 33.f, 150.f, labelHeight);
                NSLog(@"%d",labelHeight - 32);
                
                [backView addSubview:issuePriceLabel];
                
                */
                
         //行业
                UILabel *issuePriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 30, 100, 20)];
                issuePriceLabel.backgroundColor = [ColorUtil colorWithHexString:@"39b3d8"];
                issuePriceLabel.font = [UIFont boldSystemFontOfSize:14];
                [issuePriceLabel setTextColor:[UIColor whiteColor]];
                issuePriceLabel.textAlignment = NSTextAlignmentCenter;
                //[issuePriceLabel setBackgroundColor:[UIColor clearColor]];
                issuePriceLabel.text = [[dataList objectAtIndex:indexPath.row] objectForKey:@"sshy"];
                [backView addSubview:issuePriceLabel];
        //地区
                
                UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 30, 80, 20)];
                dateLabel.backgroundColor = [ColorUtil colorWithHexString:@"2ade73"];
                dateLabel.font = [UIFont boldSystemFontOfSize:14];
                [dateLabel setTextColor:[UIColor whiteColor]];
                dateLabel.textAlignment = NSTextAlignmentCenter;
                //[dateLabel setBackgroundColor:[UIColor clearColor]];
                dateLabel.text = [[dataList objectAtIndex:indexPath.row] objectForKey:@"szcs"];
                [backView addSubview:dateLabel];
                
        //项目亮点
                
                UILabel *codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 54, 220, 15)];
                codeLabel.font = [UIFont systemFontOfSize:10];
                //[codeLabel setTextColor:[ColorUtil colorWithHexString:@"1b1b1b"]];
                //[codeLabel setBackgroundColor:[UIColor lightGrayColor]];
                codeLabel.text = [[[dataList objectAtIndex:indexPath.row] objectForKey:@"detail_url"] objectForKey:@"LD"];
                codeLabel.textAlignment = NSTextAlignmentLeft;
                [backView addSubview:codeLabel];
                //股权名称
                
                UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(190, 50, 90, 10)];
                nameLabel.font = [UIFont systemFontOfSize:10];
                [nameLabel setTextColor:[ColorUtil colorWithHexString:@"1b1b1b"]];
                [nameLabel setBackgroundColor:[UIColor clearColor]];
                nameLabel.text = [NSString stringWithFormat:@"股权名称：%@",[[[dataList objectAtIndex:indexPath.row] objectForKey:@"DETAIL"] objectForKey:@"BQ"]];
               // [backView addSubview:nameLabel];
                
                
                
                
                UILabel *CPJJLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 35, 200, 13)];
                CPJJLabel.numberOfLines = 0;
                CPJJLabel.font = [UIFont systemFontOfSize:13];
                [CPJJLabel setTextColor:[ColorUtil colorWithHexString:@"1b1b1b"]];
                [CPJJLabel setBackgroundColor:[UIColor clearColor]];
                //CPJJLabel.text = [NSString stringWithFormat:@"你是%d猴子派来的救兵吗？",[indexPath row]];
                // CPJJLabel.text = [[[[dataList objectAtIndex:[indexPath row]] objectForKey:@"xmlObj"] objectForKey:@"CPJJ"] objectForKey:@"value"];
                //[backView addSubview:CPJJLabel];
                
                
                //型号
                
                
                [cell.contentView addSubview:backView];
            }
        }
        return cell;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
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
          AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
         delegate.tagCountStr = @"5";
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        if (delegate.array.count > 0) {
              Customer *custer = [delegate.array objectAtIndex:0];
            if (custer.loginSueccss) {
        DetailViewController *goodsDetailViewController = [[DetailViewController alloc] init];
        ;
       // goodsDetailViewController.title = [[[dataList objectAtIndex:indexPath.row] objectForKey:@"DETAIL"] objectForKey:@"XMMC"];
        goodsDetailViewController.titleName = [[[dataList objectAtIndex:indexPath.row] objectForKey:@"detail_url"] objectForKey:@"XMMC"] ;
                if ([[dataList objectAtIndex:indexPath.row] objectForKey:@"cpdm"] == [NSNull null]) {
                    delegate.numStr = @"";
                } else {
        delegate.numStr = [[dataList objectAtIndex:indexPath.row] objectForKey:@"cpdm"];
                }
        goodsDetailViewController.hidesBottomBarWhenPushed = YES;
       [tbleView deselectRowAtIndexPath:indexPath animated:YES];
        [self.navigationController pushViewController:goodsDetailViewController animated:NO];
            }else {
           // [self.view makeToast:@"请重新登陆"];
                LoginViewController *vc = [[LoginViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:NO];
                if ([[dataList objectAtIndex:indexPath.row] objectForKey:@"cpdm"] == [NSNull null]) {
                    delegate.numStr = @"";
                } else {
                    delegate.numStr = [[dataList objectAtIndex:indexPath.row] objectForKey:@"cpdm"];
                }
                
            }
        } else {
        
            LoginViewController *vc = [[LoginViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:NO];
            if ([[dataList objectAtIndex:indexPath.row] objectForKey:@"cpdm"] == [NSNull null]) {
                delegate.numStr = @"";
            } else {
                delegate.numStr = [[dataList objectAtIndex:indexPath.row] objectForKey:@"cpdm"];
            }
        }
    }
}


#pragma mark - Request Methods
//获取品牌列表
- (void)requestCategoryList:(NSString *)_start limit:(NSString *)_limit tag:(kBusinessTag)_tag
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"请求品牌列表");
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
    
    //获取类别信息

    //[paraDic setObject:@"cxCPXX" forKey:@"objectName"];
    //[paraDic setObject:@"{\"SUBCLASS\":\"0101\"}" forKey:@"jsonParamStr"];
    [paraDic setObject:_limit forKey:@"rowCount"];
    [paraDic setObject:_start forKey:@"rowIndex"];
    //[paraDic setObject:@"True" forKey:@"queryCount"];
    
    
    [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:_tag owner:self];
    
}

//获取刷新列表
- (void)requestCategoryListAgain:(NSString *)_indusry area:(NSString *)_area status:(NSString *)_status tag:(kBusinessTag)_tag
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"请求品牌列表");
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
    [paraDic setObject:@"1" forKey:@"rowIndex"];
    [paraDic setObject:@"30" forKey:@"rowCount"];
    [paraDic setObject:_indusry forKey:@"industry"];
    [paraDic setObject:_area forKey:@"area"];
    [paraDic setObject:_status forKey:@"status"];
    
    
    [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:_tag owner:self];
    
}


- (void)requestTableList:(kBusinessTag)_tag
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"请求品牌列表");
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
    //[paraDic setObject:@"1" forKey:@"size"];
    [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:_tag owner:self];
    
}


#pragma mark - Recived Methods
//刷新的时候
- (void)recivedEndRefreshList:(NSMutableArray *)dataArray
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
    [tableView reloadData];
    //[_slimeView endRefresh];
   // hasMore = YES;
}



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
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [tableView reloadData];
    [_slimeView endRefresh];
}

- (void)recivedTableList:(NSMutableArray *)dataArray business:(kBusinessTag)tag
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"处理品牌列表数据");
    
    if (tag == kBusinessTagGetIndustry) {
        
        if ([industry count] > 0) {
            [industry removeAllObjects];
            for (NSDictionary *object in dataArray) {
                [industry addObject:object];
            }
        } else {
            industry = dataArray;
        }
        CGFloat xWidth = self.view.bounds.size.width - 20.0f;
        CGFloat yHeight = 272.0f;
        CGFloat yOffset = (self.view.bounds.size.height - yHeight)/2.0f;
        industryList = [[UIPopoverListView alloc] initWithFrame:CGRectMake(10, yOffset, xWidth, yHeight)];
        industryList.delegate = self;
        industryList.datasource = self;
        industryList.tag = 100001;
        industryList.listView.scrollEnabled = TRUE;
        [industryList setTitle:@"行业"];
        [industryList show];
        
    } else if (tag == kBusinessTagGetProvince){
        if ([provce count] > 0) {
            [provce removeAllObjects];
            for (NSDictionary *object in dataArray) {
                [provce addObject:object];
            }
        } else {
            provce = dataArray;
        }
        CGFloat xWidth = self.view.bounds.size.width - 20.0f;
        CGFloat yHeight = 272.0f;
        CGFloat yOffset = (self.view.bounds.size.height - yHeight)/2.0f;
        proviceList = [[UIPopoverListView alloc] initWithFrame:CGRectMake(10, yOffset, xWidth, yHeight)];
        proviceList.delegate = self;
        proviceList.datasource = self;
        proviceList.tag = 100002;
        proviceList.listView.scrollEnabled = TRUE;
        [proviceList setTitle:@"地区"];
        [proviceList show];
        
    }  else if (tag == kBusinessTagGetStatus){
        if ([status count] > 0) {
            [status removeAllObjects];
            for (NSDictionary *object in dataArray) {
                [status addObject:object];
            }
        } else {
            status = dataArray;
        }
        CGFloat xWidth = self.view.bounds.size.width - 20.0f;
        CGFloat yHeight = 272.0f;
        CGFloat yOffset = (self.view.bounds.size.height - yHeight)/2.0f;
        statusList = [[UIPopoverListView alloc] initWithFrame:CGRectMake(10, yOffset, xWidth, yHeight)];
        statusList.delegate = self;
        statusList.datasource = self;
        statusList.tag = 100003;
        statusList.listView.scrollEnabled = TRUE;
        [statusList setTitle:@"状态"];
        [statusList show];
        
    } else if (tag == kBusinessTagGetCity){
        if ([City count] > 0) {
            [City removeAllObjects];
            for (NSDictionary *object in dataArray) {
                [City addObject:object];
            }
        } else {
            City = dataArray;
        }
        CGFloat xWidth = self.view.bounds.size.width - 20.0f;
        CGFloat yHeight = 272.0f;
        CGFloat yOffset = (self.view.bounds.size.height - yHeight)/2.0f;
        cityList = [[UIPopoverListView alloc] initWithFrame:CGRectMake(10, yOffset, xWidth, yHeight)];
        cityList.delegate = self;
        cityList.datasource = self;
        cityList.tag = 100004;
        cityList.listView.scrollEnabled = TRUE;
        [cityList setTitle:@"城市"];
        [cityList show];
        
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    //[HUD hide:YES];
    //[tableView reloadData];
    // [_slimeView endRefresh];
}

- (void)releasePopover{
    if(industryList){
        [industryList removeFromSuperview];
        industryList = nil;
        [industryBtn setBackgroundImage:[UIImage imageNamed:@"111"] forState:UIControlStateNormal];
    } else if (proviceList ){
        [proviceList removeFromSuperview];
        proviceList = nil;
      [proviceBtn setBackgroundImage:[UIImage imageNamed:@"111"] forState:UIControlStateNormal];
    } else if (statusList){
        [statusList removeFromSuperview];
        statusList = nil;
        [statusBtn setBackgroundImage:[UIImage imageNamed:@"111"] forState:UIControlStateNormal];
    } else if (cityList){
        [cityList removeFromSuperview];
        cityList = nil;
        [proviceBtn setBackgroundImage:[UIImage imageNamed:@"111"] forState:UIControlStateNormal];
    }
}

#pragma mark - NetworkModuleDelegate Methods
-(void)beginPost:(kBusinessTag)tag{
    
}
-(void)endPost:(NSString *)result business:(kBusinessTag)tag{
    NSLog(@"%s %d 收到数据:%@", __FUNCTION__, __LINE__, result);
    NSMutableDictionary *jsonDic = [result JSONValue];
    NSMutableArray *dataArray = [jsonDic objectForKey:@"object"];
	if (tag==kBusinessTagUserGetList ) {
       
        if ([[jsonDic objectForKey:@"success"] boolValue] == 0) {
            //数据异常处理
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.view makeToast:@"获取品牌失败"];
        } else {
            [self recivedCategoryList:dataArray];
        }
    }else if (tag == kBusinessTagUserGetListAgain){
        
        [_slimeView endRefresh];
        if ([[jsonDic objectForKey:@"success"] boolValue] == 0) {
            //数据异常处理
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.view makeToast:@"刷新商品失败"];
        } else {
            [dataList removeAllObjects];
             [self recivedCategoryList:dataArray];
        }
    } else if (tag == kBusinessTagUserGetEndRefreshList){
        
        //[_slimeView endRefresh];
        if ([[jsonDic objectForKey:@"success"] boolValue] == 0) {
            //数据异常处理
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.view makeToast:@"刷新商品失败"];
        } else {
            [dataList removeAllObjects];
            [self recivedEndRefreshList:dataArray];
        }
    } else  if (tag==kBusinessTagGetIndustry) {
        if ([[jsonDic objectForKey:@"success"] boolValue] == 1) {
            [self recivedTableList:dataArray business:tag];
        } else {
           // [self requestTableList:kBusinessTagGetIndustry];
        }
    } else if (tag==kBusinessTagGetProvince) {
        
        if ([[jsonDic objectForKey:@"success"] boolValue] == 1) {
            [self recivedTableList:dataArray business:tag];
        } else {
            //[self requestTableList:kBusinessTagGetProvince];
        }
    } else if (tag==kBusinessTagGetStatus) {
        if ([[jsonDic objectForKey:@"success"] boolValue] == 1) {
            [self recivedTableList:dataArray business:tag];
        } else {
           // [self requestTableList:kBusinessTagGetStatus];kBusinessTagGetCity
        }
    } else if (tag==kBusinessTagGetCity) {
        if ([[jsonDic objectForKey:@"success"] boolValue] == 1) {
            [self recivedTableList:dataArray business:tag];
        } else {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            // [self requestTableList:kBusinessTagGetStatus];
        }
    }
    [[NetworkModule sharedNetworkModule] cancel:tag];
}

-(void)errorPost:(NSError *)err business:(kBusinessTag)tag{
    NSLog(@"%s Error:%@", __FUNCTION__, @"连接数据服务器超时");
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法连接" message:@"您所在地的网络信号微弱，无法连接到服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    if (tag == kBusinessTagUserGetList) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } else if (tag == kBusinessTagUserGetListAgain) {
        start = [NSString stringWithString:startBak];
        [_slimeView endRefresh];
    } else if (tag == kBusinessTagGetStatus) {
         [MBProgressHUD hideHUDForView:self.view animated:YES];
    } else if (tag == kBusinessTagGetIndustry) {
         [MBProgressHUD hideHUDForView:self.view animated:YES];
    }else if (tag == kBusinessTagGetProvince) {
         [MBProgressHUD hideHUDForView:self.view animated:YES];
    } else if (tag == kBusinessTagGetCity) {
         [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
   [[NetworkModule sharedNetworkModule] cancel:tag]; 
}

#pragma mark - User Methods for Push

-(void) push1:(UIButton *)btn{
    
    chooseView.hidden = YES;
    //[chooseView removeFromSuperview];
    searchBar.hidden = NO;
    cancelBtn.hidden = NO;
    
}


-(void)dealloc {
    [tableView removeFromSuperview];
    tableView = nil;
    [_slimeView removeFromSuperview];
    [classBtn removeFromSuperview];
    _slimeView = nil;
    classBtn = nil;
    
     [industry removeAllObjects];
     [provce removeAllObjects];
     [status removeAllObjects];
     [City removeAllObjects];
    industry = nil;
    provce = nil;
    status = nil;
    City = nil;
    [moreCell removeFromSuperview];
    start = nil;
    limit = nil;
     [chooseArray removeAllObjects];
    chooseArray = nil;
     [dataList removeAllObjects];
    dataList = nil;
    startBak = nil;
    moreCell = nil;
    [industryList removeFromSuperview];
    [proviceList removeFromSuperview];
    [statusList removeFromSuperview];
    [cityList removeFromSuperview];
    
    industryList = nil;
    proviceList = nil;
    statusList = nil;
    cityList = nil;
    industryStr = nil;
    areaStr = nil;
    statusStr = nil;
   
   

    [chooseView removeFromSuperview];
    chooseView = nil;
    [searchBar removeFromSuperview];
    searchBar = nil;
     [[NSURLCache sharedURLCache] removeAllCachedResponses];
   
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   [[NSURLCache sharedURLCache] removeAllCachedResponses]; 
    
    
}



@end
