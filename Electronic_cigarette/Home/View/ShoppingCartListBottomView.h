//
//  ShoppingCartListBottomView.h
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShoppingCartListBottomView : UIView

@property (strong, nonatomic) IBOutlet UIButton *jisuanBtn;

@property (nonatomic,strong) CAGradientLayer *gradientLayer;

@property (strong, nonatomic) IBOutlet UILabel *allPriceLabel;


@end

NS_ASSUME_NONNULL_END
