//
//  WZNavigationController.m
//  12123_Example
//
//  Created by che on 2018/1/22.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "WZNavigationController.h"

@interface WZNavigationController ()

@end

@implementation WZNavigationController


-(instancetype)init {
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return self;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return self;
}

- (void)initialize{
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"dcdfe6"] size:CGSizeMake(kDeviceWidth, 0.5)];
    [[UINavigationBar appearance] setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:image];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    UIImage *image = [UIImage ms_imageWithColor:[UIColor colorWithHexString:@"fff"]];
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.translucent = NO;
    self.navigationBar.tintColor = [UIColor blackColor];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
}

//能拦截所有push进来的子控制器
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {//是否是栈底控制器
        viewController.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"public_imageBack"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    }
    [super pushViewController:viewController animated:animated];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [[[self viewControllers] lastObject] preferredInterfaceOrientationForPresentation];
}


- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    return [super popViewControllerAnimated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}


@end
