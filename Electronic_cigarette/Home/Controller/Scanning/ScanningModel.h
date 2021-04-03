//
//  ScanningModel.h
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/4/1.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "QRCodeController.h"
#import "AppDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface ScanningModel : NSObject
+ (void)setScanning:(UIViewController *)selfView;
@end

NS_ASSUME_NONNULL_END
