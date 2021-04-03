//
//  ResetPasswordViewController.h
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResetPasswordViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *oldText;

@property (strong, nonatomic) IBOutlet UITextField *passText;

@property (strong, nonatomic) IBOutlet UIButton *tijiaoBtn;
- (IBAction)tijiaoBtnAction:(id)sender;

@property (nonatomic,strong) CAGradientLayer *gradientLayer;

@end

NS_ASSUME_NONNULL_END
