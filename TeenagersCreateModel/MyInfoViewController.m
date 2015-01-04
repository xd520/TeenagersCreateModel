//
//  MyInfoViewController.m
//  TeenagersCreateModel
//
//  Created by Yonghui Xiong on 14-11-5.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "MyInfoViewController.h"
#import "AppDelegate.h"
#import "Customer.h"
#import "UpdateEmailViewController.h"
#import "UpdatePhoneNumViewController.h"
#import "UpDateUserNameViewController.h"
#import "ZipArchive.h"


@interface MyInfoViewController ()
{
    BOOL isFullScreen;
    BOOL success;
    BOOL hasLoadedCamera;
    NSString *str;
    UIScrollView *scrollView;
}
@end

@implementation MyInfoViewController
@synthesize userName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationController.navigationBarHidden = YES;
    }
    return self;
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    //show camera...
//    if (!hasLoadedCamera)
//        [self performSelector:@selector(showcamera:) withObject:nil afterDelay:0.3];
//}

-(void)loadView {
    [super loadView];
    UIView *baseView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    baseView.backgroundColor = [ColorUtil colorWithHexString:@"e7e7e7"];
    //baseView.backgroundColor = [UIColor grayColor];
    self.view = baseView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //相对于上面的接口，这个接口可以动画的改变statusBar的前景色
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    
    statusBarView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"title_bg"]];
    
    [self.view addSubview:statusBarView];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    

    hasLoadedCamera = YES;
    UINavigationBar *navibar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 44)];
    navibar.userInteractionEnabled = YES;
    //navibar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navbar.png"]];
    [navibar setBackgroundImage:[UIImage imageNamed:@"title_bg"]  forBarMetrics:UIBarMetricsDefault];
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 12, 40, 20);
    [leftBtn setImage:[UIImage imageNamed:@"return_ico"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    UINavigationItem *navibarItem = [[UINavigationItem alloc]init];
    navibarItem.title = @"我的信息";
    navibarItem.leftBarButtonItem= leftItem;
    // self.navigationItem.rightBarButtonItem = leftItem;
    [navibar pushNavigationItem:navibarItem animated:YES];
    [self.view addSubview:navibar];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
#endif
    
    //获取共享
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    Customer *customer = [delegate.array objectAtIndex:0];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 65, ScreenWidth, ScreenHeight - 65)];
    
    if (customer.isTZRQX) {
    
    [scrollView setContentSize:CGSizeMake(320, 620)];
    } else {
    
    [scrollView setContentSize:CGSizeMake(320, ScreenHeight - 65)];
    
    }

    
    

    
 // 基本信息
    UILabel *baseLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 39)];
    baseLabel.text = @" 基本信息";
    baseLabel.textColor = [ColorUtil colorWithHexString:@"000000"];
    baseLabel.font = [UIFont systemFontOfSize:16];
    baseLabel.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:baseLabel];
    
    
    
    
    

//头像
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth, 90)];
    headView.backgroundColor = [UIColor whiteColor];
    headView.tag = 100001;
    UITapGestureRecognizer *headTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callPhone:)];
    //单点触摸
    headTap.numberOfTouchesRequired = 1;
    //点击几次，如果是1就是单击
    headTap.numberOfTapsRequired = 1;
    [headView addGestureRecognizer:headTap];
    
    
    UILabel *headImage = [[UILabel alloc] initWithFrame:CGRectMake(10, 35, 70, 20)];
    headImage.font = [UIFont systemFontOfSize:14];
    headImage.textColor = [ColorUtil colorWithHexString:@"000000"];
    headImage.textAlignment = NSTextAlignmentRight;
    headImage.text = @"头像:";
    [headView addSubview:headImage];
    
    
   
    
    
 //加图片图层
    
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.backgroundColor = [UIColor whiteColor].CGColor;
    UIBezierPath *layerPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(1, 1, 78, 78)];
    maskLayer.path = layerPath.CGPath;
    maskLayer.fillColor = [UIColor blackColor].CGColor;
    
    UIView *clippingViewForLayerMask = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth - 140, 5 , 80, 80)];
    clippingViewForLayerMask.layer.mask = maskLayer;
    clippingViewForLayerMask.clipsToBounds = YES;
    [headView addSubview:clippingViewForLayerMask];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0 , 80, 80)];
    self.imageView.image = customer.icon;
   // self.imageView.userInteractionEnabled = NO;
    self.imageView.backgroundColor = [UIColor lightGrayColor];
    [clippingViewForLayerMask addSubview:self.imageView];
    
    
    // [headView addSubview:self.imageView];
    
    UIImageView *headTip = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - 40, 30, 20, 20)];
    headTip.image = [UIImage imageNamed:@"icon_right"];
    [headView addSubview:headTip];
    [scrollView addSubview:headView];
    

//用户名
    UIView *userView = [[UIView alloc] initWithFrame:CGRectMake(0, 155 - 24, ScreenWidth, 44)];
    userView.backgroundColor = [ColorUtil colorWithHexString:@"FFFFFF"];
    userView.tag = 100002;
    
    
    UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 70, 14)];
    userNameLabel.font = [UIFont systemFontOfSize:14];
    userNameLabel.textColor = [ColorUtil colorWithHexString:@"000000"];
    userNameLabel.text = @"用户名:";
    userNameLabel.textAlignment = NSTextAlignmentRight;
    [userView addSubview:userNameLabel];
    
    userName = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, 150, 44)];
    userName.font = [UIFont systemFontOfSize:14];
    userName.textColor = [ColorUtil colorWithHexString:@"888888"];
    userName.text = customer.name;
    str = customer.name;
    [userView addSubview:userName];
    
    UIImageView *userTip = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - 40, 7, 20, 20)];
    userTip.image = [UIImage imageNamed:@"icon_right"];
    //[userView addSubview:userTip];
    
    UITapGestureRecognizer *userTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callPhone:)];
    //单点触摸
    userTap.numberOfTouchesRequired = 1;
    //点击几次，如果是1就是单击
    userTap.numberOfTapsRequired = 1;
    //[userView addGestureRecognizer:userTap];
    
    [scrollView addSubview:userView];
    
//客户号
    UIView *numView = [[UIView alloc] initWithFrame:CGRectMake(0, 176, ScreenWidth, 44)];
    numView.backgroundColor = [UIColor whiteColor];
    //userView.tag = 100002;
    
    UILabel *userNum = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 70, 14)];
    userNum.font = [UIFont systemFontOfSize:14];
    userNum.text = @"客户号:";
    userNum.textColor = [ColorUtil colorWithHexString:@"000000"];
    userNum.textAlignment = NSTextAlignmentRight;
    [numView addSubview:userNum];
    
    
    UILabel *userNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, 150, 44)];
    userNumLabel.text = customer.customerId;
    userNumLabel.font = [UIFont systemFontOfSize:14];
    userNumLabel.textColor = [ColorUtil colorWithHexString:@"888888"];
    [numView addSubview:userNumLabel];
   [scrollView addSubview:numView];
//真实姓名
    UIView *nameView = [[UIView alloc] initWithFrame:CGRectMake(0, 221, ScreenWidth, 44)];
    nameView.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 70 , 14)];
    name.font = [UIFont systemFontOfSize:14];
    name.textColor = [ColorUtil colorWithHexString:@"000000"];
    name.textAlignment = NSTextAlignmentRight;

    name.text = @"真实姓名:";
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, 150, 44)];
    nameLabel.text = customer.customerName;
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor = [ColorUtil colorWithHexString:@"888888"];
    [nameView addSubview:nameLabel];
    
    [nameView addSubview:name];
    [scrollView addSubview:nameView];
//身份证编号
    UIView *fieldNumView = [[UIView alloc] initWithFrame:CGRectMake(0, 266, ScreenWidth, 44)];
    fieldNumView.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *fieldNum = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 70, 14)];
    fieldNum.font = [UIFont systemFontOfSize:14];
    fieldNum.text = @"证件编号:";
    fieldNum.textColor = [ColorUtil colorWithHexString:@"000000"];
    fieldNum.textAlignment = NSTextAlignmentRight;
    [fieldNumView addSubview:fieldNum];
    
    UILabel *fieldLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, 150, 44)];
    fieldLabel.text = customer.fieldNum;
    fieldLabel.font = [UIFont systemFontOfSize:14];
    fieldLabel.textColor = [ColorUtil colorWithHexString:@"888888"];
    [fieldNumView addSubview:fieldLabel];
    
    [scrollView addSubview:fieldNumView];
//手机
    UIView *phoneView = [[UIView alloc] initWithFrame:CGRectMake(0, 311, ScreenWidth, 44)];
    phoneView.backgroundColor = [UIColor whiteColor];
    phoneView.tag = 100003;
    
    UILabel *phoneNum = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 70, 14)];
    phoneNum.font = [UIFont systemFontOfSize:14];
    phoneNum.text = @"手机:";
    phoneNum.textColor = [ColorUtil colorWithHexString:@"000000"];
    phoneNum.textAlignment = NSTextAlignmentRight;
    [phoneView addSubview:phoneNum];
    
    UIImageView *phoneTip = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - 40, 7, 20, 20)];
    phoneTip.image = [UIImage imageNamed:@"icon_right"];
    //[phoneView addSubview:phoneTip];
    
    UITapGestureRecognizer *phoneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callPhone:)];
    //单点触摸
    phoneTap.numberOfTouchesRequired = 1;
    //点击几次，如果是1就是单击
    phoneTap.numberOfTapsRequired = 1;
    //[phoneView addGestureRecognizer:phoneTap];
    
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, 150, 44)];
    phoneLabel.text = customer.phoneNum;
    phoneLabel.font = [UIFont systemFontOfSize:14];
    phoneLabel.textColor = [ColorUtil colorWithHexString:@"888888"];
    [phoneView addSubview:phoneLabel];
    
    [scrollView addSubview:phoneView];
//Email
    UIView *emailView = [[UIView alloc] initWithFrame:CGRectMake(0, 356, ScreenWidth, 44)];
    emailView.backgroundColor = [UIColor whiteColor];
    emailView.tag = 100004;
    
    UILabel *email = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 70, 44)];
    email.font = [UIFont systemFontOfSize:14];
    email.text = @"Email:";
    email.textColor = [ColorUtil colorWithHexString:@"000000"];
    email.textAlignment = NSTextAlignmentRight;
    [emailView addSubview:email];
    
    UIImageView *emailTip = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - 40, 7, 20, 20)];
    emailTip.image = [UIImage imageNamed:@"icon_right"];
    //[emailView addSubview:emailTip];
    
    UITapGestureRecognizer *eamilTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callPhone:)];
    //单点触摸
    eamilTap.numberOfTouchesRequired = 1;
    //点击几次，如果是1就是单击
    eamilTap.numberOfTapsRequired = 1;
    //[emailView addGestureRecognizer:eamilTap];
    
    
    UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, 200, 44)];
    emailLabel.text = customer.email;
    emailLabel.font = [UIFont systemFontOfSize:14];
    emailLabel.textColor = [ColorUtil colorWithHexString:@"888888"];
    [emailView addSubview:emailLabel];
    [scrollView addSubview:emailView];
    
// 投资人信息
    
    if (customer.isTZRQX) {
    
    UILabel *investorsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 401, ScreenWidth, 39)];
    investorsLabel.text = @" 投资人信息";
    investorsLabel.textColor = [ColorUtil colorWithHexString:@"000000"];
    investorsLabel.font = [UIFont systemFontOfSize:16];
    investorsLabel.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:investorsLabel];
    
//公司
        UIView *companyView = [[UIView alloc] initWithFrame:CGRectMake(0, 441, ScreenWidth, 44)];
        companyView.backgroundColor = [UIColor whiteColor];
        
        
        UILabel *company = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 70, 14)];
        company.font = [UIFont systemFontOfSize:14];
        company.text = @"公司:";
        company.textColor = [ColorUtil colorWithHexString:@"000000"];
        company.textAlignment = NSTextAlignmentRight;
        [companyView addSubview:company];
        
        UILabel *fieldLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, 150, 44)];
        fieldLabel.text = customer.companyName;
        fieldLabel.font = [UIFont systemFontOfSize:14];
        fieldLabel.textColor = [ColorUtil colorWithHexString:@"888888"];
        [companyView addSubview:fieldLabel];
        
        [scrollView addSubview:companyView];
        
        
//职位
        UIView *positionView = [[UIView alloc] initWithFrame:CGRectMake(0, 486, ScreenWidth, 44)];
        positionView.backgroundColor = [UIColor whiteColor];
        
        
        UILabel *position = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 70, 14)];
        position.font = [UIFont systemFontOfSize:14];
        position.text = @"职位:";
        position.textColor = [ColorUtil colorWithHexString:@"000000"];
        position.textAlignment = NSTextAlignmentRight;
        [positionView addSubview:position];
        
        UILabel *positionLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, 150, 44)];
        positionLabel.text = customer.fid_zw;
        positionLabel.font = [UIFont systemFontOfSize:14];
        positionLabel.textColor = [ColorUtil colorWithHexString:@"888888"];
        [positionView addSubview:positionLabel];
        
        [scrollView addSubview:positionView];
        
//资产
        UIView *fundView = [[UIView alloc] initWithFrame:CGRectMake(0, 531, ScreenWidth, 44)];
        fundView.backgroundColor = [UIColor whiteColor];
        
        
        UILabel *fund = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 70, 14)];
        fund.font = [UIFont systemFontOfSize:14];
        fund.text = @"资产:";
        fund.textColor = [ColorUtil colorWithHexString:@"000000"];
        fund.textAlignment = NSTextAlignmentRight;
        [fundView addSubview:fund];
        
        UILabel *fundLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, 150, 44)];
        fundLabel.text = [NSString stringWithFormat:@"￥ %.2f",[customer.fund floatValue]];
        fundLabel.font = [UIFont systemFontOfSize:14];
        fundLabel.textColor = [ColorUtil colorWithHexString:@"888888"];
        [fundView addSubview:fundLabel];
        
        [scrollView addSubview:fundView];
        
 //年收入
        UIView *nsrView = [[UIView alloc] initWithFrame:CGRectMake(0, 576, ScreenWidth, 44)];
        nsrView.backgroundColor = [UIColor whiteColor];
        
        
        UILabel *nsr = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 70, 14)];
        nsr.font = [UIFont systemFontOfSize:14];
        nsr.text = @"年收入:";
        nsr.textColor = [ColorUtil colorWithHexString:@"000000"];
        nsr.textAlignment = NSTextAlignmentRight;
        [nsrView addSubview:nsr];
        
        UILabel *nsrLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, 150, 44)];
         nsrLabel.text = [NSString stringWithFormat:@"￥ %.2f",[customer.yearGold floatValue]];
       // nsrLabel.text = customer.yearGold;
        nsrLabel.font = [UIFont systemFontOfSize:14];
        nsrLabel.textColor = [ColorUtil colorWithHexString:@"888888"];
        [nsrView addSubview:nsrLabel];
        
        [scrollView addSubview:nsrView];
        
    
    }
    
    
    [self.view addSubview:scrollView];
}

- (IBAction)callPhone:(UITouch *)sender
{
    UIView *view = [sender view];
    if (view.tag == 100001) {
        UIActionSheet *sheet;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
            
        } else {
            sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
        }
        sheet.tag = 255;
        [sheet showInView:self.view];
        
    } else if (view.tag == 100002){
        UpDateUserNameViewController *ctrl = [[UpDateUserNameViewController alloc] init];
        ctrl.myinfoVC = self;
        ctrl.dataString = str;
        ctrl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ctrl animated:NO];
        
    
    } else if (view.tag == 100003){
    
    }else if (view.tag == 100004){
    
    }
}

#pragma caramer Methods

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (actionSheet.tag == 255) {
        NSUInteger sourceType = 0;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:{
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    hasLoadedCamera = YES;
                }
                    break;
                case 2:{
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                   // hasLoadedCamera = YES;
                }
                    break;
            }
        }else {
            if (buttonIndex == 0) {
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
       
        [self showcamera:sourceType];
        
    }
}

- (void)showcamera:(NSInteger)tag {
   UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setDelegate:self];
    //[imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [imagePicker setAllowsEditing:YES];
    imagePicker.sourceType = tag;
     [self presentViewController:imagePicker animated:YES completion:^{}];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
   // NSLog(@"u a is sb");
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [self scaleImage:[info objectForKey:UIImagePickerControllerEditedImage]];
    /* 此处info 有六个值
     * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
     * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
     * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
     * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
     * UIImagePickerControllerMediaURL;       // an NSURL
     * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
     * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
     */
    
    // 保存图片至本地，方法见下文
    
    
    
    [self saveImage:image withName:@"currentImage.png"];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    //UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
   
        //添加指示器及遮罩
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = YES; //加层阴影
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"加载中...";
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        ASIFormDataRequest *requestReport  = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/app/psncenter/psninfo/modifyPhotoSubmit",SERVERURL]]];
        NSLog(@"%@",requestReport);
        
        
        
        [requestReport setFile:fullPath forKey:@"upfile"];
        
        [requestReport buildPostBody];
        
        requestReport.delegate = self;
        [requestReport setTimeOutSeconds:5];
        [requestReport setDidFailSelector:@selector(urlRequestField:)];
        [requestReport setDidFinishSelector:@selector(urlRequestSueccss:)];
        
        
        [requestReport startAsynchronous];//异步传输
        
        isFullScreen = NO;
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });
    
   
   // [self.imageView setImage:savedImage];
    
    //self.imageView.tag = 100;
    
}

//图片压缩

- (UIImage *)scaleImage:(UIImage *)image {
    int kMaxResolution = 1000;
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = roundf(bounds.size.width / ratio);
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = roundf(bounds.size.height * ratio);
        }
    }
    
    NSLog(@"boudns image =%@",NSStringFromCGRect(bounds));
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    
    switch(orient) {
        case UIImageOrientationUp:
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored:
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown:
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored:
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft:
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored:
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight:
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
            //        default:
            //            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}





-(void) urlRequestField:(ASIHTTPRequest *)request {
    NSError *error = [request error];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self.view makeToast:[NSString stringWithFormat:@"%@",error]];
}

-(void) urlRequestSueccss:(ASIHTTPRequest *)request {
    NSData *data =[request responseData];
    NSXMLParser *parser = [[NSXMLParser alloc]initWithData:data];
    NSLog(@"%@",parser);
    NSLog(@"xml data = %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    [parser setDelegate:self];
   [parser parse];
    
        NSString *strss = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSMutableDictionary *dic = [strss JSONValue];
    if ([[dic objectForKey:@"success"] boolValue]) {
        [self.view makeToast:@"更新图片成功"];
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        Customer *cuser = [delegate.array objectAtIndex:0];
        cuser.icon = nil;
        UIImage *icon = [[UIImage alloc] initWithContentsOfFile:fullPath];
        cuser.icon = icon;
        self.imageView.image = [[UIImage alloc] initWithContentsOfFile:fullPath];
//删除本地化文件
       /*
         NSFileManager *fileMgr = [NSFileManager defaultManager];
        BOOL bRet = [fileMgr fileExistsAtPath:fullPath];
        if (bRet) {
            NSError *err;
            [fileMgr removeItemAtPath:fullPath error:&err];
        }
*/
        
    } else {
    [self.view makeToast:@"更新图片失败"];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
   
}

#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
    
}




- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self dismissViewControllerAnimated:YES completion:^{}];
    
}

/*
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    isFullScreen = !isFullScreen;
    
    UITouch *touch = [touches anyObject];
    
    CGPoint touchPoint = [touch locationInView:self.view];
    
    CGPoint imagePoint = self.imageView.frame.origin;
    
    //touchPoint.x ，touchPoint.y 就是触点的坐标
    
    // 触点在imageView内，点击imageView时 放大,再次点击时缩小
    
    if(imagePoint.x <= touchPoint.x && imagePoint.x +self.imageView.frame.size.width >=touchPoint.x && imagePoint.y <=  touchPoint.y && imagePoint.y+self.imageView.frame.size.height >= touchPoint.y)
        
    {
        
        // 设置图片放大动画
        
        [UIView beginAnimations:nil context:nil];
        
        // 动画时间
        
        [UIView setAnimationDuration:1];
        
        if (isFullScreen) {
            // 放大尺寸
            
            self.imageView.frame = CGRectMake(0, 0, 320, 480);
            
        }
        
        else {
            // 缩小尺寸
            self.imageView.frame = CGRectMake(50, 200, 220, 100);
            
        }
        // commit动画
        
        [UIView commitAnimations];
        
    }
}

*/


-(void)push:(UIButton *)btn {
    
    [self.navigationController popViewControllerAnimated:YES];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    
    
}

-(void)dealloc {
    userName = nil;
    [_imageView removeFromSuperview];
    self.imageView = nil;
     isFullScreen = Nil;
    success = Nil;
     hasLoadedCamera = Nil;
    str = nil;
   
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

@end
