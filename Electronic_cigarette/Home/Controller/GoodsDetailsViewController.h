//
//  GoodsDetailsViewController.h
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/30.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "DetailHeaderView.h"
#import "BottomCartView.h"
NS_ASSUME_NONNULL_BEGIN

@interface GoodsDetailsViewController : BlackTopViewController<SDCycleScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) DetailHeaderView *detailView;
@property (nonatomic,strong) BottomCartView *bottomCartView;
@property (nonatomic, strong) NSString *goodsId;
@property (nonatomic, strong) NSString *type;
@end

NS_ASSUME_NONNULL_END
