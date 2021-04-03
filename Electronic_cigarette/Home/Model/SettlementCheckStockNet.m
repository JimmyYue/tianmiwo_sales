//
//  SettlementCheckStockNet.m
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/31.
//

#import "SettlementCheckStockNet.h"

@implementation SettlementCheckStockNet

+ (void)setAddNet:(UIView *)view selfView:(UIViewController *)selfView {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.contentColor = [UIColor colorWithHexString:@"B4B4B4"];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor clearColor];
    
    [NetworkHandler requestPostWithUrl:checkStockURL parameters:nil completion:^(id result) {
    
        if ([result[@"ok"] intValue] == 1) {
            SettlementViewController *settVC = [[SettlementViewController alloc] init];
            if ([result[@"data"] intValue] == 0) {
                settVC.inventory = @"insufficient";
            }
            [selfView.navigationController pushViewController:settVC animated:YES];
        } else {
            [SVProgressHUD showInfoWithStatus:result[@"errmsg"]];
        }
        
        [MBProgressHUD hideHUDForView:view animated:YES];
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:view animated:YES];
    }];
}

@end
