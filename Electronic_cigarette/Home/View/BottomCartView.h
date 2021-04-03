//
//  BottomCartView.h
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/29.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartViewController.h"
#import "SettlementViewController.h"
#import "SettlementCheckStockNet.h"
NS_ASSUME_NONNULL_BEGIN

@interface BottomCartView : UIView

@property (strong, nonatomic) IBOutlet UIButton *settlementBtn;

@property (strong, nonatomic) IBOutlet UIButton *countBtn;

- (IBAction)shopBtnAcrtion:(id)sender;

- (IBAction)settlementBtnAction:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *allPriceLabel;

@property (nonatomic,strong) UIViewController *selfView;
@property (nonatomic,strong) UIView *view;

@property (nonatomic,strong) CAGradientLayer *gradientLayer;

@end

NS_ASSUME_NONNULL_END
