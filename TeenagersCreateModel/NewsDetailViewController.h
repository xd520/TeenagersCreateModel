//
//  NewsDetailViewController.h
//  TeenagersCreateModel
//
//  Created by Yonghui Xiong on 14-11-12.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface NewsDetailViewController : UIViewController<MBProgressHUDDelegate,UIWebViewDelegate>


@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *name;

@end
