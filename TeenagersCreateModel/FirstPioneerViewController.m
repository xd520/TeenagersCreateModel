//
//  FirstPioneerViewController.m
//  TeenagersCreateModel
//
//  Created by mac on 14-10-11.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "FirstPioneerViewController.h"
#import "AppDelegate.h"
#import "DropDownListView.h"

@interface FirstPioneerViewController ()
{
    //筛选条件 导航条
    NSMutableArray *chooseArray ;
    
    //tableView  中的元素
    MBProgressHUD *HUD;
    UITableView *tableView;
    NSString *start;
    NSString *startBak;
    NSString *limit;
    NSMutableArray *dataList;
    BOOL hasMore;
    UITableViewCell *moreCell;
    SRRefreshView   *_slimeView;
    UIButton *classBtn;
    
    
}
@end

@implementation FirstPioneerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"领投人";
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
    start = @"1";
    limit = @"10";
    // 导航栏右边按钮的设置
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(ScreenWidth - 41, 11, 31, 22);
    [leftBtn setImage:[UIImage imageNamed:@"head_icon_back"] forState:UIControlStateNormal];
    //[leftBtn addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:leftBtn];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
#endif
    
    // 筛选条件框的设置
    chooseArray = [NSMutableArray arrayWithArray:@[
                                                   @[@"童明城",@"童赟",@"童林杰",@"老萧狗",@"童明城",@"童赟",@"童林杰",@"老萧狗"],@[@"童明城",@"童赟",@"童林杰",@"老萧狗"],
                                                   @[@"郏童熙",@"胥童嘉",@"郑嘉琦"]
                                                   ]];
    
    DropDownListView * dropDownView = [[DropDownListView alloc] initWithFrame:CGRectMake(0,0, ScreenWidth, 30) dataSource:self delegate:self];
    dropDownView.mSuperView = self.view;
    [self.view addSubview:dropDownView];
    //添加tableView
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, dropDownView.frame.size.height, ScreenWidth, ScreenHeight - 64 - 30 - 49)];
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
    
    
   [self requestCategoryList:start limit:limit tag:kBusinessTagUserGetList];
    //添加指示器及遮罩
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.dimBackground = YES;
    HUD.delegate = self;
    HUD.labelText = @"登录中";
    [HUD show:YES];
    [self.view addSubview:HUD];
   
}


#pragma mark - slimeRefresh delegate
- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    startBak = [NSString stringWithString:start];
    start = @"1";
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
                   // [self requestCategoryList:start limit:limit tag:kBusinessTagUserGetList];
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
                [backView setBackgroundColor:[ColorUtil colorWithHexString:@"fdfdfd"]];
                
//                AsynImageView *imageView1 = [[AsynImageView alloc] initWithFrame:CGRectMake(5, 5 , 60, 60)];
//                imageView1.placeholderImage = [UIImage imageNamed:@"xd1"];
//                imageView1.imageURL = [NSString stringWithFormat:@"%@%@",ICONSURL,[[[dataList objectAtIndex:indexPath.row] objectForKey:@"DETAIL"] objectForKey:@"TX"]];
//                if (imageView1.image == nil) {
//                    imageView1.image = [UIImage imageNamed:@"pic_listshibai"];
//                }
//                
//                
//                [backView addSubview:imageView1];
                
                //品牌
                UILabel *brandLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 220, 13)];
                brandLabel.font = [UIFont boldSystemFontOfSize:13];
                [brandLabel setTextColor:[ColorUtil colorWithHexString:@"1b1b1b"]];
                [brandLabel setBackgroundColor:[UIColor clearColor]];
                brandLabel.text = [[[dataList objectAtIndex:indexPath.row] objectForKey:@"DETAIL"] objectForKey:@"XM"];
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
                
                
                UILabel *issuePriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 33, 70, 10)];
                issuePriceLabel.font = [UIFont systemFontOfSize:10];
                [issuePriceLabel setTextColor:[ColorUtil colorWithHexString:@"1b1b1b"]];
                [issuePriceLabel setBackgroundColor:[UIColor clearColor]];
                issuePriceLabel.text = [NSString stringWithFormat:@"项目简介：%@",[[[dataList objectAtIndex:indexPath.row] objectForKey:@"DETAIL"] objectForKey:@"ZWJS"]];
                [backView addSubview:issuePriceLabel];
                //发行日期
                
                UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 33, 100, 10)];
                dateLabel.font = [UIFont systemFontOfSize:10];
                [dateLabel setTextColor:[ColorUtil colorWithHexString:@"1b1b1b"]];
                [dateLabel setBackgroundColor:[UIColor clearColor]];
                dateLabel.text = [NSString stringWithFormat:@"发行日期：%@",[[[dataList objectAtIndex:indexPath.row] objectForKey:@"DETAIL"] objectForKey:@"DS"]];
                [backView addSubview:dateLabel];
                
                //股权代码
                
                UILabel *codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 50, 110, 10)];
                codeLabel.font = [UIFont systemFontOfSize:10];
                [codeLabel setTextColor:[ColorUtil colorWithHexString:@"1b1b1b"]];
                [codeLabel setBackgroundColor:[UIColor clearColor]];
                codeLabel.text = [NSString stringWithFormat:@"股权代码：%@",[[dataList objectAtIndex:indexPath.row] objectForKey:@"KHH"]];
                [backView addSubview:codeLabel];
                //股权名称
                
                UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(190, 50, 90, 10)];
                nameLabel.font = [UIFont systemFontOfSize:10];
                [nameLabel setTextColor:[ColorUtil colorWithHexString:@"1b1b1b"]];
                [nameLabel setBackgroundColor:[UIColor clearColor]];
                nameLabel.text = [NSString stringWithFormat:@"股权名称：%@",[[[dataList objectAtIndex:indexPath.row] objectForKey:@"DETAIL"] objectForKey:@"DS"]];
                [backView addSubview:nameLabel];
                
                
                
                
                UILabel *CPJJLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 35, 200, 13)];
                CPJJLabel.numberOfLines = 0;
                CPJJLabel.font = [UIFont systemFontOfSize:13];
                [CPJJLabel setTextColor:[ColorUtil colorWithHexString:@"1b1b1b"]];
                [CPJJLabel setBackgroundColor:[UIColor clearColor]];
                //CPJJLabel.text = [NSString stringWithFormat:@"你是%d猴子派来的救兵吗？",[indexPath row]];
                // CPJJLabel.text = [[[[dataList objectAtIndex:[indexPath row]] objectForKey:@"xmlObj"] objectForKey:@"CPJJ"] objectForKey:@"value"];
                [backView addSubview:CPJJLabel];
                
                
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
                //[self requestCategoryList:start limit:limit tag:kBusinessTagUserGetList];
                [tbleView deselectRowAtIndexPath:indexPath animated:YES];
            }
        }
    } else {
//        DetailViewController *goodsDetailViewController = [[DetailViewController alloc] init];
//        ;
//        // goodsDetailViewController.title = [[[dataList objectAtIndex:indexPath.row] objectForKey:@"DETAIL"] objectForKey:@"XMMC"];
//        goodsDetailViewController.titleName = [[[dataList objectAtIndex:indexPath.row] objectForKey:@"DETAIL"] objectForKey:@"XMMC"] ;
//        goodsDetailViewController.preductDes = [NSString stringWithFormat:@"发行日期：%@",[[[dataList objectAtIndex:indexPath.row] objectForKey:@"DETAIL"] objectForKey:@"XMJS"]];
//        goodsDetailViewController.desc = [NSString stringWithFormat:@"发行价：%@",[[[dataList objectAtIndex:indexPath.row] objectForKey:@"DETAIL"] objectForKey:@"LD"]];
//        goodsDetailViewController.image =  [NSString stringWithFormat:@"%@",[[[dataList objectAtIndex:indexPath.row] objectForKey:@"DETAIL"] objectForKey:@"LOGO"]];
//        goodsDetailViewController.hidesBottomBarWhenPushed = YES;
//        [tbleView deselectRowAtIndexPath:indexPath animated:YES];
//        [self.navigationController pushViewController:goodsDetailViewController animated:YES];
    }
}


#pragma mark - 筛选条件 Methods

#pragma mark -- dropDownListDelegate
-(void) chooseAtSection:(NSInteger)section index:(NSInteger)index
{
    NSLog(@"童大爷选了section:%ld ,index:%ld",section,index);
}

#pragma mark -- dropdownList DataSource
-(NSInteger)numberOfSections
{
    return [chooseArray count];
}
-(NSInteger)numberOfRowsInSection:(NSInteger)section
{
    NSArray *arry =chooseArray[section];
    return [arry count];
}
-(NSString *)titleInSection:(NSInteger)section index:(NSInteger) index
{
    return chooseArray[section][index];
}
-(NSInteger)defaultShowSection:(NSInteger)section
{
    return 0;
}





#pragma mark - Request Methods
//获取品牌列表
- (void)requestCategoryList:(NSString *)_start limit:(NSString *)_limit tag:(kBusinessTag)_tag
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"请求品牌列表");
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
    
    //获取类别信息
    
    [paraDic setObject:@"cxZCLTRXX" forKey:@"objectName"];
    [paraDic setObject:@"{\"SUBCLASS\":\"0101\"}" forKey:@"jsonParamStr"];
    [paraDic setObject:_limit forKey:@"batchSize"];
    [paraDic setObject:_start forKey:@"batchNo"];
    [paraDic setObject:@"True" forKey:@"queryCount"];
    
    
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
    [HUD hide:YES];
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
	if (tag==kBusinessTagUserGetList ) {
        [HUD hide:YES];
        if ([[jsonDic objectForKey:@"success"] boolValue] == 0) {
            //数据异常处理
            [self.view makeToast:@"获取品牌失败"];
        } else {
            [self recivedCategoryList:dataArray];
        }
    }else if (tag == kBusinessTagUserGetListAgain){
        [HUD hide:YES];
        [_slimeView endRefresh];
        if ([[jsonDic objectForKey:@"success"] boolValue] == 0) {
            //数据异常处理
            [self.view makeToast:@"刷新商品失败"];
        } else {
            [dataList removeAllObjects];
            [self recivedCategoryList:dataArray];
        }
    }
}

-(void)errorPost:(NSError *)err business:(kBusinessTag)tag{
    NSLog(@"%s Error:%@", __FUNCTION__, @"连接数据服务器超时");
    [HUD hide:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法连接" message:@"您所在地的网络信号微弱，无法连接到服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    if (tag == kBusinessTagUserGetList) {
        [HUD hide:YES];
    } else if (tag == kBusinessTagUserGetListAgain) {
        start = [NSString stringWithString:startBak];
        [_slimeView endRefresh];
    }
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
