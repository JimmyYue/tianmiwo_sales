//
//  PersonalInformationViewController.m
//  TianmiwoPush
//
//  Created by JimmyYue on 2021/3/22.
//

#import "PersonalInformationViewController.h"

@interface PersonalInformationViewController ()

@end

@implementation PersonalInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"个人信息";
    self.view.backgroundColor = [UIColor blackColor];
    
    self.nameLabel.text = [XYCommon GetUserDefault:@"NickName"];
    self.phoneLabel.text = [XYCommon GetUserDefault:@"Phone"];
    self.positionLabel.text = [XYCommon GetUserDefault:@"Position"];
    
}

- (IBAction)modifyPassAction:(id)sender {
    ResetPasswordViewController *passVC=  [[ResetPasswordViewController alloc] init];
    [self.navigationController pushViewController:passVC animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
