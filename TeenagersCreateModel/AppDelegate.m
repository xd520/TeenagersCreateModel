//
//  AppDelegate.m
//  TeenagersCreateModel
//
//  Created by mac on 14-10-11.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "ProjectIntroductionViewController.h"
#import "FirstPioneerViewController.h"
#import "IndividualCenterViewController.h"
#import "MyAccountViewController.h"
#import "SDWebImageManager.h"
#import "ColorUtil.h"
#import "CPVSTabBarViewController.h"

@implementation AppDelegate
@synthesize osTabVC;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //设置内存
            int cacheSizeMemory = 1*1024*1024; // 4MB
            int cacheSizeDisk = 5*1024*1024; // 32MB
            NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:cacheSizeMemory diskCapacity:cacheSizeDisk diskPath:@"nsurlcache"] ;
            [NSURLCache setSharedURLCache:sharedCache];
    
    
    _array = [[NSMutableArray alloc] init];
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.osTabVC = [self getRootViewControler];
    self.window.rootViewController = self.osTabVC;
    
    _window.backgroundColor = [UIColor whiteColor];
  
    
    
	
      [_window makeKeyAndVisible];
    
 //是否要加入引导页
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    //CFShow((__bridge CFTypeRef)(infoDic));
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
     NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];

    NSString *str = [userDefault objectForKey:@"verson"];
    
    if (![currentVersion isEqualToString:str]) {
       [self showIntroWithCrossDissolve];
       
        [userDefault setObject:currentVersion forKey:@"verson"];
         [userDefault synchronize];
    }
    
    
    
    return YES;
    
}


- (CPVSTabBarViewController *)getRootViewControler
{
    
    CPVSTabBarViewController *tabbarController = [[CPVSTabBarViewController alloc] init];
    FirstViewController *vcMessage = [[FirstViewController alloc] init];
    
    UINavigationController *ncMessage= [[UINavigationController alloc] initWithRootViewController:vcMessage];
    [ncMessage.navigationBar setBackgroundImage:[UIImage imageNamed:@"title_bg"] forBarMetrics:UIBarMetricsDefault];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 220, 30)];
    lab.font = [UIFont boldSystemFontOfSize:20];
    lab.textColor = [UIColor whiteColor];
    lab.text = @"首 页";
    lab.textAlignment = NSTextAlignmentCenter;
    [ncMessage.navigationBar addSubview:lab];
    ncMessage.navigationBar.translucent=NO;//wujy修改
    // RemindViewController *vcRemind = [[[RemindViewController alloc] initWithNibName:@"RemindViewController" bundle:nil] autorelease];
    ProjectIntroductionViewController *vcRemind=[[ProjectIntroductionViewController alloc] init];
    //app.ncMessage=ncMessage;
    UINavigationController *ncRemind = [[UINavigationController alloc] initWithRootViewController:vcRemind];
    [ncRemind.navigationBar setBackgroundImage:[UIImage imageNamed:@"title_bg"] forBarMetrics:UIBarMetricsDefault];
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 220, 30)];
    lab1.font = [UIFont boldSystemFontOfSize:20];
    lab1.textColor = [UIColor whiteColor];
    lab1.text = @"我的投资";
    lab1.textAlignment = NSTextAlignmentCenter;
    [ncRemind.navigationBar addSubview:lab1];
    
    ncRemind.navigationBar.translucent=NO;//wujy修改
    ncRemind.navigationBar.hidden = NO;
    IndividualCenterViewController *vcApplication = [[IndividualCenterViewController alloc] init];
    UINavigationController *ncApplication = [[UINavigationController alloc] initWithRootViewController:vcApplication];
    [ncApplication.navigationBar setBackgroundImage:[UIImage imageNamed:@"title_bg"] forBarMetrics:UIBarMetricsDefault];
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 220, 30)];
    lab2.text = @"个人中心";
    lab2.font = [UIFont boldSystemFontOfSize:20];
    lab2.textColor = [UIColor whiteColor];
    lab2.textAlignment = NSTextAlignmentCenter;
    [ncApplication.navigationBar addSubview:lab2];
    ncApplication.navigationBar.translucent=NO;//wujy修改
    // AddressListViewController *vcAddressList = [[[AddressListViewController alloc] init] autorelease];
    
    MyAccountViewController *vcAddressList=[[MyAccountViewController alloc]init];
    UINavigationController *ncAddressList = [[UINavigationController alloc] initWithRootViewController:vcAddressList];
    [ncAddressList.navigationBar setBackgroundImage:[UIImage imageNamed:@"title_bg"] forBarMetrics:UIBarMetricsDefault];
    UILabel *lab3 = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 220, 30)];
    lab3.text = @"资 讯";
    lab3.font = [UIFont boldSystemFontOfSize:20];
    lab3.textColor = [UIColor whiteColor];
    lab3.textAlignment = NSTextAlignmentCenter;
    [ncAddressList.navigationBar addSubview:lab3];
    
    ncAddressList.navigationBar.translucent=NO;//wujy修改
    //    PersonCenterViewController *vcPersonCenter = [[[PersonCenterViewController alloc] init] autorelease];
    //    MyPersonInfoController *vcPersonCenter = [[MyPersonInfoController alloc] init];
    //    UINavigationController *ncPersonCenter = [[UINavigationController alloc] initWithRootViewController:vcPersonCenter];
    //    ncPersonCenter.navigationBar.translucent=NO;//wujy修改
    //    vcPersonCenter.delegate = self;
    
    ncMessage.delegate = self;
    ncRemind.delegate = self;
    ncApplication.delegate = self;
    ncAddressList.delegate = self;
    
    
    [tabbarController setViewControllers:[NSArray arrayWithObjects: ncMessage,
                                          ncRemind,
                                          ncApplication,
                                          ncAddressList,
                                          
                                          nil]];
    
    NSMutableArray *tbNormalArray = [NSMutableArray arrayWithCapacity:10];
    for (int i = 1; i <= 4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"foot_btn%d", i]];
        [tbNormalArray addObject:image];
    }
    if([[UIDevice currentDevice].systemVersion compare:@"7.0"]!=NSOrderedAscending) {//NSComparisonResult
        tabbarController.tabBar.translucent=NO;
    }
    
    //[tabbarController setTabBarBackgroundImage:[UIImage imageNamed:@"title_bg"]];
    [tabbarController setItemImages:tbNormalArray];
    
    NSMutableArray *tbHighlightArray = [NSMutableArray arrayWithCapacity:10];
    for (int i = 1; i <= 4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"foot_hover%d", i]];
        [tbHighlightArray addObject:image];
    }
    NSMutableArray *txtArr=[NSMutableArray arrayWithObjects:@"首页",@"我的投资",@"个人中心",@"资讯",nil];
    
    [tabbarController setItemHighlightedImages:tbHighlightArray];
    //[tabbarController setTabBarItemsImage:tbHighlightArray];
    [tabbarController setTabBarItemsTitle:txtArr];
    //[tabbarController.tabBar setSelectedImageTintColor:[ColorUtil colorWithHexString:@"#1b89e6"]];
    NSArray *colorArr = [[NSArray alloc] initWithObjects:[ColorUtil colorWithHexString:@"#f26c60"],[ColorUtil colorWithHexString:@"#f26c60"],[ColorUtil colorWithHexString:@"#f26c60"],[ColorUtil colorWithHexString:@"#f26c60"], nil];
    int colorIndex = 0;
    for (UITabBarItem *tabbarItem in tabbarController.tabBar.items){
        [tabbarItem setTitleTextAttributes:@{UITextAttributeTextColor:colorArr[colorIndex]} forState:UIControlStateHighlighted];
        colorIndex++;
    }
    UILabel *line=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
    [line setBackgroundColor:[UIColor grayColor]];
    [tabbarController.tabBar addSubview:line];
    tabbarController.delegate = (id <UITabBarControllerDelegate>)self;
    tabbarController.tabBar.clipsToBounds=YES;
    [tabbarController setSelectionIndicatorImage:nil];
    [tabbarController removeSelectionIndicator];
    [tabbarController showBadge];
    
    [tabbarController.selectedViewController.tabBarController.tabBar.items objectAtIndex:2];
    
    
    //app.navtab=tabbarController;
    return tabbarController;
}



//引导页

//- (void)viewDidAppear:(BOOL)animated {
//    [self showIntroWithCrossDissolve];
//    
//}

- (void)showIntroWithCrossDissolve {
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"Hello world";
    page1.desc = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
    page1.bgImage = [UIImage imageNamed:@"1"];
    page1.titleImage = [UIImage imageNamed:@"original"];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"This is page 2";
    page2.desc = @"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore.";
    page2.bgImage = [UIImage imageNamed:@"2"];
    page2.titleImage = [UIImage imageNamed:@"supportcat"];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"This is page 3";
    page3.desc = @"Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.";
    page3.bgImage = [UIImage imageNamed:@"3"];
    page3.titleImage = [UIImage imageNamed:@"femalecodertocat"];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) andPages:@[page1,page2,page3]];
    
    [intro setDelegate:self];
    [intro showInView:self.window animateDuration:0.0];
}

- (void)showBasicIntroWithBg {
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"Hello world";
    page1.desc = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
    page1.titleImage = [UIImage imageNamed:@"original"];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"This is page 2";
    page2.desc = @"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore.";
    page2.titleImage = [UIImage imageNamed:@"supportcat"];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"This is page 3";
    page3.desc = @"Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.";
    page3.titleImage = [UIImage imageNamed:@"femalecodertocat"];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.window.bounds andPages:@[page1,page2,page3]];
    intro.bgImage = [UIImage imageNamed:@"introBg"];
    
    [intro setDelegate:self];
    [intro showInView:self.window animateDuration:0.0];
}

- (void)showBasicIntroWithFixedTitleView {
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"Hello world";
    page1.desc = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"This is page 2";
    page2.desc = @"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore.";
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"This is page 3";
    page3.desc = @"Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.";
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.window.bounds andPages:@[page1,page2,page3]];
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"original"]];
    intro.titleView = titleView;
    intro.backgroundColor = [UIColor colorWithRed:0.0f green:0.49f blue:0.96f alpha:1.0f]; //iOS7 dark blue
    
    [intro setDelegate:self];
    [intro showInView:self.window animateDuration:0.0];
}

- (void)showCustomIntro {
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"Hello world";
    page1.desc = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
    page1.titleImage = [UIImage imageNamed:@"original"];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"This is page 2";
    page2.titlePositionY = 180;
    page2.desc = @"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore.";
    page2.descPositionY = 160;
    page2.titleImage = [UIImage imageNamed:@"supportcat"];
    page2.imgPositionY = 70;
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"This is page 3";
    page3.titleFont = [UIFont fontWithName:@"Georgia-BoldItalic" size:20];
    page3.titlePositionY = 220;
    page3.desc = @"Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit.";
    page3.descFont = [UIFont fontWithName:@"Georgia-Italic" size:18];
    page3.descPositionY = 200;
    page3.titleImage = [UIImage imageNamed:@"femalecodertocat"];
    page3.imgPositionY = 100;
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.window.bounds andPages:@[page1,page2,page3]];
    intro.backgroundColor = [UIColor colorWithRed:1.0f green:0.58f blue:0.21f alpha:1.0f]; //iOS7 orange
    
    intro.pageControlY = 100.0f;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setBackgroundImage:[UIImage imageNamed:@"skipButton"] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake((320-230)/2, [UIScreen mainScreen].bounds.size.height - 60, 230, 40)];
    [btn setTitle:@"SKIP NOW" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    intro.skipButton = btn;
    
    [intro setDelegate:self];
    [intro showInView:self.window animateDuration:0.0];
}

- (void)showIntroWithCustomView {
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"Hello world";
    page1.desc = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
    page1.bgImage = [UIImage imageNamed:@"1"];
    page1.titleImage = [UIImage imageNamed:@"original"];
    
    UIView *viewForPage2 = [[UIView alloc] initWithFrame:self.window.bounds];
    UILabel *labelForPage2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 220, 300, 30)];
    labelForPage2.text = @"Some custom view";
    labelForPage2.font = [UIFont systemFontOfSize:32];
    labelForPage2.textColor = [UIColor whiteColor];
    labelForPage2.backgroundColor = [UIColor clearColor];
    labelForPage2.transform = CGAffineTransformMakeRotation(M_PI_2*3);
    [viewForPage2 addSubview:labelForPage2];
    EAIntroPage *page2 = [EAIntroPage pageWithCustomView:viewForPage2];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"This is page 3";
    page3.desc = @"Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.";
    page3.bgImage = [UIImage imageNamed:@"3"];
    page3.titleImage = [UIImage imageNamed:@"femalecodertocat"];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.window.bounds andPages:@[page1,page2,page3]];
    
    [intro setDelegate:self];
    [intro showInView:self.window animateDuration:0.0];
}

- (void)showIntroWithSeparatePagesInit {
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.window.bounds];
    
    [intro setDelegate:self];
    [intro showInView:self.window animateDuration:0.0];
    
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"Hello world";
    page1.desc = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
    page1.bgImage = [UIImage imageNamed:@"1"];
    page1.titleImage = [UIImage imageNamed:@"original"];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"This is page 2";
    page2.desc = @"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore.";
    page2.bgImage = [UIImage imageNamed:@"2"];
    page2.titleImage = [UIImage imageNamed:@"supportcat"];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"This is page 3";
    page3.desc = @"Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.";
    page3.bgImage = [UIImage imageNamed:@"3"];
    page3.titleImage = [UIImage imageNamed:@"femalecodertocat"];
    
    [intro setPages:@[page1,page2,page3]];
}

- (void)introDidFinish {
    NSLog(@"Intro callback");
}




- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
   
    //[self showIntroWithCrossDissolve];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//并且在收到内存警告的时候，清除缓存内容。

- (void)applicationDidReceiveMemoryWarning:(UIApplication*)application
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}


#pragma mark - UINavigationController Delegate Methods
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController.hidesBottomBarWhenPushed)
    {
        
        navigationController.navigationBarHidden = YES;
        viewController.hidesBottomBarWhenPushed = YES;
    }
    else
    {
        navigationController.navigationBarHidden = NO;
        viewController.hidesBottomBarWhenPushed = NO;
        
    }
    
}
-(void)dealloc {
    
    [_window removeFromSuperview];
    _window = nil;
    [osTabVC removeFromParentViewController];
    osTabVC = nil;
    
    
    [_array removeAllObjects];
    _array = nil;
    _numStr = nil;
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

@end
