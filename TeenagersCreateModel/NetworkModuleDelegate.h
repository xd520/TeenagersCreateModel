
enum kPostStatus{
    kPostStatusNone=0,
    kPostStatusBeging=1,
    kPostStatusEnded=2,
    kPostStatusError=3,
    kPostStatusReceiving=4
};
typedef enum kPostStatus kPostStatus;

enum kBusinessTag
{
	kBusinessTagUserGetList = 0,
    kBusinessTagGetZXZX = 1,
    kBusinessTagUserGetListAgain = 2,
    kBusinessTagGetZXZXAgain = 3,
    kBusinessTagGetFundslistAgain = 4,
    kBusinessTagUserLogin = 5,
    kBusinessTagGetMyfunds = 6,
    kBusinessTagGetFundslist = 7,
    kBusinessTagGetUpdateUserName = 8,
    kBusinessTagGetMyinv = 9,
    kBusinessTagGetCancelWt = 10,
    kBusinessTagGetconfirmJK = 11,
    kBusinessTagGetMyprj = 12,
    kBusinessTagUpdateImage = 13,
    kBusinessTagGetMyprjAgain = 14,
    kBusinessTagGetLogOut = 15,
    kBusinessTagGetBankBD = 16,
    kBusinessTagGetBankRJ = 17,
    kBusinessTagGetBankCJ = 18,
    kBusinessTagGetBankCJAgain = 19,
    kBusinessTagGetBanner = 20,
    kBusinessTagGetIndustry = 21,
    kBusinessTagGetProvince = 22,
    kBusinessTagGetStatus = 23,
    kBusinessTagGetCity = 24,
    kBusinessTagGetWYTZ = 25,
    kBusinessTagGetBankInfo = 26,
    kBusinessTagGetProjectDetail = 27,
    kBusinessTagGetRZF = 28,
    kBusinessTagGetRegisterTZF = 29,
    kBusinessTagGetRegisterUpfile = 30,
    kBusinessTagGetYzmobile = 31,
    kBusinessTagGetYzzjbh = 32,
    kBusinessTagGetYzm = 33,
    kBusinessTagGetYCheckyzm = 34,
    kBusinessTagGetIwLeader = 35,
    kBusinessTagGetIwFlollow = 36,
    kBusinessTagGetCheckIos = 37,
    kBusinessTagGetRegisterUpfileAgin1 = 38,
    kBusinessTagGetRegisterUpfileAgin2 = 39,
    kBusinessTagGetSjTzr = 40,
    kBusinessTagGetLtrSq = 41,
    kBusinessTagGetLtrForm = 42,
    kBusinessTagGetBankIntoGoldCJ = 43,
    kBusinessTagUserGetEndRefreshList = 44,
    kBusinessTagGetYzmobileAgain = 45,
    kBusinessTagGetYzzjbhAgain = 46,
    kBusinessTagGetUpdateUserNameAgain = 47,
    kBusinessTagGetModifyTzr = 48,
   
};
typedef enum kBusinessTag kBusinessTag;

@protocol NetworkModuleDelegate<NSObject>
@required
-(void)beginPost:(kBusinessTag)tag;
-(void)endPost:(NSString*)result business:(kBusinessTag)tag;
-(void)errorPost:(NSError*)err business:(kBusinessTag)tag;
@end