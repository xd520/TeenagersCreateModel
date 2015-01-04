//
//  SecondViewController.m
//  TeenagersCreateModel
//
//  Created by mac on 14-10-11.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "SecondViewController.h"
#import "ColorUtil.h"
#import "DropDownListView.h"
#import "UIImageView+WebCache.h"
#import "AsyncImageView.h"

@interface SecondViewController ()
{
    NSMutableArray *chooseArray ;
}
@end

@implementation SecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        self.navigationItem.hidesBackButton = YES;
        
        self.title = @"设置";
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
    [self.navigationController setNavigationBarHidden:YES];
    
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, 44)];
    navBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navBar];
    
    
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(10, 11 , 42, 22);
//    [leftBtn setImage:[UIImage imageNamed:@"head_icon_back"] forState:UIControlStateNormal];
    [leftBtn setTitle:@"b" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftBtn setBackgroundColor:[UIColor redColor]];
    [leftBtn addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    [navBar addSubview:leftBtn];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
#endif
    
    chooseArray = [NSMutableArray arrayWithArray:@[
                                                   @[@"童明城",@"童赟",@"童林杰",@"老萧狗"]
                                                   ]];
    
    DropDownListView * dropDownView = [[DropDownListView alloc] initWithFrame:CGRectMake(0,64, 320, 30) dataSource:self delegate:self];
    dropDownView.mSuperView = self.view;
    
    
    //[self.view addSubview:dropDownView];
    
    
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(50, 200, 220, 100)];
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://218.66.59.169:1577/res/images/slider/Slide4.png"]];
    img.image = [UIImage imageWithData:data];
    //[UIImagePNGRepresentation(image)
    
    
     
    [self.view addSubview:img];
    
}

#pragma mark - AsyncImageView Delegate Methods
- (void)succ:(AsyncImageView *)sender
{
    NSLog(@"****");
}
- (void)fal:(NSError *)sender
{
   NSLog(@"xxxxx");
}





-(void) push:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}


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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
