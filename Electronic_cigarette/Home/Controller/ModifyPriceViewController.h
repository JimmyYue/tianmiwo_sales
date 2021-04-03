//
//  ModifyPriceViewController.h
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ModifyPriceViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *priceText;
@property (strong, nonatomic) IBOutlet UILabel *youhuiLabel;
@property (strong, nonatomic) IBOutlet UIButton *tijiaoBtn;
- (IBAction)tijiaoBtnAction:(id)sender;
@property (nonatomic,strong) NSString *allPrice;
@property (nonatomic,strong) CAGradientLayer *gradientLayer;
@property (nonatomic,copy)void (^block)(NSString *price);
@end

NS_ASSUME_NONNULL_END
