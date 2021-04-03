//
//  InventoryViewController.m
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/4/1.
//

#import "InventoryViewController.h"
#import "ZJScrollPageView.h"
@interface InventoryViewController ()<ZJScrollPageViewDelegate>
@property(weak, nonatomic)ZJScrollPageView *scrollPageView;
@property(strong, nonatomic)NSArray<UIViewController<ZJScrollPageViewChildVcDelegate> *> *childVcs;
@property(strong, nonatomic) ZJSegmentStyle *style;

@end

@implementation InventoryViewController


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"库存";
    self.view.backgroundColor = [UIColor blackColor];
    
    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.typeArray = [[NSMutableArray alloc] init];
    [self setCategoryListNet];
    
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
    
    InventorySecondViewController *childVc = (InventorySecondViewController *)reuseViewController;
    if (childVc == nil) {
        childVc = [[InventorySecondViewController alloc] init];
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
