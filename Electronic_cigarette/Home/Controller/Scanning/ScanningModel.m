//
//  ScanningModel.m
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/4/1.
//

#import "ScanningModel.h"

@implementation ScanningModel

+ (void)setScanning:(UIViewController *)selfView {
    
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusDenied){
        
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"相机权限受限" message:@"请在iPhone的\"设置->隐私->相机\"选项中,允许\"自游邦\"访问您的相机." preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }]];
            [selfView presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    
    QRCodeController *qrcodeVC = [[QRCodeController alloc] init];
    qrcodeVC.view.alpha = 0;
    [qrcodeVC setDidReceiveBlock:^(NSString *result) {
        NSLog(@"扫描内容 : %@", result);
        [[NSNotificationCenter defaultCenter] postNotificationName:WZNotificationScanning object:nil userInfo:@{@"scanning": result}];
    }];
//    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [del.window.rootViewController addChildViewController:qrcodeVC];
//    [del.window.rootViewController.view addSubview:qrcodeVC.view];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        qrcodeVC.view.alpha = 1;
    } completion:^(BOOL finished) {
    }];
    [selfView.navigationController pushViewController:qrcodeVC animated:YES];
}



@end
