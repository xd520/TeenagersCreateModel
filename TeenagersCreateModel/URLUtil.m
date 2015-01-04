//
//  URLUtil.m
//  WeiXiu
//
//  Created by Chris on 13-7-15.
//  Copyright (c) 2013年 Chris. All rights reserved.
//

#import "URLUtil.h"
#import "AppDelegate.h"
@implementation URLUtil
+ (NSString *)getURLByBusinessTag:(kBusinessTag)tag
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    switch ([[NSNumber numberWithInt:tag] intValue]) {
        case 0:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/index/project/wytz"];
            break;
        case 1:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/index/project/zxzx"];
            break;
        case 2:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/index/project/wytz"];
            break;
        case 3:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/index/project/zxzx"];
            break;
        case 4:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/psncenter/myfunds/fundslist"];
            break;
        case 5:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/login"];
            break;
        case 6:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/psncenter/myfunds"];
            break;
        case 7:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/psncenter/myfunds/fundslist"];
            break;
        case 8:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/register/yzusername"];
            break;
        case 9:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/psncenter/myinv"];
            break;
        case 10:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/psncenter/myinv/cancelWt"];
            break;
        case 11:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/psncenter/myinv/confirmJK"];
            break;
        case 12:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/psncenter/myprj"];
            break;
        case 13:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/psncenter/psninfo/modifyPhotoSubmit"];
            break;
        case 14:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/psncenter/myprj"];
            break;
        case 15:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/logout"];
        case 16:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/psncenter/bankbusiness/bd"];
            break;
        case 17:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/psncenter/bankbusiness/rj"];
            break;
        case 18:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/psncenter/bankbusiness/isneedzjmm"];
            break;
        case 19:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/psncenter/bankbusiness/cj"];
            break;
        case 20:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/index/project/banner"];
            break;
        case 21:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/index/project/industry"];
            break;
        case 22:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/index/project/province"];
            break;
        case 23:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/index/project/status"];
            break;
        case 24:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/index/project/city"];
            break;
        case 25:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/index/project/wytz"];
            break;
        case 26:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/psncenter/bankbusiness/bank_info"];
            break;
        case 27:
            return [NSString stringWithFormat:@"%@%@%@", SERVERURL, @"/app/index/project/detail/",delegate.numStr];
            break;
        case 28:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/register/rzf"];
            break;
        case 29:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/register/tzf"];
            break;
        case 30:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/psncenter/invsigned/upfile"];
            break;
        case 31:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/register/yzmobile"];
            break;
        case 32:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/register/yzzjbh"];
            break;
        case 33:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/register/getyzm"];
            break;
        case 34:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/register/checkyzm"];
            break;
        case 35:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/oper/operate/iwleader"];
            break;
        case 36:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/oper/operate/iwfollow"];
            break;
        case 37:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/version/checkIos"];
            break;
        case 38:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/psncenter/invsigned/upfile"];
            break;
        case 39:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/psncenter/invsigned/upfile"];
            break;
        case 40:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/psncenter/invsigned/sjTzr"];
            break;
        case 41:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/psncenter/invsigned/ltrSq"];
            break;
        case 42:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/psncenter/invsigned/ltrForm"];
            break;
        case 43:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/psncenter/bankbusiness/isneedzjmm"];
            break;
        case 44:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/index/project/wytz"];
            break;
        case 45:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/register/yzmobile"];
            break;
        case 46:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/register/yzzjbh"];
            break;
        case 47:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/app/register/yzusername"];
            break;
        default:
            break;
    }
    return @"";
}
@end
