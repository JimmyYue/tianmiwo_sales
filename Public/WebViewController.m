//
//  WebViewController.m
//  YueKe
//
//  Created by JimmyYue on 2021/3/12.
//

#import "WebViewController.h"

@interface WebViewController ()<WKNavigationDelegate,WKUIDelegate>

@end

@implementation WebViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = _titleStr;
    self.view.backgroundColor = [UIColor colorWithHexString:@"F5F7FA"];
    
    [self.view addSubview:self.webView];
    
    if ([self.type isEqualToString:@"login"]) {
        UIButton *agreeBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, _webView.frame.origin.y + _webView.frame.size.height + 15, kDeviceWidth - 60, 50)];
        agreeBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
        [agreeBtn setTitle:@"同意协议" forState:UIControlStateNormal];
        [agreeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        agreeBtn.backgroundColor = [UIColor blackColor];
        agreeBtn.layer.cornerRadius = 6.0f;
        [agreeBtn addTarget:self action:@selector(fagreeBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:agreeBtn];
    }
    
    //  加载进度条
    UIView *progress = [[UIView alloc]initWithFrame:CGRectMake(0, self.webView.frame.origin.y - 1, CGRectGetWidth(self.view.frame), 1)];
    progress.backgroundColor = [UIColor clearColor];
    [self.view addSubview:progress];
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 0, 1);
    layer.backgroundColor = [UIColor colorWithHexString:@"285BF6"].CGColor;
    [progress.layer addSublayer:layer];
    self.progresslayer = layer;
    
    [_webView addObserver:self forKeyPath:@"EstimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
}

- (void)fagreeBtnAction {
    self.blockAgree(true);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (WKWebView *)webView {
    if (!_webView) {
        
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.selectionGranularity = WKSelectionGranularityDynamic;
        config.allowsInlineMediaPlayback = YES;
        WKPreferences *preferences = [WKPreferences new];
        //不通过用户交互，是否可以打开窗口
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        config.preferences = preferences;
        
        float height;
        if ([self.type isEqualToString:@"login"]) {
            height = kDeviceHeight - 140;
        } else {
            height = kDeviceHeight - StatusRect - NavRect - 1;
        }
        
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 1, kDeviceWidth, height) configuration:config];
        self.webView.backgroundColor = [UIColor whiteColor];
        self.webView.navigationDelegate = self;
        self.webView.UIDelegate = self;
        self.webView.opaque = NO;  //背景不透明设置为N
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
        [_webView loadRequest:request];
        
    }
    return _webView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
