//
//  FeedbackViewController.h
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/29.
//

#import <UIKit/UIKit.h>
#import "XBTextView.h"

NS_ASSUME_NONNULL_BEGIN

@interface FeedbackViewController : BlackTopViewController

@property(nonatomic, strong) XBTextView *agreeText;
@property (nonatomic,strong) CAGradientLayer *gradientLayer;

@property (strong, nonatomic) IBOutlet UIButton *tijiaoBtn;
- (IBAction)tijiaoBtnAction:(id)sender;

@end

NS_ASSUME_NONNULL_END
