//
//  HomeChildPagesViewController.m
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/29.
//

#import "HomeChildPagesViewController.h"
#import "ZJScrollPageView.h"
#import "UIViewController+ZJScrollPageController.h"
@interface HomeChildPagesViewController ()

@end

@implementation HomeChildPagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.HomeCollectionView registerNib:[UINib nibWithNibName:@"HomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HomeCollectionViewCell"];
    self.HomeCollectionView.delegate = self;
    self.HomeCollectionView.dataSource = self;
    
    self.HomeCollectionView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];

    self.HomeCollectionView.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.arrayListResult = [[NSMutableArray alloc] init];
    self.page = @"1";
    [self setListNet];
}

- (void)loadNewData {
    self.page = @"1";
    [self setListNet];
}

- (void)loadMoreData {
    self.page = [NSString stringWithFormat:@"%lu", self.arrayListResult.count + 1];
    [self setListNet];
}

// 使用系统的生命周期方法
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    NSLog(@"viewWillAppear------%ld", self.zj_currentIndex);
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    NSLog(@"viewDidAppear-----%ld", self.zj_currentIndex);
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    NSLog(@"viewWillDisappear-----%ld", self.zj_currentIndex);
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
//    NSLog(@"viewDidDisappear--------%ld", self.zj_currentIndex);
    
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arrayListResult.count;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    // UIEdgeInsets insets = {top, left, bottom, right};
  
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kDeviceWidth - 30) / 2, (kDeviceWidth - 30)/2 + 85);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UINib *nib = [UINib nibWithNibName:@"HomeCollectionViewCell"
                                bundle: [NSBundle mainBundle]];
    [collectionView registerNib:nib forCellWithReuseIdentifier:@"HomeCollectionViewCell"];
    HomeCollectionViewCell *cell = [[HomeCollectionViewCell alloc]init];
    
    // Set up the reuse identifier
    cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"HomeCollectionViewCell"forIndexPath:indexPath];
    
    HomeModel*homeModel = self.arrayListResult[indexPath.row];
    
    [cell.goodImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", homeModel.url]] placeholderImage:[UIImage imageNamed:@"product_default"]];
    
    cell.nameLabel.text = [NSString stringWithFormat:@"%@", homeModel.goodsName];
    cell.priceLabel.text = [NSString stringWithFormat:@"门店 : %@", homeModel.offlineStock];
    cell.priceLabel.text = [NSString stringWithFormat:@"¥%@", homeModel.retailPrice];
    
    cell.addBtn.tag = 260 + indexPath.row;
    [cell.addBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)addBtnAction:(UIButton *)button {
    HomeModel*homeModel = self.arrayListResult[button.tag - 260];
    [AddGoodNet setAddNet:[NSString stringWithFormat:@"%@", homeModel.goodsId] view:self.view];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeModel*homeModel = self.arrayListResult[indexPath.row];
    GoodsDetailsViewController *goodVC = [[GoodsDetailsViewController alloc] init];
    goodVC.goodsId = [NSString stringWithFormat:@"%@", homeModel.goodsId];
    [self.navigationController pushViewController:goodVC animated:YES];
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, 25);
    return size;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    // 视图添加到 UICollectionReusableView 创建的对象中
    
    UICollectionReusableView *reusableView = nil;
    
 if (kind == UICollectionElementKindSectionFooter) {
    // 底部试图

     [collectionView registerNib:[UINib nibWithNibName:@"HomeFooterView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeFooterView"];

     HomeFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeFooterView" forIndexPath:indexPath];
     footerView.backgroundColor = [UIColor colorWithHexString:@"F5F5F5"];
     
     reusableView = footerView;
     
    return reusableView;
 }
     return reusableView;
}

- (void)setListNet {

    [NetworkHandler requestPostWithUrl:cashGoodsListURL parameters:@{@"categoryId":self.categoryId, @"page":self.page, @"limit":@"20"} completion:^(id result) {
        
        if ([result[@"ok"] intValue] == 1) {
            
            if ([self->_page isEqualToString:@"1"]) {
                self->_arrayListResult = [NSMutableArray array];
            }
            
            NSArray *array = result[@"data"][@"list"];
            
            for (NSMutableDictionary *dic in array) {
                HomeModel*homeModel = [[HomeModel alloc] init];
                [homeModel setValuesForKeysWithDictionary:dic];
                [self.arrayListResult addObject:homeModel];
            }
            
            if (array.count > 0 || self.arrayListResult.count == 0) {
                [self.HomeCollectionView reloadData];
            }
            
        } else {
            [SVProgressHUD showInfoWithStatus:result[@"errmsg"]];
        }
        [self.HomeCollectionView.mj_header endRefreshing];
        [self.HomeCollectionView.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        [self.HomeCollectionView.mj_header endRefreshing];
        [self.HomeCollectionView.mj_footer endRefreshing];
    }];
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
