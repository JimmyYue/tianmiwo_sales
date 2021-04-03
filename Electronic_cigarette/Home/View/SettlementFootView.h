//
//  SettlementFootView.h
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettlementFootView : UIView

- (IBAction)payBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *payTypeLabel;
@property (nonatomic,strong) UIViewController *selfView;

@property (strong, nonatomic) IBOutlet UIButton *hiddenView;
@property (strong, nonatomic) IBOutlet UILabel *youhuiHidden;
@property (strong, nonatomic) IBOutlet UILabel *xiaojiHidden;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *top;

@property (strong, nonatomic) IBOutlet UILabel *allPriceLabel;

@property (strong, nonatomic) IBOutlet UILabel *youhuiLabel;

@property (strong, nonatomic) IBOutlet UILabel *shijiLabel;

@property (strong, nonatomic) NSString *payType;

- (void)setHidden;
- (void)setShow;

@end

NS_ASSUME_NONNULL_END
