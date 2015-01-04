//
//  IndividualCenterViewController.h
//  TeenagersCreateModel
//
//  Created by mac on 14-10-11.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface IndividualCenterViewController : UIViewController<NetworkModuleDelegate>
{
    UILabel *loginLabel;
     UIImageView *headImage;
}
@property(nonatomic,strong)UILabel *loginLabel;
@property(nonatomic,strong)UIImageView *headImage;


@end
