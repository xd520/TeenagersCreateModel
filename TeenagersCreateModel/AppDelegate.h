//
//  AppDelegate.h
//  TeenagersCreateModel
//
//  Created by mac on 14-10-11.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorUtil.h"
#import "Base64.h"
#import "MBProgressHUD.h"
#import "NetworkModule.h"
#import "OpenUDID.h"
#import "Toast+UIView.h"
#import "SBJson.h"
#import "SRRefreshView.h"
#import "AsyncImageView.h"
#import "SHLUILabel.h"
#import "ILBarButtonItem.h"
#import "UIView+MGBadgeView.h"
#import "EAIntroView.h"
#import "ASIHTTPRequest.h"
#import "LoginViewController.h"
#import "UIView+LabelView.h"

//请求数据头 http://192.168.1.57:8011/appservice

//#define SERVERURL @"http://192.168.1.57:8011/appservice/wsCommon/service"
//本地请求数据地址：
//#define SERVERURL @"http://218.66.59.169:1577"

//本地请求数据登录验证地址：
//#define SERVERURL @"http://192.168.2.219:8080/gqzc"

//#define SERVERDETAIL1 @"http://192.168.1.57:8021/app/index/infoWeb/mobiledetail/"
//#define SERVERDETAIL2 @"http://192.168.1.57:8021/app/index/infoWeb/mobiledetail/"
//#define SERVERDETAIL3 @"http://192.168.1.57:8021/app/index/infoWeb/mobiledetail/"
#define NUMBERS @"0123456789\n"

//本地请求数据测试地址：
//#define SERVERURL @"http://192.168.8.13:8090/gqzc"
//#define SERVERURL @"http://192.168.8.172:8090/gqzc"
//广州请求数据地址：
#define SERVERURL @"http://183.62.241.11:8080"

//广州资讯请求头
//#define SERVERDETAIL1 @"http://183.62.241.11:8080/app/index/infoWeb/mobiledetail/"
#define SERVERDETAIL2 @"http://183.62.241.11:8080/app/index/infoWeb/mobiledetail/"
#define SERVERDETAIL3 @"http://183.62.241.11:8080/app/index/infoWeb/mobiledetail/"

                                   

@class CPVSTabBarViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate,UINavigationControllerDelegate,EAIntroDelegate>


{
    CPVSTabBarViewController *osTabVC;
   
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong)  CPVSTabBarViewController *osTabVC;
@property(nonatomic,strong)NSMutableArray *array;
@property(nonatomic,strong)NSString *numStr;
@property(nonatomic,strong)NSString *tagCountStr;


@end
