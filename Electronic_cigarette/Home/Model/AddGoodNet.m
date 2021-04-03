//
//  AddGoodNet.m
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/31.
//

#import "AddGoodNet.h"

@implementation AddGoodNet

+ (void)setAddNet:(NSString *)goodsId view:(UIView *)view {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.contentColor = [UIColor colorWithHexString:@"B4B4B4"];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor clearColor];
    
    [NetworkHandler requestPostWithUrl:updateCartProductURL parameters:@{@"goodsId":goodsId, @"cartType":@"0", @"changeNumber":@"1"} completion:^(id result) {
        
        if ([result[@"ok"] intValue] == 1) {
            [[NSNotificationCenter defaultCenter] postNotificationName:WZNotificationReloadHomeTotal object:nil];
        } else {
            [SVProgressHUD showInfoWithStatus:result[@"errmsg"]];
        }
        [MBProgressHUD hideHUDForView:view animated:YES];
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:view animated:YES];
    }];
}

@end
