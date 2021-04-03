//
//  BlackTopViewController.m
//  YueKe
//
//  Created by JimmyYue on 2021/3/12.
//

#import "BlackTopViewController.h"
@interface BlackTopViewController ()

@end

@implementation BlackTopViewController

- (void)initialize{
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"dcdfe6"] size:CGSizeMake(kDeviceWidth, 0)];
    [[UINavigationBar appearance] setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:image];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
        
        [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
        
        [self.navigationController setNavigationBarHidden:NO animated:animated];
        
        UIImage *image = [UIImage ms_imageWithColor:[UIColor blackColor]];
        [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.translucent = NO;
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        [self initialize];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 当当前控制器是根控制器时，不可以侧滑返回，所以不能使其触发手势
    if (self.navigationController.childViewControllers.count == 1) {
        return NO;
    }
  
    return YES;
}

- (void)handleNavigationTransition:(UITapGestureRecognizer*) tap {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    //ihandleNavigationTransition:为系统私有API,即系统自带侧滑手势的回调方法，我们在自己的手势上直接用它的回调方法
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    panGesture.delegate = self; // 设置手势代理，拦截手势触发
    [self.view addGestureRecognizer:panGesture];
    // 一定要禁止系统自带的滑动手势
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
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
