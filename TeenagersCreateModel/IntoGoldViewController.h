//
//  IntoGoldViewController.h
//  TeenagersCreateModel
//
//  Created by Yonghui Xiong on 14-11-10.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DDList.h"
#import "PassValueDelegate.h"

@class MyFundViewController;
@interface IntoGoldViewController : UIViewController<UITextFieldDelegate,NetworkModuleDelegate,PassValueDelegate>
{
    
    DDList				 *_ddList;
}



@property (nonatomic,strong) MyFundViewController *myFundVC;

- (void)setDDListHidden:(BOOL)hidden;

@end
