//
//  Customer.h
//  FinancialExpert
//
//  Created by mac on 14-9-25.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Customer : NSObject
{
    NSString *customerName;  //客户姓名
    NSString *customerId; //客户号
    BOOL loginSueccss;  //是否登录成功
    BOOL isGJTZR;  //是否是高级投资人
    BOOL isLTR;  //是否是领头人
    BOOL isHGTZR; //是否是合格投资人
    BOOL isTZRQX;  //投资人权限
    
    NSString *sessionId; //机构标致
    NSString *fieldNum;  //身份证号码
    NSString *fid_zw;  //职位
    NSString *phoneNum; // 手机号码
    NSString *email; //邮件地址
    NSString *name; //用户名
    UIImage *icon; //头像
    NSString *yearGold; //年收入
    NSString *session_Id; //会话标识 id
    NSString *companyName;//公司名字
     NSString *fund;//资产
    
}
@property(nonatomic,strong) NSString *yearGold;
@property(nonatomic,strong) NSString *session_Id;
@property(nonatomic,strong) NSString *companyName;
@property(nonatomic,strong) NSString *fund;
@property(nonatomic,strong) NSString *customerName;
@property(nonatomic,assign) BOOL isGJTZR;
@property(nonatomic,strong) NSString *customerId;
@property(nonatomic,assign) BOOL loginSueccss;
@property(nonatomic,assign) BOOL isLTR;
@property(nonatomic,assign) BOOL isTZRQX;
@property(nonatomic,assign) BOOL isHGTZR;
@property(nonatomic,strong) NSString *sessionId;
@property(nonatomic,strong)  NSString *fieldNum;
@property(nonatomic,strong) NSString *fid_zw;
@property(nonatomic,strong)  NSString *phoneNum;
@property(nonatomic,strong)  NSString *email;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) UIImage *icon;


+(id) CustomerInformation:(NSString *)_customerName withsessionId:(NSString *)_sessionId withId:(NSString *)_customerId withSueccss:(BOOL)_loginSue withGJTZR:(BOOL)_gjtzr withTZRQX:(BOOL)_tzrqx withLTR:(BOOL)_ltr withHGTZR:(BOOL)_hgtzr withfieldNum:(NSString *)_fieldNum withfid_zw:(NSString *)_fid_zw withphoneNum:(NSString *)_phoneNum withemail:(NSString *)_email withname:(NSString *)_name withicon:(UIImage *)_icon withyearGold:(NSString *)_yearGold withsession_Id:(NSString *)_session_Id withcompanyName:(NSString *)_companyName withfund:(NSString *)_fund;




@end
