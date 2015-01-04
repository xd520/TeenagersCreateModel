//
//  NumBindViewController.h
//  TeenagersCreateModel
//
//  Created by Yonghui Xiong on 14-11-24.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DDList.h"
#import "PassValueDelegate.h"


@interface NumBindViewController : UIViewController <UITextFieldDelegate,MBProgressHUDDelegate,NetworkModuleDelegate,PassValueDelegate>
{
    
    DDList				 *_ddList;
}

- (void)setDDListHidden:(BOOL)hidden;

@end
