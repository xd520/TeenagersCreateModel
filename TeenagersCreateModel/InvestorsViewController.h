//
//  InvestorsViewController.h
//  TeenagersCreateModel
//
//  Created by Yonghui Xiong on 14-11-12.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface InvestorsViewController : UIViewController<UITextFieldDelegate,MBProgressHUDDelegate,NetworkModuleDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@property(nonatomic,strong)NSString *titleName;


@end
