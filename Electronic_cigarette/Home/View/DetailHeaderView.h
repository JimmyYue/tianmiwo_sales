//
//  DetailHeaderView.h
//  YueKe
//
//  Created by JimmyYue on 2021/3/10.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "AddGoodNet.h"

//#import "ImageViewDetailView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailHeaderView : UIView<SDCycleScrollViewDelegate>

@property (nonatomic,copy)void (^blockHeight)(float height);

- (void)setDetaAllowView:(NSDictionary *)dic;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) UIView *packagingView;
@property (nonatomic, strong) UIView *canshuView;
@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) NSString *goodsId;
@end

NS_ASSUME_NONNULL_END
