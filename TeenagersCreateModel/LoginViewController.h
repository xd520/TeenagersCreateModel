//
//  LoginViewController.h
//  FinancialExpert
//
//  Created by mac on 14-9-22.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@class IndividualCenterViewController;


@interface LoginViewController : UIViewController <UITextFieldDelegate,NetworkModuleDelegate,MBProgressHUDDelegate,UINavigationControllerDelegate>
{
    UITextField *phoneNumText;
    UITextField *passWordText;
    UIImageView *passWord;
    UIImageView *phoneNum;
    
}

@property(nonatomic,strong) UIButton *button1;

@property(nonatomic,strong)NSString *customerName;
@property(nonatomic,strong)IndividualCenterViewController *myViewController;

@property(nonatomic,strong)NSMutableData *receiveData;



@end
