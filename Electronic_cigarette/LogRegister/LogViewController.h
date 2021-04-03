//
//  LogViewController.h
//  YueKe
//
//  Created by JimmyYue on 2021/3/9.
//

#import <UIKit/UIKit.h>
#import "YHLTextFieldPhone.h"
#import "WebViewController.h"
#import "HomeViewController.h"
#import "WZNavigationController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LogViewController : UIViewController<YHLTextFieldDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet YHLTextFieldPhone *phoneText;

@property (strong, nonatomic) IBOutlet UITextField *codeText;

- (IBAction)agreementnBtnAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *loginBtn;

@property (strong, nonatomic) IBOutlet UIButton *selectedBtn;
- (IBAction)selectedBtnAction:(id)sender;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) NSString *outLogin;

@property (nonatomic,copy)void (^blockLogin)(BOOL login);

@end

NS_ASSUME_NONNULL_END
