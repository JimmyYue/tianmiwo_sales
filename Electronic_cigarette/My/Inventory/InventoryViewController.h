//
//  InventoryViewController.h
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/4/1.
//

#import <UIKit/UIKit.h>
#import "InventorySecondViewController.h"
#import "MyViewController.h"
#import "GoodsDetailsViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface InventoryViewController : UIViewController
@property (nonatomic,strong) CAGradientLayer *gradientLayer;
@property (nonatomic,strong) NSMutableArray *typeArray;
@property (nonatomic,strong) NSMutableArray *titles;
@end

NS_ASSUME_NONNULL_END
