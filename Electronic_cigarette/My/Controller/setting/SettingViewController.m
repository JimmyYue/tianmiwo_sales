//
//  SettingViewController.m
//  TianmiwoPush
//
//  Created by JimmyYue on 2021/3/22.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"设置";
    self.view.backgroundColor = [UIColor blackColor];
    
    self.clearLabel.text = [NSString stringWithFormat:@"%.2fM",[self filePath]];
    self.versionLabel.text = [NSString stringWithFormat:@"当前版本V%@",[self getTheCurrentVersion]];
    
    
    
}

//  获取版本号
- (NSString *)getTheCurrentVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef) (infoDictionary));
    NSString *currentVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return currentVersion;
}

// 显示缓存大小
-( float )filePath {
    NSString * cachPath = [NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    return [ self folderSizeAtPath :cachPath];
}

//1:首先我们计算一下 单个文件的大小
- ( long long ) fileSizeAtPath:( NSString *) filePath{
    NSFileManager * manager = [ NSFileManager defaultManager ];
    if ([manager fileExistsAtPath :filePath]) {
        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize ];
    }
    return 0 ;
}

//2:遍历文件夹获得文件夹大小，返回多少 M（提示：你可以在工程界设置（)m）
- ( float ) folderSizeAtPath:( NSString *) folderPath{
    NSFileManager * manager = [ NSFileManager defaultManager ];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator ];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
    }
    return folderSize/( 1024.0 * 1024.0 );
}

// 清理缓存
- (void)clearFile {
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    NSArray * files = [[ NSFileManager defaultManager ] subpathsAtPath :cachPath];
    for ( NSString * p in files) {
        NSError * error = nil ;
        NSString * path = [cachPath stringByAppendingPathComponent :p];
        if ([[ NSFileManager defaultManager ] fileExistsAtPath :path]) {
            [[ NSFileManager defaultManager ] removeItemAtPath :path error :&error];
        }
    }
    [ self performSelectorOnMainThread : @selector (clearCachSuccess) withObject : nil waitUntilDone : YES ];
}

-(void)clearCachSuccess {
    [SVProgressHUD showSuccessWithStatus:@"清理成功!"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)clearBtn:(id)sender {
    NSString *string = [NSString stringWithFormat:@"一共有%.2fM缓存",[self filePath]];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:string preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"清除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self clearFile];
        self.clearLabel.text = [NSString stringWithFormat:@"%.2fM",[self filePath]];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)agreementBtnAction:(id)sender {
    
}

- (IBAction)feedbackBtnAction:(id)sender {
    FeedbackViewController *feedVC = [[FeedbackViewController alloc] init];
    [self.navigationController pushViewController:feedVC animated:YES];
}

- (IBAction)exitBtnAction:(id)sender {
    
    [XYCommon SetUserDefault:@"Token" byValue:@""];
    
    LogViewController *loginVC = [[LogViewController alloc] init];
    loginVC.outLogin = @"yes";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self.navigationController.view duration:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
            CATransition* transition = [CATransition animation];
            transition.duration = 0.0f;
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromTop;//可以修改从哪个方向过来
            transition.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];//动画效果
            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];//添加动画
            [self.navigationController pushViewController:loginVC animated:NO];
        } completion:nil];
    });
    
}

@end
