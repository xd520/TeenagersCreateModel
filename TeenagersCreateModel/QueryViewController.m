//
//  QueryViewController.m
//  TeenagersCreateModel
//
//  Created by Yonghui Xiong on 14-11-7.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "QueryViewController.h"
#import "AppDelegate.h"

@interface QueryViewController ()
{
    UIDatePicker *datePicker;
    UIDatePicker *timePicker;
    UIToolbar *tooBar;
    UIToolbar *timeTooBar;
    UILabel *dateLStarabel;
    UILabel *dateLEndabel;
    UIView *view1;
    UIView *view2;
    UISegmentedControl *segmentedControl;
    NSMutableArray *dataList;
    UITableView *table;
    NSMutableArray *dataListNot;
    UITableView *tableNot;
    BOOL hasMore;
    
    
}
@end

@implementation QueryViewController

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
    [leftBtn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    UINavigationItem *navibarItem = [[UINavigationItem alloc]init];
    navibarItem.title = @"查询资金变动";
    navibarItem.leftBarButtonItem= leftItem;
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
  
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"当日",@"历史",nil];
    segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    
    segmentedControl.frame = CGRectMake(20,74, ScreenWidth - 40, 40);
    if (segmentedControl.selectedSegmentIndex != 0 && segmentedControl.selectedSegmentIndex != 1) {
        segmentedControl.selectedSegmentIndex = 0;//设置默认选择项索引
    }
    
    
    segmentedControl.tintColor = [UIColor brownColor];
    
    segmentedControl.multipleTouchEnabled=NO;
    segmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
    
    
    [segmentedControl addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];
    
    view1 = [[UIView alloc] initWithFrame:CGRectMake(0,segmentedControl.frame.origin.y + segmentedControl.frame.size.height + 10, ScreenWidth, ScreenHeight - segmentedControl.frame.size.height - 49)];
    //view1.backgroundColor = [UIColor redColor];
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [view1 addGestureRecognizer:recognizer];
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, view1.frame.size.height)];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [table setBackgroundColor:[UIColor clearColor]];
    table.dataSource = self;
    table.delegate = self;
    
    
    [view1 addSubview:table];
    
    [self.view addSubview:view1];
    
    view2 = [[UIView alloc] initWithFrame:CGRectMake(0, segmentedControl.frame.origin.y + segmentedControl.frame.size.height, ScreenWidth, ScreenHeight - segmentedControl.frame.size.height - 9 - 20 - self.navigationController.navigationBar.frame.size.height)];
   // view2.backgroundColor = [UIColor redColor];
    view2.hidden = YES;
    
    UISwipeGestureRecognizer *recognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizerLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [view2 addGestureRecognizer:recognizerLeft];
    
    tableNot = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth,view2.frame.size.height - 40)];
    tableNot.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableNot setBackgroundColor:[UIColor clearColor]];
    tableNot.dataSource = self;
    tableNot.delegate = self;
    
    
    [view2 addSubview:tableNot];
    
    
    [self.view addSubview:view2];
    
    [self.view addSubview:segmentedControl];
    
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, view2.frame.size.height - 200, ScreenWidth, 200)];
    datePicker.backgroundColor = [UIColor whiteColor];
    datePicker.datePickerMode = UIDatePickerModeDate;
    timePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, view2.frame.size.height - 200, ScreenWidth, 200)];
    timePicker.backgroundColor = [UIColor whiteColor];
    timePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.hidden = YES;
    timePicker.hidden = YES;
    [view2 addSubview:timePicker];
    [view2 addSubview:datePicker];
    
    tooBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, view2.frame.size.height - 200 - 30, ScreenWidth, 40)];
    //tooBar.backgroundColor = [UIColor redColor];
    [tooBar setBackgroundImage:[UIImage imageNamed:@"title_bg"] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame = CGRectMake(ScreenWidth - 40, 5, 30, 30);
    [okBtn setImage:[UIImage imageNamed:@"ok"] forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(upDateView:) forControlEvents:UIControlEventTouchUpInside];
    okBtn.tag = 1;
    [tooBar addSubview:okBtn];
    
    UILabel *starLb= [[UILabel alloc] initWithFrame:CGRectMake(110,0, 100, 40)];
    starLb.font = [UIFont boldSystemFontOfSize:14];
    starLb.textAlignment = NSTextAlignmentCenter;
    starLb.text = @"起始日期";
    [tooBar addSubview:starLb];
    
    
    tooBar.hidden = YES;
    [view2 addSubview:tooBar];
    
    timeTooBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, view2.frame.size.height - 200 - 30, ScreenWidth, 40)];
    //tooBar.backgroundColor = [UIColor redColor];
    [timeTooBar setBackgroundImage:[UIImage imageNamed:@"title_bg"] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    UIButton *okBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    okBtn1.frame = CGRectMake(ScreenWidth - 40, 5, 30, 30);
    [okBtn1 setImage:[UIImage imageNamed:@"ok"] forState:UIControlStateNormal];
    [okBtn1 addTarget:self action:@selector(upDateView:) forControlEvents:UIControlEventTouchUpInside];
    okBtn1.tag = 2;
    [timeTooBar addSubview:okBtn1];
    
   UILabel *starLab = [[UILabel alloc] initWithFrame:CGRectMake(110,0, 100, 40)];
    starLab.font = [UIFont boldSystemFontOfSize:14];
    starLab.textAlignment = NSTextAlignmentCenter;
    starLab.text = @"结束日期";
    [timeTooBar addSubview:starLab];
    timeTooBar.hidden = YES;
    [view2 addSubview:timeTooBar];
    
    
    
    [self reloadView];
    
    //添加指示器及遮罩
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = YES; //加层阴影
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"加载中...";
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString *str =[self dateToStringDate:[NSDate date]];
        
        [self requestCategoryList:str withEnd:str withTag:kBusinessTagGetFundslist];
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });
   
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row;
    if (tableView ==table) {
    if ([dataList count] == 0) {
        row = 1;
    } else if (hasMore) {
        row = [dataList count] + 1;
    } else {
        row = [dataList count];
    }
       // row = [dataList count];
    } else if (tableView == tableNot) {
    
        if ([dataListNot count] == 0) {
            row = 1;
        } else if (hasMore) {
            row = [dataListNot count] + 1;
        } else {
            row = [dataListNot count];
        }
    
    }
    return row ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[tableView setScrollEnabled:NO]; tableView 不能滑动
    static NSString *RepairCellIdentifier = @"RepairCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RepairCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RepairCellIdentifier];
    }
    
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (tableView == table) {
        //发生时间
        if (dataList.count == indexPath.row) {
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0,0 , 320, 70)];
            backView.backgroundColor =[UIColor whiteColor];
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 280, 40)];
            lab.font = [UIFont systemFontOfSize:15];
            lab.text = @"无查询的记录";
            lab.textAlignment = NSTextAlignmentCenter;
            [backView addSubview:lab];
            [cell.contentView addSubview:backView];
        } else {
            
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0,0 , 320, 153)];
            backView.backgroundColor = [UIColor whiteColor];
            
            UILabel *baseLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,10 , 140, 13)];
            [baseLabel setFont:[UIFont systemFontOfSize:13]];
            //[baseLabel setTextColor:[ColorUtil colorWithHexString:@"dcdcdc"]];
            
            NSMutableString *str = [[NSMutableString alloc] initWithString:[[dataList objectAtIndex:[indexPath row]] objectForKey:@"FID_RQ"]];
            [str insertString:@"-" atIndex:4];
            [str insertString:@"-" atIndex:7];
            
            
            
            [baseLabel setText:[NSString stringWithFormat:@"发生时间:%@",str]];
            [backView addSubview:baseLabel];
            
            //币种
            UILabel *rmbLabel = [[UILabel alloc] initWithFrame:CGRectMake(240,10 , 60, 13)];
            [rmbLabel setFont:[UIFont systemFontOfSize:13]];
            rmbLabel.textAlignment = NSTextAlignmentRight;
            [rmbLabel setTextColor:[ColorUtil colorWithHexString:@"777777"]];
            
            [rmbLabel setText:[NSString stringWithFormat:@"币种:%@",[[dataList objectAtIndex:[indexPath row]] objectForKey:@"FID_BZ"]]];
            [backView addSubview:rmbLabel];
            
            // 摘要
            UILabel *mostLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,30 , 280, 13)];
            [mostLabel setFont:[UIFont systemFontOfSize:13]];
            //[mostLabel setTextColor:[ColorUtil colorWithHexString:@"dcdcdc"]];
            
            [mostLabel setText:[NSString stringWithFormat:@"摘要:%@",[[dataList objectAtIndex:[indexPath row]] objectForKey:@"FID_ZY"]]];
            [backView addSubview:mostLabel];
            
            
            // 收入金额
            UILabel *intoGoldLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,50 , 280, 13)];
            [intoGoldLabel setFont:[UIFont systemFontOfSize:13]];
            //[intoGoldLabel setTextColor:[ColorUtil colorWithHexString:@"dcdcdc"]];
            
            [intoGoldLabel setText:[NSString stringWithFormat:@"收入金额:%.2f",[[[dataList objectAtIndex:[indexPath row]] objectForKey:@"FID_SRJE"] floatValue]]];
            [backView addSubview:intoGoldLabel];
            
            
            // 付出金额
            UILabel *GoldLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,70 , 280, 13)];
            [GoldLabel setFont:[UIFont systemFontOfSize:13]];
            // [GoldLabel setTextColor:[ColorUtil colorWithHexString:@"dcdcdc"]];
            
            [GoldLabel setText:[NSString stringWithFormat:@"付出金额:%.2f",[[[dataList objectAtIndex:[indexPath row]] objectForKey:@"FID_FCJE"] floatValue]]];
            [backView addSubview:GoldLabel];
            
            
            // 本次资金余额
            UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,90 , 280, 13)];
            [countLabel setFont:[UIFont systemFontOfSize:13]];
            //[countLabel setTextColor:[ColorUtil colorWithHexString:@"dcdcdc"]];
            
            [countLabel setText:[NSString stringWithFormat:@"本次资金余额:%.2f",[[[dataList objectAtIndex:[indexPath row]] objectForKey:@"FID_BCZJYE"] floatValue]]];
            [backView addSubview:countLabel];
            
            // 流水号
            UILabel *waterLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,110 , 280, 13)];
            [waterLabel setFont:[UIFont systemFontOfSize:13]];
            waterLabel.textAlignment = NSTextAlignmentLeft;
            //[waterLabel setTextColor:[ColorUtil colorWithHexString:@"777777"]];
            
            [waterLabel setText:[NSString stringWithFormat:@"流水号:%@",[[dataList objectAtIndex:[indexPath row]] objectForKey:@"FID_LSH"]]];
            [backView addSubview:waterLabel];
            
            // 资金帐号
            
            
            UILabel *postTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 130, 280, 13)];
            postTimeLabel.font = [UIFont systemFontOfSize:13];
            postTimeLabel.textAlignment = NSTextAlignmentLeft;
            [postTimeLabel setText:[NSString stringWithFormat:@"资金帐号:%@",[[dataList objectAtIndex:indexPath.row] objectForKey:@"FID_ZJZH"]]];
            
            [backView addSubview:postTimeLabel];
            
            
            UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 152, 320, 1)];
            [subView setBackgroundColor:[ColorUtil colorWithHexString:@"dcdcdc"]];
            if ([indexPath row] != [dataList count] - 1) {
                [backView addSubview:subView];
            }
            
            [cell.contentView addSubview:backView];
        }
        
    } else if(tableView == tableNot) {
        //发生时间
        if (dataListNot.count == indexPath.row) {
           UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0,0 , 320, 70)];
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 280, 40)];
            lab.font = [UIFont systemFontOfSize:15];
            lab.text = @"无查询的记录";
            lab.textAlignment = NSTextAlignmentCenter;
            [backView addSubview:lab];
             [cell.contentView addSubview:backView];
        } else {
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0,0 , 320, 153)];
        backView.backgroundColor = [UIColor whiteColor];
        
        UILabel *baseLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,10 , 140, 13)];
        [baseLabel setFont:[UIFont systemFontOfSize:13]];
        //[baseLabel setTextColor:[ColorUtil colorWithHexString:@"dcdcdc"]];
        
        NSMutableString *str = [[NSMutableString alloc] initWithString:[[dataListNot objectAtIndex:[indexPath row]] objectForKey:@"FID_RQ"]];
        [str insertString:@"-" atIndex:4];
        [str insertString:@"-" atIndex:7];
        
        
        
        [baseLabel setText:[NSString stringWithFormat:@"发生时间:%@",str]];
        [backView addSubview:baseLabel];
        
        //币种
        UILabel *rmbLabel = [[UILabel alloc] initWithFrame:CGRectMake(240,10 , 60, 13)];
        [rmbLabel setFont:[UIFont systemFontOfSize:13]];
        rmbLabel.textAlignment = NSTextAlignmentRight;
        [rmbLabel setTextColor:[ColorUtil colorWithHexString:@"777777"]];
        
        [rmbLabel setText:[NSString stringWithFormat:@"币种:%@",[[dataListNot objectAtIndex:[indexPath row]] objectForKey:@"FID_BZ"]]];
        [backView addSubview:rmbLabel];
     
        // 摘要
        UILabel *mostLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,30 , 280, 13)];
        [mostLabel setFont:[UIFont systemFontOfSize:13]];
        //[mostLabel setTextColor:[ColorUtil colorWithHexString:@"dcdcdc"]];
        
        [mostLabel setText:[NSString stringWithFormat:@"摘要:%@",[[dataListNot objectAtIndex:[indexPath row]] objectForKey:@"FID_ZY"]]];
        [backView addSubview:mostLabel];
        
        
        // 收入金额
        UILabel *intoGoldLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,50 , 280, 13)];
        [intoGoldLabel setFont:[UIFont systemFontOfSize:13]];
        //[intoGoldLabel setTextColor:[ColorUtil colorWithHexString:@"dcdcdc"]];
        
        [intoGoldLabel setText:[NSString stringWithFormat:@"收入金额:%.2f",[[[dataListNot objectAtIndex:[indexPath row]] objectForKey:@"FID_SRJE"] floatValue]]];
        [backView addSubview:intoGoldLabel];
        
        
        // 付出金额
        UILabel *GoldLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,70 , 280, 13)];
        [GoldLabel setFont:[UIFont systemFontOfSize:13]];
        // [GoldLabel setTextColor:[ColorUtil colorWithHexString:@"dcdcdc"]];
        
        [GoldLabel setText:[NSString stringWithFormat:@"付出金额:%.2f",[[[dataListNot objectAtIndex:[indexPath row]] objectForKey:@"FID_FCJE"] floatValue]]];
        [backView addSubview:GoldLabel];
        
        
        // 本次资金余额
        UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,90 , 280, 13)];
        [countLabel setFont:[UIFont systemFontOfSize:13]];
        //[countLabel setTextColor:[ColorUtil colorWithHexString:@"dcdcdc"]];
        
        [countLabel setText:[NSString stringWithFormat:@"本次资金余额:%.2f",[[[dataListNot objectAtIndex:[indexPath row]] objectForKey:@"FID_BCZJYE"] floatValue]]];
        [backView addSubview:countLabel];
        
        // 流水号
        UILabel *waterLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,110 , 280, 13)];
        [waterLabel setFont:[UIFont systemFontOfSize:13]];
        waterLabel.textAlignment = NSTextAlignmentLeft;
        //[waterLabel setTextColor:[ColorUtil colorWithHexString:@"777777"]];
        
        [waterLabel setText:[NSString stringWithFormat:@"流水号:%@",[[dataListNot objectAtIndex:[indexPath row]] objectForKey:@"FID_LSH"]]];
        [backView addSubview:waterLabel];
        
        // 资金帐号
        
        
        UILabel *postTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 130, 280, 13)];
        postTimeLabel.font = [UIFont systemFontOfSize:13];
        postTimeLabel.textAlignment = NSTextAlignmentLeft;
        [postTimeLabel setText:[NSString stringWithFormat:@"资金帐号:%@",[[dataListNot objectAtIndex:indexPath.row] objectForKey:@"FID_ZJZH"]]];
       
        [backView addSubview:postTimeLabel];
        
        
        UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 152, 320, 1)];
        [subView setBackgroundColor:[ColorUtil colorWithHexString:@"dcdcdc"]];
        if ([indexPath row] != [dataListNot count] - 1) {
            [backView addSubview:subView];
        }
       
        [cell.contentView addSubview:backView];
        }
        
    }
    
    
    
    return cell;
}




-(void) segmentAction:(UISegmentedControl *)Seg{
    
    NSInteger Index = Seg.selectedSegmentIndex;
    NSLog(@"Index %li",(long)Index);
    if (Seg.selectedSegmentIndex == 0) {
        view2.hidden = YES;
        view1.hidden = NO;
    } else if(Seg.selectedSegmentIndex == 1){
        view1.hidden = YES;
        view2.hidden = NO;
        
    }
    
    
}

#pragma mark - Table Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    if (tableView == table) {
        if ([dataList count] == 0) {
            return tableView.frame.size.height;
        } else {
            if (row == [dataList count]) {
                return 70;
            } else {
                return 153;
            }
        }
    } else if (tableView == tableNot) {
        if ([dataListNot count] == 0) {
            return tableView.frame.size.height;
        } else {
            if (row == [dataListNot count]) {
                return 70;
            } else {
                return 153;
            }
            
        }
    }
    return 95 ;
}




-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)sender{
    if (sender.direction==UISwipeGestureRecognizerDirectionRight )
    {
        segmentedControl.selectedSegmentIndex = 1;
        view1.hidden = YES;
        view2.hidden = NO;
    }else if (sender.direction==UISwipeGestureRecognizerDirectionLeft ){
        segmentedControl.selectedSegmentIndex = 0;
        view2.hidden = YES;
        view1.hidden = NO;
    }
}

#pragma mark - Request Methods
//获取品牌列表
- (void)requestCategoryList:(NSString *)_userId  start:(NSDictionary *)_start limit:(NSString *)_limit tag:(kBusinessTag)_tag
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"请求品牌列表");
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
    [paraDic setObject:_userId forKey:@"head"];
    [paraDic setObject:_start forKey:@"jsonParamStr"];
    [paraDic setObject:_limit forKey:@"rtKeyListStr"];
    [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:_tag owner:self];
    
}

/*
- (void)tableView:(UITableView *)tbleView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    DetailViewController *goodsDetailViewController = [[DetailViewController alloc] init];
//    ;
//    goodsDetailViewController.titleName = [[dataList objectAtIndex:[indexPath row]] objectForKey:@"2010"] ;
//    goodsDetailViewController.name = [NSString stringWithFormat:@"委托日期：%@",[[dataList objectAtIndex:[indexPath row]] objectForKey:@"1898"]] ;
//    goodsDetailViewController.gqName = [NSString stringWithFormat:@"委托数量：%@",[[dataList objectAtIndex:[indexPath row]] objectForKey:@"684"]];
//    goodsDetailViewController.date = [NSString stringWithFormat:@"委托时间：%@",[[dataList objectAtIndex:[indexPath row]] objectForKey:@"750"]];
//    goodsDetailViewController.mark = [NSString stringWithFormat:@"委托价格：%@",[[dataList objectAtIndex:[indexPath row]] objectForKey:@"682"]];
//    goodsDetailViewController.describ =  [NSString stringWithFormat:@"成交金额:%@",[[dataList objectAtIndex:indexPath.row] objectForKey:@"795"]];
//    goodsDetailViewController.hidesBottomBarWhenPushed = YES;
//    [tbleView deselectRowAtIndexPath:indexPath animated:YES];
//    [self.navigationController pushViewController:goodsDetailViewController animated:YES];
    
}

*/



#pragma mark - Recived Methods
//处理品牌列表
- (void)recivedCategoryList:(NSMutableArray *)dataArray
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"处理品牌列表数据");
    if (dataList.count > 0) {
        [dataList removeAllObjects];
    }
    
    dataList = dataArray;
    
    [table reloadData];
}

- (void)recivedCategoryList1:(NSMutableArray *)dataArray
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"处理品牌列表数据");
    if ([dataListNot count] > 0) {
        for (NSDictionary *object in dataArray) {
            [dataListNot addObject:object];
        }
    } else {
        dataListNot = dataArray;
    }
    [tableNot reloadData];
}


#pragma mark - NetworkModuleDelegate Methods
-(void)beginPost:(kBusinessTag)tag{
    
}
-(void)endPost:(NSString *)result business:(kBusinessTag)tag{
    NSLog(@"%s %d 收到数据:%@", __FUNCTION__, __LINE__, result);
    NSMutableDictionary *jsonDic = [result JSONValue];
    NSMutableArray *dataArray = [jsonDic objectForKey:@"object"];
	if (tag==kBusinessTagGetFundslist ) {
       [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([[jsonDic objectForKey:@"success"] boolValue]== 0) {
            //数据异常处理
            //[self.view makeToast:@"获取品牌失败"];
            //[HUD hide:YES];
        } else {
            [self recivedCategoryList:dataArray];
        }
    }else if (tag==kBusinessTagGetFundslistAgain) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([[jsonDic objectForKey:@"success"] boolValue]== 0) {
            //数据异常处理
            //[HUD hide:YES];
            //[self.view makeToast:@"获取品牌失败222"];
        } else {
            if (dataListNot.count > 0) {
                [dataListNot removeAllObjects];
            }
            
            [self recivedCategoryList1:dataArray];
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




-(void)reloadView {
    
    //起始日期
    
    
    UILabel *starLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,0, 60, 40)];
    starLabel.font = [UIFont systemFontOfSize:12];
    starLabel.text = @"起始日期:";
    [view2 addSubview:starLabel];
    
    dateLStarabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 5, 70 , 30)];
    dateLStarabel.backgroundColor = [UIColor whiteColor];
    
    dateLStarabel.layer.borderWidth = 1;
    dateLStarabel.layer.borderColor = [[UIColor blackColor] CGColor];
    //dateLStarabel.layer.cornerRadius = 5;
    
    dateLStarabel.lineBreakMode = NSLineBreakByTruncatingTail;
    dateLStarabel.font = [UIFont systemFontOfSize:10];
    dateLStarabel.textAlignment = NSTextAlignmentLeft;
    dateLStarabel.text = [self dateToStringDate:[NSDate date]];
    dateLStarabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callPhone:)];
    [dateLStarabel addGestureRecognizer:singleTap];
    
    
    [view2 addSubview:dateLStarabel];
    
    //截止日期
    
    UILabel *endLabel = [[UILabel alloc] initWithFrame:CGRectMake(140,0 , 70, 40)];
    endLabel.font = [UIFont systemFontOfSize:12];
    endLabel.text = @"截止日期:";
    [view2 addSubview:endLabel];
    
    dateLEndabel = [[UILabel alloc] initWithFrame:CGRectMake(195, 5, 70, 30)];
    dateLEndabel.backgroundColor = [UIColor whiteColor];
    dateLEndabel.layer.borderWidth = 1;
    dateLEndabel.layer.borderColor = [[UIColor blackColor] CGColor];
    dateLEndabel.font = [UIFont systemFontOfSize:10];
    dateLEndabel.textAlignment = NSTextAlignmentLeft;
    dateLEndabel.text = [self dateToStringDate:[NSDate date]];
    dateLEndabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callPhone1:)];
    [dateLEndabel addGestureRecognizer:singleTap1];
    [view2 addSubview:dateLEndabel];
 
    
    UIButton *queryBtn = [[UIButton alloc] initWithFrame:CGRectMake(275, 5, 35, 30)];
    queryBtn.backgroundColor = [UIColor grayColor];
    queryBtn.layer.borderWidth = 1;
    queryBtn.layer.borderColor = [[UIColor blackColor] CGColor];
    queryBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [queryBtn setTitle:@"查询" forState:UIControlStateNormal];
    [queryBtn addTarget:self action:@selector(queryBtn) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:queryBtn];
    
}

- (NSString *)dateToStringDate:(NSDate *)Date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    //HH:mm:ss zzz
    NSString *destDateString = [dateFormatter stringFromDate:Date];
   // destDateString = [destDateString substringToIndex:10];
    
    return destDateString;
}


- (NSDate *)dateFromString:(NSString *)dateString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *date1=[formatter dateFromString:dateString];
    
    NSDate *newDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([date1 timeIntervalSinceReferenceDate] + 8*3600)];
    return newDate;
}


-(void) upDateView:(UIButton *)btn{
    if (btn.tag == 1) {
      tooBar.hidden = YES;
    datePicker.hidden = YES;
    dateLStarabel.text = [self dateToStringDate:datePicker.date];
    } else if (btn.tag == 2){
        timeTooBar.hidden = YES;
        timePicker.hidden = YES;
        dateLEndabel.text = [self dateToStringDate:timePicker.date];
    
    }
}

- (void)callPhone:(UIGestureRecognizer *)sender
{
    //UIView *view = [sender view];
    tooBar.hidden = NO;
    datePicker.hidden = NO;
    timeTooBar.hidden = YES;
    timePicker.hidden = YES;
    datePicker.date = [self dateFromString:dateLStarabel.text];
    
}

- (void)alterMessage:(NSString *)messageString{
    
    UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:messageString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [al show];
}


- (void)countDay {
    
    NSDate *nowDate = [NSDate date];
    NSDate *beginDate = [self dateFromString:dateLStarabel.text];
    NSDate *endDate = [self dateFromString:dateLEndabel.text];
    NSDate *earlyDate = [beginDate earlierDate:endDate];
    NSDate *laterDate =[endDate laterDate:nowDate];
  
    
    
    
    
    if ([earlyDate isEqualToDate:endDate] && ![earlyDate isEqualToDate:beginDate]) {
        
        [self alterMessage:@"开始时间不得晚于结束时间"];
        return;
        
    } else if (![nowDate isEqualToDate:laterDate]&&[endDate isEqualToDate:laterDate]) {
    
        [self alterMessage:@"结束时间不得晚于今天"];
        return;
    } else {
        
        //添加指示器及遮罩
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.dimBackground = YES; //加层阴影
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"加载中...";
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            [self requestCategoryList:dateLStarabel.text withEnd:dateLEndabel.text withTag:kBusinessTagGetFundslistAgain];
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
        });
        

    
    
    }
    
    
    /*
    NSDateComponents *beginComponets = [[NSCalendar autoupdatingCurrentCalendar] components:NSWeekdayCalendarUnit fromDate:beginDate];
    NSInteger beginWeekDay = [beginComponets weekday];
    
    NSDateComponents *endComponets = [[NSCalendar autoupdatingCurrentCalendar] components:NSWeekdayCalendarUnit fromDate:endDate];
    NSInteger endWeekDay = [endComponets weekday];
    
    if (beginWeekDay == 1 || beginWeekDay == 7 || endWeekDay == 1 || endWeekDay == 7) {
        
        [self alterMessage:@"结束或开始时间不得为周末"];
        return;
        
    }
    
    NSTimeInterval time = [endDate timeIntervalSinceDate:beginDate];
    
    float oneWeekDay = 7 - beginWeekDay;
    
    float allDay = time / (24 * 60 * 60);
    
    float day = 0.0;
    
    if(allDay > oneWeekDay + 2){
        float otherDay = allDay - (oneWeekDay + 2);
        
        float ResidualDay = otherDay - ((int)otherDay / 7) * 2;
        
        day = ResidualDay + oneWeekDay;
    }else{
        day = endWeekDay - beginWeekDay;
    }
    
    
    //dateLTotalabel.text = [NSString stringWithFormat:@"%d天",(int)day];
     */
}


- (void)callPhone1:(UITouch *)sender
{
    timeTooBar.hidden = NO;
    timePicker.hidden = NO;
    tooBar.hidden = YES;
    datePicker.hidden = YES;
    timePicker.date = [self dateFromString:dateLEndabel.text];
}

- (void)requestCategoryList:(NSString *)start withEnd:(NSString *)end withTag:(kBusinessTag)_tag
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"请求品牌列表");
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
    [paraDic setObject:start forKey:@"ksrq"];
    [paraDic setObject:end forKey:@"jsrq"];
    [paraDic setObject:@"-1" forKey:@"rowcount"];
    [paraDic setObject:@"0" forKey:@"rowindex"];
    [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:_tag owner:self];
    
}



-(void)queryBtn{
    [self countDay];
    

}

-(void)push {
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
     [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

-(void)dealloc {
    [datePicker removeFromSuperview];
    datePicker = nil;
    [timePicker removeFromSuperview];
    timePicker = nil;
    [tooBar removeFromSuperview];
    tooBar = nil;
    [timeTooBar removeFromSuperview];
    timeTooBar = nil;
    [dateLStarabel removeFromSuperview];
    dateLStarabel = nil;
    [dateLEndabel removeFromSuperview];
    dateLEndabel = nil;

    [view1 removeFromSuperview];
    view1 = nil;
    [view2 removeFromSuperview];
    view2 = nil;
    [segmentedControl removeFromSuperview];
    segmentedControl = nil;
    [table removeFromSuperview];
    table = nil;
    [tableNot removeFromSuperview];
    tableNot = nil;
    [dataList removeAllObjects];
    dataList = nil;
    [dataListNot removeAllObjects];
    dataListNot = nil;
    hasMore = Nil;
    
}


@end
