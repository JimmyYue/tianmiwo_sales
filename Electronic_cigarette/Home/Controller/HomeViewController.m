//
//  HomeViewController.m
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/29.
//

#import "HomeViewController.h"
#import "ZJScrollPageView.h"
@interface HomeViewController ()<ZJScrollPageViewDelegate>
@property(weak, nonatomic)ZJScrollPageView *scrollPageView;
@property(strong, nonatomic)NSArray<UIViewController<ZJScrollPageViewChildVcDelegate> *> *childVcs;
@property(strong, nonatomic) ZJSegmentStyle *style;
@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
    self.navigationItem.leftBarButtonItem = nil; 
    self.navigationItem.hidesBackButton = YES;
    
    [[PgyUpdateManager sharedPgyManager] checkUpdateWithDelegete:self selector:@selector(updateMethod:)];
}

- (NSString *)getTheCurrentVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef) (infoDictionary));
    NSString *currentVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return currentVersion;
}

- (void)updateMethod:(NSDictionary *)response {
    if (response[@"downloadURL"]) {
        NSString *message = response[@"releaseNote"];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"发现新版本" message:message preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"安装" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (@available(iOS 10.0, *)) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:response[@"downloadURL"]] options:@{} completionHandler:nil];
                } else {
                    // Fallback on earlier versions
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:response[@"downloadURL"]]];
                }
        }]];
        [self presentViewController:alert animated:YES completion:^{ }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"收银台";
    self.view.backgroundColor = [UIColor colorWithHexString:@"F5F5F5"];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 40, 40)];
    [rightButton setImage:IMAGENAMED(@"home_center") forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.typeArray = [[NSMutableArray alloc] init];
    [self setCategoryListNet];
    
}

- (void)rightBtnAction {
    MyViewController *myVC = [[MyViewController alloc] init];
    [self.navigationController pushViewController:myVC animated:YES];
}

- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}

/// 设置图片
//- (void)setUpTitleView:(ZJTitleView *)titleView forIndex:(NSInteger)index {
//    titleView.normalImage = [UIImage imageNamed:[NSString stringWithFormat:@"normal_%ld", index+1]];
//    titleView.selectedImage = [UIImage imageNamed:@"selected"];
//}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    
    // 根据不同的下标或者title返回相应的控制器, 但是控制器必须要遵守ZJScrollPageViewChildVcDelegate
    // 并且可以通过实现协议中的方法来加载不同的数据
    // 注意ZJScrollPageView不会保证viewWillAppear等生命周期方法一定会调用
    // 所以建议使用ZJScrollPageViewChildVcDelegate中的方法来加载不同的数据
    
    if (index == 0) {
        // 注意这个效果和tableView的deque...方法一样, 会返回一个可重用的childVc
        // 请首先判断返回给你的是否是可重用的
        // 如果为nil就重新创建并返回
        // 如果不为nil 直接使用返回给你的reuseViewController并进行需要的设置 然后返回即可
    }
    
    HomeChildPagesViewController *childVc = (HomeChildPagesViewController *)reuseViewController;
    if (childVc == nil) {
        childVc = [[HomeChildPagesViewController alloc] init];
    }
    childVc.categoryId = [NSString stringWithFormat:@"%@", self.typeArray[index][@"sonCategoryId"]];
    return childVc;
}

- (void)setCategoryListNet {

    [NetworkHandler requestPostWithUrl:categoryListURL parameters:nil completion:^(id result) {
        
        if ([result[@"ok"] intValue] == 1) {
            
            self.typeArray = result[@"data"];
            
            self.titles = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in self.typeArray) {
                [self.titles addObject:[NSString stringWithFormat:@"%@", dic[@"sonCategoryName"]]];
            }
            
            self.style = [[ZJSegmentStyle alloc] init];
            /// 显示遮盖
            self.style.showLine = YES;
            /// 设置滚动条高度
            self.style.segmentHeight = 45;
            self.style.scrollLineHeight = 3.0f;
            self.style.normalTitleColor = [UIColor colorWithHexString:@"9D9CA0"];
            self.style.selectedTitleColor = [UIColor blackColor];
            /// 显示图片 (在显示图片的时候只有下划线的效果可以开启, 其他的'遮盖','渐变',效果会被内部关闭)
            self.style.showImage = YES;
            /// 平分宽度
        //    style.scrollTitle = NO;
            /// 图片位置
        //    style.imagePosition = TitleImagePositionTop;
            // 当标题(和图片)宽度总和小于ZJScrollPageView的宽度的时候, 标题会自适应宽度
            self.style.autoAdjustTitlesWidth = YES;
            // 初始化
            CGRect scrollPageViewFrame = CGRectMake(0, 0,  kDeviceWidth, kDeviceHeight - StatusRect - NavRect);
            
            ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:scrollPageViewFrame segmentStyle:self.style titles:self.titles parentViewController:self delegate:self];
            self.scrollPageView = scrollPageView;
            // 额外的按钮响应的block
            __weak typeof(self) weakSelf = self;
            self.scrollPageView.extraBtnOnClick = ^(UIButton *extraBtn){
                weakSelf.title = @"点击了extraBtn";
                NSLog(@"点击了extraBtn");
            };
            [self.view addSubview:self.scrollPageView];
            
            self.bottomCartView = [[NSBundle mainBundle] loadNibNamed:@"BottomCartView" owner:nil options:nil][0];
            self.bottomCartView.frame = CGRectMake(10, kDeviceHeight - StatusRect - NavRect - 70, kDeviceWidth - 20, 58);
            self.bottomCartView.selfView = self;
            self.bottomCartView.view = self.view;
            self.bottomCartView.layer.borderWidth = 0.5f;
            self.bottomCartView.layer.borderColor = [UIColor colorWithHexString:@"ffffff" alpha:0.4].CGColor;
            [self.view addSubview:self.bottomCartView];
            
        } else {
            [SVProgressHUD showInfoWithStatus:result[@"errmsg"]];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
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
