//
//  UIView+LabelView.m
//  CommenUser
//
//  Created by Yonghui Xiong on 15-1-5.
//  Copyright (c) 2015年 ApexSoft. All rights reserved.
//

#import "UIView+LabelView.h"

@implementation UIView (LabelView)

+(UIView *)withLabel:(UILabel *)endLab{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(endLab.frame.origin.x, endLab.frame.origin.y, endLab.frame.size.width + 5, endLab.frame.size.height)];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(endLab.frame.size.width , 0, 5, endLab.frame.size.height)];
    
    lab.text = @"*";
   // lab.backgroundColor = [UIColor grayColor];
    //lab.font = [UIFont systemFontOfSize:20];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor redColor];
    //lab.center = CGPointMake(endLab.frame.size.width + 5/2,endLab.frame.size.height/2);
    endLab.frame = CGRectMake(0, 0, endLab.frame.size.width, endLab.frame.size.height);
    [view addSubview:endLab];
    [view addSubview:lab];
    
     return view;
}

@end
