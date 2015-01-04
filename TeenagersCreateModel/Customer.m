//
//  Customer.m
//  FinancialExpert
//
//  Created by mac on 14-9-25.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "Customer.h"

@implementation Customer
@synthesize customerId,customerName,sessionId,loginSueccss,isGJTZR,isHGTZR,isLTR,fieldNum,fid_zw,phoneNum,email,name,icon,isTZRQX,session_Id,companyName,yearGold,fund;

+(id) CustomerInformation:(NSString *)_customerName withsessionId:(NSString *)_sessionId withId:(NSString *)_customerId withSueccss:(BOOL)_loginSue withGJTZR:(BOOL)_gjtzr withTZRQX:(BOOL)_tzrqx withLTR:(BOOL)_ltr withHGTZR:(BOOL)_hgtzr withfieldNum:(NSString *)_fieldNum withfid_zw:(NSString *)_fid_zw withphoneNum:(NSString *)_phoneNum withemail:(NSString *)_email withname:(NSString *)_name withicon:(UIImage *)_icon withyearGold:(NSString *)_yearGold withsession_Id:(NSString *)_session_Id withcompanyName:(NSString *)_companyName withfund:(NSString *)_fund {
    Customer *customer = [[Customer alloc] init];
    customer.sessionId = _sessionId;
    customer.customerName = _customerName;
    customer.customerId = _customerId;
    customer.loginSueccss = _loginSue;
    customer.isTZRQX = _tzrqx;
    customer.isGJTZR = _gjtzr;
    customer.isHGTZR = _hgtzr;
    customer.isLTR = _ltr;
    customer.fieldNum = _fieldNum;
    customer.fid_zw = _fid_zw;
    customer.phoneNum = _phoneNum;
    customer.email = _email;
    customer.name = _name;
    customer.icon = _icon;
    customer.session_Id =_session_Id;
    customer.companyName = _companyName;
    customer.yearGold = _yearGold;
    customer.fund = _fund;
    
    return customer;

}

-(void) dealloc {
    customerName = nil;
     isGJTZR = Nil;
    customerId = nil;
     loginSueccss = Nil;
   isLTR = Nil;
    isTZRQX = Nil;
    isHGTZR = Nil;
   sessionId = nil;
    fieldNum = nil;
    fid_zw = nil;
    phoneNum = nil;
    email = nil;
    name = nil;
    icon = nil;
session_Id = nil;
    companyName= nil;
    yearGold= nil;
    fund= nil;
    
    
    
}

@end
