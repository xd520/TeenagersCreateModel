//
//  UpDateInfoViewController.m
//  TeenagersCreateModel
//
//  Created by Yonghui Xiong on 15-1-8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "UpDateInfoViewController.h"
#import "AppDelegate.h"
#import "Customer.h"

@interface UpDateInfoViewController ()
{
    UITextField *zcTextField;
    UITextField *nsrTextField;
    UITextField *gsTextField;
    UITextField *zwTextField;
    NSMutableArray *array3;
    UILabel *faceLab;
    UIButton *faceBtn;
}
@end

@implementation UpDateInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        array3 = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //相对于上面的接口，这个接口可以动画的改变statusBar的前景色
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    
    statusBarView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"title_bg"]];
    
    [self.view addSubview:statusBarView];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    UINavigationBar *navibar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 44)];
    navibar.userInteractionEnabled = YES;
    //navibar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navbar.png"]];
    //[navibar setBackgroundImage:[UIImage imageNamed:@"title_bg"]  forBarMetrics:UIBarMetricsDefault];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
        navibar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"title_bg"]];
        
    } else {
        navibar.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"title_bg"]];
    }

    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 12, 40, 20);
    [leftBtn setImage:[UIImage imageNamed:@"return_ico"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    
    UINavigationItem *navibarItem = [[UINavigationItem alloc]init];
    navibarItem.title = @"个人投资人修改";
    navibarItem.leftBarButtonItem= leftItem;
    // self.navigationItem.rightBarButtonItem = leftItem;
    [navibar pushNavigationItem:navibarItem animated:YES];
    [self.view addSubview:navibar];
    
    NSArray *arr = @[@"资产(万元):",@"年收入(万元):",@"公  司:",@"职  位:",@"资产证明文件:"];
    for (int i = 0; i < arr.count ; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 40*i + 74, 80, 40)];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:14];
        label.text = [arr objectAtIndex:i];
        [self.view addSubview:[UIView withLabel:label]];
        
    }
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    Customer *customer = [delegate.array objectAtIndex:0];
    
//资产
    zcTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 80, 200, 30)];
    zcTextField.borderStyle = UITextBorderStyleLine;
    zcTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    zcTextField.delegate = self;
    zcTextField.placeholder = @"请填写资产";
    zcTextField.text = customer.fund;
    //@"字母开头，4~16位字符，可包含英文字母，数字、\"_\""
    zcTextField.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:zcTextField];
    //年收入
    nsrTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 120, 200, 30)];
    nsrTextField.borderStyle = UITextBorderStyleLine;
    nsrTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    nsrTextField.delegate = self;
    nsrTextField.placeholder = @"请填写年收入";
    nsrTextField.text = customer.yearGold;
    //@"字母开头，4~16位字符，可包含英文字母，数字、\"_\""
    nsrTextField.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:nsrTextField];
    //公司
    gsTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 160, 200, 30)];
    gsTextField.borderStyle = UITextBorderStyleLine;
    gsTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    gsTextField.delegate = self;
    gsTextField.placeholder = @"请填写公司";
    gsTextField.text = customer.companyName;
    //@"字母开头，4~16位字符，可包含英文字母，数字、\"_\""
    gsTextField.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:gsTextField];
    //职位
    zwTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 200, 200, 30)];
    zwTextField.borderStyle = UITextBorderStyleLine;
    zwTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    zwTextField.delegate = self;
    zwTextField.placeholder = @"请填写职位";
    zwTextField.text = customer.fid_zw;
    //@"字母开头，4~16位字符，可包含英文字母，数字、\"_\""
    zwTextField.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:zwTextField];
    //资产证明文件
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(320 - 70,240, 50, 30);
    //btn.tag = 22220;
    btn.backgroundColor = [UIColor blueColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setTitle:@"浏览" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnMthods) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UILabel *labTip = [[UILabel alloc] initWithFrame:CGRectMake(100, 240, 150, 30)];
    labTip.font = [UIFont systemFontOfSize:10];
    labTip.text = @"(需上传1张，限制10兆以内)";
    [self.view addSubview:labTip];
   
    faceLab  = [[UILabel alloc] initWithFrame:CGRectMake(20 , 280, 80, 30)];
    faceLab.textAlignment = NSTextAlignmentRight;
    faceLab.font = [UIFont systemFontOfSize:14];
    //passPortLab.text = [array2 objectAtIndex:0];
    [self.view addSubview:faceLab];
    
    faceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    faceBtn.frame = CGRectMake(100 , 280, 50, 30);
    [faceBtn setTitle:@"删除" forState:UIControlStateNormal];
    [faceBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    faceBtn.hidden = YES;
    [faceBtn addTarget:self action:@selector(cancerlMethods) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:faceBtn];
    
    
    
    
   
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.frame = CGRectMake(50, 340, 220, 40);
    commitBtn.backgroundColor = [ColorUtil colorWithHexString:@"37B3D9"];
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(comfirmBtnMethods) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitBtn];
    
    
}

-(void)comfirmBtnMethods{
    if ([zcTextField.text isEqualToString:@""]) {
        [self.view makeToast:@"请输入资产" duration:1.0 position:@"center"];
    } else if ([nsrTextField.text isEqualToString:@""]){
     [self.view makeToast:@"请输入年收入" duration:1.0 position:@"center"];
        
    } else if ([gsTextField.text isEqualToString:@""]){
      [self.view makeToast:@"请输入公司" duration:1.0 position:@"center"];
    } else if ([zwTextField.text isEqualToString:@""]){
       [self.view makeToast:@"请输入职位" duration:1.0 position:@"center"];
    }else if (array3.count != 1){
        [self.view makeToast:@"请上传资产证明文件" duration:1.0 position:@"center"];
    }else {
    
        NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
        [paraDic setObject:zcTextField.text forKey:@"zc"];
        [paraDic setObject:nsrTextField.text forKey:@"nsr"];
        [paraDic setObject:gsTextField.text forKey:@"gs"];
        [paraDic setObject:zwTextField.text forKey:@"zw"];
        [paraDic setObject:[array3 objectAtIndex:0] forKey:@"fj"];
       
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.dimBackground = YES; //加层阴影
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"加载中...";
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:kBusinessTagGetModifyTzr owner:self];
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
        });
        
   
    
    
    }
}


-(void)cancerlMethods {
        [array3 removeAllObjects];
        faceBtn.hidden = YES;
        faceLab.text = @"";
    
}


-(void)btnMthods {
    
    
    UIActionSheet *sheet;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
        
    } else {
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    [sheet showInView:self.view];
    
    
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
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
                //hasLoadedCamera = YES;
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

- (void)showcamera:(NSInteger)tag  {
    UIImagePickerController  *imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setDelegate:self];
    NSLog(@"rrrr%@",imagePicker.title);
    //[imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [imagePicker setAllowsEditing:YES];
    imagePicker.sourceType = tag;
    [self presentViewController:imagePicker animated:YES completion:^{}];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [self scaleImage:[info objectForKey:UIImagePickerControllerEditedImage]];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    
    //NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
    if (array3.count > 1||array3.count == 1) {
        [self.view makeToast:@"最多只能上传1张图片" duration:1 position:@"center"];
    } else {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.dimBackground = YES; //加层阴影
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"加载中...";
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            [[NetworkModule sharedNetworkModule]postBusinessReqWithParamtersAndFile:nil number:0  withFileName:@"fundID"  fileData:imageData tag:kBusinessTagGetRegisterUpfile owner:self];
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
        });
        
    }
    
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

#pragma mark - NetworkModuleDelegate Methods
-(void)beginPost:(kBusinessTag)tag{
    
}
-(void)endPost:(NSString *)result business:(kBusinessTag)tag{
    NSLog(@"%s %d 收到数据:%@", __FUNCTION__, __LINE__, result);
    NSMutableDictionary *jsonDic = [result JSONValue];
    
	if (tag==kBusinessTagGetRegisterUpfile ) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([[jsonDic objectForKey:@"success"] boolValue] == 0) {
            //数据异常处理
            [self.view makeToast:[jsonDic objectForKey:@"msg"]];
        } else {
            [self.view makeToast:@"上传成功1张"];
            [array3 addObject:[jsonDic objectForKey:@"object"]];
            faceLab.text = [jsonDic objectForKey:@"object"];
            faceBtn.hidden = NO;
            
        }
    } else if (tag==kBusinessTagGetModifyTzr) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([[jsonDic objectForKey:@"success"] boolValue] == 0) {
            //数据异常处理
            [self.view makeToast:[jsonDic objectForKey:@"msg"]];
        } else {
            
            [self.view makeToast:[jsonDic objectForKey:@"msg"]];
            
            [self.navigationController popViewControllerAnimated:YES];
            
            
        }
    }
    
    
    
    
    [[NetworkModule sharedNetworkModule] cancel:tag];
}
-(void)errorPost:(NSError *)err business:(kBusinessTag)tag{
    NSLog(@"%s Error:%@", __FUNCTION__, @"连接数据服务器超时");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法连接" message:@"您所在地的网络信号微弱，无法连接到服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    //if (tag == kBusinessTagGetRegisterUpfile) {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    //}
    [[NetworkModule sharedNetworkModule] cancel:tag];
}





- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs;
    if(textField == zcTextField || textField == nsrTextField)
    {
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest)
        {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"请输入数字"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            
            [alert show];
            return NO;
        }
    }
    
    //其他的类型不需要检测，直接写入
    return YES;
}





#pragma mark - 消除键盘

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


-(void)push:(UIButton *)btn {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
