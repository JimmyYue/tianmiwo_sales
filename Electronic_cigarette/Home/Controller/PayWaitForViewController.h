//
//  PayWaitForViewController.h
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/4/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PayWaitForViewController : BlackTopViewController

@property (strong, nonatomic) IBOutlet UIImageView *statusImage;
@property (nonatomic, strong) NSString *tradeNo; // 订单号
@property (nonatomic, strong) NSString *authCode; // 二维码号
@property (nonatomic,strong) CAGradientLayer *gradientLayer;
@property (strong, nonatomic) IBOutlet UIButton *payBtn;
- (IBAction)payBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *loadingLabel;

@end

NS_ASSUME_NONNULL_END
