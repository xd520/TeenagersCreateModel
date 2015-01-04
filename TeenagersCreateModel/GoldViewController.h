//
//  GoldViewController.h
//  TeenagersCreateModel
//
//  Created by Yonghui Xiong on 14-11-10.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DDList.h"
#import "PassValueDelegate.h"

@interface GoldViewController : UIViewController<UITextFieldDelegate,NetworkModuleDelegate,MBProgressHUDDelegate,PassValueDelegate>
{
    
    DDList				 *_ddList;
}

- (void)setDDListHidden:(BOOL)hidden;

@end
