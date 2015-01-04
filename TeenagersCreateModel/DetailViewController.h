//
//  DetailViewController.h
//  TeenagersCreateModel
//
//  Created by mac on 14-10-16.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface DetailViewController : UIViewController<MBProgressHUDDelegate,NetworkModuleDelegate,UIWebViewDelegate>

{
    NSString *titleName;
    
}

@property(nonatomic,strong)NSString *titleName;
@property(nonatomic,strong)NSString *ID;

@end
