//
//  SettementBottomView.h
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/30.
//

#import <UIKit/UIKit.h>
#import "ModifyPriceViewController.h"
#import "SettlementFootView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SettementBottomView : UIView

@property (nonatomic,strong) CAGradientLayer *gradientLayer;

- (IBAction)modifyBtnAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *collectionBtn;

@property (nonatomic,strong) UIViewController *selfView;

@property (nonatomic,strong) SettlementFootView *settlementFootView;
@property (nonatomic,strong) NSString *allPrice;

@end

NS_ASSUME_NONNULL_END
