//
//  SettingViewController.h
//  TianmiwoPush
//
//  Created by JimmyYue on 2021/3/22.
//

#import <UIKit/UIKit.h>
#import "LogViewController.h"
#import "FeedbackViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SettingViewController : BlackTopViewController

@property (strong, nonatomic) IBOutlet UILabel *versionLabel;

- (IBAction)clearBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *clearLabel;

- (IBAction)exitBtnAction:(id)sender;

- (IBAction)feedbackBtnAction:(id)sender;

- (IBAction)agreementBtnAction:(id)sender;


@end

NS_ASSUME_NONNULL_END
