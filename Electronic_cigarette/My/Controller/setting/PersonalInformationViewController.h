//
//  PersonalInformationViewController.h
//  TianmiwoPush
//
//  Created by JimmyYue on 2021/3/22.
//

#import <UIKit/UIKit.h>
#import "ResetPasswordViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonalInformationViewController : BlackTopViewController

@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *positionLabel;

- (IBAction)modifyPassAction:(id)sender;



@end

NS_ASSUME_NONNULL_END
