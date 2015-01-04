//
//  MyInfoViewController.h
//  TeenagersCreateModel
//
//  Created by Yonghui Xiong on 14-11-5.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface MyInfoViewController : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,NSXMLParserDelegate,MBProgressHUDDelegate>
{
    UILabel *userName;
}
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *userName;

@end
