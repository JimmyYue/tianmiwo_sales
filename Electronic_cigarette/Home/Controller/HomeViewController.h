//
//  HomeViewController.h
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/29.
//

#import <UIKit/UIKit.h>
#import "HomeChildPagesViewController.h"
#import "MyViewController.h"
#import "GoodsDetailsViewController.h"
#import "BottomCartView.h"


NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : BlackTopViewController
@property (nonatomic,strong) BottomCartView *bottomCartView;
@property (nonatomic,strong) CAGradientLayer *gradientLayer;
@property (nonatomic,strong) NSMutableArray *typeArray;
@property (nonatomic,strong) NSMutableArray *titles;
@end

NS_ASSUME_NONNULL_END
