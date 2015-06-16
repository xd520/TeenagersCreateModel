//
//  LeadingInvestmentViewController.m
//  TeenagersCreateModel
//
//  Created by Yonghui Xiong on 14-11-12.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "LeadingInvestmentViewController.h"
#import "AppDelegate.h"

@interface LeadingInvestmentViewController ()
{
    UITextView *textView;
    UITextView *textJLView;
    UITextView *textSourceView;
    UIScrollView *scrollView;
    NSMutableArray *array1;
    UIView *baseView;
}
@end

@implementation LeadingInvestmentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadView {
    [super loadView];
    UIView *base = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    base.backgroundColor = [ColorUtil colorWithHexString:@"eeeeee"];
    //baseView.backgroundColor = [UIColor grayColor];
    self.view = base;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //相对于上面的接口，这个接口可以动画的改变statusBar的前景色
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    
    statusBarView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"title_bg"]];
    
    [self.view addSubview:statusBarView];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    array1 = [[NSMutableArray alloc] init];
    
    UINavigationBar *navibar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 44)];
    navibar.userInteractionEnabled = YES;
    //navibar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navbar.png"]];
   // [navibar setBackgroundImage:[UIImage imageNamed:@"title_bg"]  forBarMetrics:UIBarMetricsDefault];
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
    navibarItem.title = @"申请领头人";
    navibarItem.leftBarButtonItem= leftItem;
    // self.navigationItem.rightBarButtonItem = leftItem;
    [navibar pushNavigationItem:navibarItem animated:YES];
    [self.view addSubview:navibar];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    [scrollView setContentSize:CGSizeMake(ScreenWidth,685)];
    
    
    
    NSArray *arr = @[@"投资理念:",@"投资经历:",@"社会资源:",@"证明文件:"];
    for (int i = 0; i < arr.count; i++) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10 + 80*i + 10 *i, 75, 80)];
        lab.text = [arr objectAtIndex:i];
        lab.textAlignment = NSTextAlignmentRight;
        lab.font = [UIFont boldSystemFontOfSize:14];
        [scrollView addSubview:[UIView withLabel:lab]];
    }
    
    
 //投资理念
    textView = [[UITextView alloc] initWithFrame:CGRectMake(80, 10, 320 - 100, 80)]; //初始化大小并自动释放
    
    textView.textColor = [UIColor blackColor];//设置textview里面的字体颜色
    
    textView.font = [UIFont fontWithName:@"Arial" size:14.0];//设置字体名字和字体大小
    
    textView.delegate = self;//设置它的委托方法
    textView.returnKeyType=UIReturnKeyDone;
    textView.backgroundColor = [UIColor whiteColor];//设置它的背景颜色
    
    
    
    //textView.text = @"Now is the time for all good developers to come to serve their country.\n\nNow is the time for all good developers to come to serve their country.";//设置它显示的内容
    
    textView.returnKeyType = UIReturnKeyDefault;//返回键的类型
    
    textView.keyboardType = UIKeyboardTypeDefault;//键盘类型
    
    textView.scrollEnabled = YES;//是否可以拖动
    
    
    
    //textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    
    
    
    [scrollView addSubview: textView];
    
 
    
//投资经历
    textJLView= [[UITextView alloc] initWithFrame:CGRectMake(80, 10 + 80 + 10, 320 - 100, 80)]; //初始化大小并自动释放
    
    textJLView.textColor = [UIColor blackColor];//设置textview里面的字体颜色
    
    textJLView.font = [UIFont fontWithName:@"Arial" size:14.0];//设置字体名字和字体大小
    
    textJLView.delegate = self;//设置它的委托方法
    textJLView.returnKeyType=UIReturnKeyDone;
    textJLView.backgroundColor = [UIColor whiteColor];//设置它的背景颜色
 
    
    textJLView.returnKeyType = UIReturnKeyDefault;//返回键的类型
    
    textJLView.keyboardType = UIKeyboardTypeDefault;//键盘类型
    
    textJLView.scrollEnabled = YES;//是否可以拖动
    
    
    
    //textJLView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    
    
    
    [scrollView addSubview: textJLView];
    
    
//社会资源
    textSourceView= [[UITextView alloc] initWithFrame:CGRectMake(80, 10 + 180, 320 - 100, 80)]; //初始化大小并自动释放
    
    textSourceView.textColor = [UIColor blackColor];//设置textview里面的字体颜色
    
    textSourceView.font = [UIFont fontWithName:@"Arial" size:14.0];//设置字体名字和字体大小
    
    textSourceView.delegate = self;//设置它的委托方法
    textSourceView.returnKeyType=UIReturnKeyDone;
    textSourceView.backgroundColor = [UIColor whiteColor];//设置它的背景颜色
    
    
    
    //textView.text = @"Now is the time for all good developers to come to serve their country.\n\nNow is the time for all good developers to come to serve their country.";//设置它显示的内容
    
    textSourceView.returnKeyType = UIReturnKeyDefault;//返回键的类型
    
    textSourceView.keyboardType = UIKeyboardTypeDefault;//键盘类型
    
    textSourceView.scrollEnabled = YES;//是否可以拖动
    
    
    
    //textSourceView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    
    
    
    [scrollView addSubview: textSourceView];
    
    
    //证明文件
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(320 - 70,280 + 25, 50, 30);
    btn.tag = 22220;
    btn.backgroundColor = [UIColor blueColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setTitle:@"浏览" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnMthods:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btn];
    
    UILabel *labTip = [[UILabel alloc] initWithFrame:CGRectMake(100, 280 + 25, 150, 30)];
    labTip.font = [UIFont systemFontOfSize:10];
    labTip.text = @"(最多可上传12张，限制20兆以内)";
    [scrollView addSubview:labTip];
    [self.view addSubview:scrollView];
    
    
    [self reloadImageView];
    
}


-(void)reloadImageView {
    
    if (array1.count == 0) {
        baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 280 + 25 + 40, 320, 40 + 100)];
        baseView.backgroundColor = [UIColor clearColor];
        
        UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        commitBtn.frame = CGRectMake(50, 40 + 40, 220, 40);
        commitBtn.backgroundColor = [ColorUtil colorWithHexString:@"37B3D9"];
        [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [commitBtn addTarget:self action:@selector(comfirmBtnMethods:) forControlEvents:UIControlEventTouchUpInside];
        [baseView addSubview:commitBtn];
        
        
    } else if (array1.count > 0&& array1.count <= 12) {
     
    int hight = 0;
    if(array1.count % 2 == 0)
    {
        hight = (int)array1.count/2;
        baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 280 + 25 + 40, 320, 40*hight + 100)];
         baseView.backgroundColor = [UIColor clearColor];
        
        UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        commitBtn.frame = CGRectMake(50, 40*hight + 40, 220, 40);
        commitBtn.backgroundColor = [ColorUtil colorWithHexString:@"37B3D9"];
        [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [commitBtn addTarget:self action:@selector(comfirmBtnMethods:) forControlEvents:UIControlEventTouchUpInside];
        [baseView addSubview:commitBtn];
        
        
        for (int i = 0; i < hight; i++) {
            
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 40*i, 80, 30)];
            lab.textAlignment = NSTextAlignmentRight;
            lab.font = [UIFont systemFontOfSize:14];
            lab.text = [array1 objectAtIndex:2*i];
            [baseView addSubview:lab];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(100 , 40*i, 50, 30);
            [btn setTitle:@"删除" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            btn.tag = 2*i;
            [btn addTarget:self action:@selector(cancerlBtnMethods:) forControlEvents:UIControlEventTouchUpInside];
            [baseView addSubview:btn];
            
            UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(20 + 160, 40*i, 80, 30)];
            lab1.textAlignment = NSTextAlignmentRight;
            lab1.font = [UIFont systemFontOfSize:14];
            lab1.text = [array1 objectAtIndex:2*i + 1];
            [baseView addSubview:lab1];
            UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
            btn1.frame = CGRectMake(100 + 160, 40*i, 50, 30);
            [btn1 setTitle:@"删除" forState:UIControlStateNormal];
            [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            btn1.tag = 2*i + 1;
            [btn1 addTarget:self action:@selector(cancerlBtnMethods:) forControlEvents:UIControlEventTouchUpInside];
            [baseView addSubview:btn1];
            
        }
        
    }
    else
    {
       hight = (int)(array1.count + 1)/2;
        baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 280 + 25 + 40, 320, 40*hight + 100)];
         baseView.backgroundColor = [UIColor clearColor];
        
        UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        commitBtn.frame = CGRectMake(50, 40*hight + 40, 220, 40);
        commitBtn.backgroundColor = [ColorUtil colorWithHexString:@"37B3D9"];
        [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [commitBtn addTarget:self action:@selector(comfirmBtnMethods:) forControlEvents:UIControlEventTouchUpInside];
        [baseView addSubview:commitBtn];
        
        
        
        int count = 0;
        
        count = (int)(array1.count - 1)/2;
        if (count == 0) {
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 80, 30)];
            lab.textAlignment = NSTextAlignmentRight;
            lab.font = [UIFont systemFontOfSize:14];
            lab.text = [array1 objectAtIndex:array1.count - 1];
            [baseView addSubview:lab];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(100 ,0, 50, 30);
            [btn setTitle:@"删除" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            btn.tag = array1.count - 1;
            [btn addTarget:self action:@selector(cancerlBtnMethods:) forControlEvents:UIControlEventTouchUpInside];
            [baseView addSubview:btn];
        } else {
            
         for (int i = 0; i < count; i++) {
            
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 40*i, 80, 30)];
            lab.textAlignment = NSTextAlignmentRight;
            lab.font = [UIFont systemFontOfSize:14];
            lab.text = [array1 objectAtIndex:2*i];
            [baseView addSubview:lab];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(100 , 40*i, 50, 30);
            [btn setTitle:@"删除" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            btn.tag = 2*i;
            [btn addTarget:self action:@selector(cancerlBtnMethods:) forControlEvents:UIControlEventTouchUpInside];
            [baseView addSubview:btn];
            
            UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(20 + 160, 40*i, 80, 30)];
            lab1.textAlignment = NSTextAlignmentRight;
            lab1.font = [UIFont systemFontOfSize:14];
            lab1.text = [array1 objectAtIndex:2*i + 1];
            [baseView addSubview:lab1];
            UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
            btn1.frame = CGRectMake(100 + 160, 40*i, 50, 30);
            [btn1 setTitle:@"删除" forState:UIControlStateNormal];
            [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            btn1.tag = 2*i + 1;
            [btn1 addTarget:self action:@selector(cancerlBtnMethods:) forControlEvents:UIControlEventTouchUpInside];
            [baseView addSubview:btn1];
            
        }
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 40*count, 80, 30)];
        lab.textAlignment = NSTextAlignmentRight;
        lab.font = [UIFont systemFontOfSize:14];
        lab.text = [array1 objectAtIndex:array1.count - 1];
        [baseView addSubview:lab];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(100 , 40*count, 50, 30);
        [btn setTitle:@"删除" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        btn.tag = array1.count - 1;
        [btn addTarget:self action:@selector(cancerlBtnMethods:) forControlEvents:UIControlEventTouchUpInside];
        [baseView addSubview:btn];
    }
        
        
    }
   //判定有多少租
    
        
    }
   [scrollView addSubview:baseView]; 
}

-(void)comfirmBtnMethods:(UIButton *)btn {
   

    NSString *str = [[NSBundle mainBundle] pathForResource:@"from" ofType:@"txt"];
    NSString *textFile = [NSString stringWithContentsOfFile:str encoding:NSUTF8StringEncoding error:nil];
    //NSString *sstr=[[NSString alloc] initWithContentsOfFile:str];
   
    if ([textView.text isEqualToString:@""]) {
        [self.view makeToast:@"请输入投资理念" duration:0.5 position:@"center"];
    } else if ([textJLView.text isEqualToString:@""]) {
      [self.view makeToast:@"请输入投资经历" duration:0.5 position:@"center"];
    } else if ([textSourceView.text isEqualToString:@""]) {
      [self.view makeToast:@"请输入社会资源" duration:0.5 position:@"center"];
    } else if (array1.count == 0) {
        
        [self.view makeToast:@"请上传图像" duration:0.5 position:@"center"];
    }else {
       
      NSString *strUrl = [textFile stringByReplacingOccurrencesOfString:@"@" withString:textView.text];
       NSString *sstr = [strUrl stringByReplacingOccurrencesOfString:@"#" withString:textJLView.text];
       NSString *str = [sstr stringByReplacingOccurrencesOfString:@"*" withString:textSourceView.text];
      
//        NSString * Str = [NSString stringWithFormat:@""];
//        
//        for (int  i = 0; i < [array count] ; i ++ ) {
//            Str  = [Str stringByAppendingString:[array objectAtIndex:i]];
//        }
//        NSLog(@"%@",Str);
        
       NSString *imageStr = [array1 componentsJoinedByString:@"|"];
         NSLog(@"string = %@",imageStr);
       
       NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
       [paraDic setObject:str forKey:@"URL"];
       [paraDic setObject:imageStr forKey:@"fjStr"];
       
       MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
       hud.dimBackground = YES; //加层阴影
       hud.mode = MBProgressHUDModeIndeterminate;
       hud.labelText = @"加载中...";
       dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
           [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:kBusinessTagGetLtrSq owner:self];
           dispatch_async(dispatch_get_main_queue(), ^{
               
           });
       });
   
   }
}



-(void)cancerlBtnMethods:(UIButton *)btn {
    
    [array1 removeObjectAtIndex:btn.tag];
    [baseView removeFromSuperview];
    baseView = nil;
    [self reloadImageView];
}



-(void)btnMthods:(UIButton *)btn {
    
    
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

- (void)showcamera:(NSInteger)tag{
    UIImagePickerController  *imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setDelegate:self];
  
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
    
        if (array1.count == 12) {
            [self.view makeToast:@"最多只能上传12张图片" duration:1 position:@"center"];
        } else {
          
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.dimBackground = YES; //加层阴影
            hud.mode = MBProgressHUDModeIndeterminate;
            hud.labelText = @"加载中...";
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                [[NetworkModule sharedNetworkModule]postBusinessReqWithParamtersAndFile:nil number:(int)array1.count  withFileName:@"identfy" fileData:imageData tag:kBusinessTagGetRegisterUpfile owner:self];
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
            [array1 addObject:[jsonDic objectForKey:@"object"]];
            [self.view makeToast:[NSString stringWithFormat:@"上传成功%ld张",array1.count]];
            [baseView removeFromSuperview];
            baseView = nil;
            [self reloadImageView];
            
        }
    }  else if (tag==kBusinessTagGetLtrSq) {
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
    
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [[NetworkModule sharedNetworkModule] cancel:tag];
}

- (BOOL)textView:(UITextView *)textV shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textV resignFirstResponder];
        return NO;
    }
    return YES;
}



-(void)push:(UIButton *)btn {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [scrollView endEditing:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    [textJLView removeFromSuperview];
    textJLView = nil;
    
     
    [textView removeFromSuperview];
    textView = nil;
    
    [textSourceView removeFromSuperview];
    textSourceView = nil;
    
    [scrollView removeFromSuperview];
    scrollView = nil;
    
    [array1 removeAllObjects];
    array1 = nil;
    
    [baseView removeFromSuperview];
    baseView = nil;
}

@end
