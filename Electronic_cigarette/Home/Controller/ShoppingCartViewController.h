//
//  ShoppingCartViewController.h
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/30.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartTableViewCell.h"
#import "ShoppingCartListBottomView.h"
#import "ShoppingCartModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShoppingCartViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrayListResult;
@property (nonatomic, strong) ShoppingCartListBottomView *shoppingCartListBottomView;
@property (nonatomic, strong) NSString *count;
@end

NS_ASSUME_NONNULL_END
