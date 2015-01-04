//
//  UpDateUserNameViewController.h
//  TeenagersCreateModel
//
//  Created by Yonghui Xiong on 14-11-6.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@class MyInfoViewController;
@interface UpDateUserNameViewController : UIViewController<UITextFieldDelegate,MBProgressHUDDelegate,NetworkModuleDelegate>

@property(nonatomic,strong) MyInfoViewController *myinfoVC;
@property(nonatomic,strong) NSString *dataString;

@end
