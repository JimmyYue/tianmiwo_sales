//
//  WebViewController.h
//  YueKe
//
//  Created by JimmyYue on 2021/3/12.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebViewController : BlackTopViewController
@property (nonatomic, strong) NSString *titleStr;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *url;
@property (nonatomic)  WKWebView* webView;
@property (weak, nonatomic) CALayer *progresslayer;
@property (nonatomic,copy)void (^blockAgree)(bool agree);
@end

NS_ASSUME_NONNULL_END
