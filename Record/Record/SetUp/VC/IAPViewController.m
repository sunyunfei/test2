//
//  IAPViewController.m
//  Record
//
//  Created by 孙云飞 on 2019/4/24.
//  Copyright © 2019 syf. All rights reserved.
//

#import "IAPViewController.h"
#import "IAPCell.h"
#import "IAPShare.h"
#import "IAPModel.h"
#import <BmobSDK/Bmob.h>
#import "IAPViewController+IAPMethod.h"
#import "AlertTool.h"
static NSString *iap_cell = @"IAPCell";
@interface IAPViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tinyLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;
@property(nonatomic,strong)IAPModel *chooseIapModel;//选中数据
@property (nonatomic,strong)NSArray *prodcutArray;//商品数据
- (IBAction)clickPayBtn:(UIButton *)sender;

@end

@implementation IAPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackItemAndAction];
    self.title = @"购买积分";
    [self setUI];
    __weak typeof(self)weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    [self requestProductInfoSuccess:^(id  _Nonnull respond) {
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
        
        weakSelf.prodcutArray = respond;
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [weakSelf.collectionView reloadData];
        });
    } failure:^{
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
        NSLog(@"请求失败");
    }];
}

#pragma mark --- private method

- (void)setUI{
    
    UICollectionViewFlowLayout *fy = [[UICollectionViewFlowLayout alloc]init];
    fy.itemSize = CGSizeMake((self.collectionView.frame.size.width - 70) / 3, 40);
    fy.minimumInteritemSpacing = 5;
    [self.collectionView setCollectionViewLayout:fy];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:iap_cell bundle:nil] forCellWithReuseIdentifier:iap_cell];
    
    self.priceLabel.text = @"请选择充值项";
    self.tinyLabel.text = [NSString stringWithFormat:@"余额：%li积分",(long)[IntegralTool shareTool].integral];
}

//支付事件
- (IBAction)clickPayBtn:(UIButton *)sender {
    
    if (!self.chooseIapModel) {
        
        NSLog(@"没有选择商品");
        [Tool showMBProgressHUDText:@"请选择商品" view:self.view];
    }else{
        
        [MBProgressHUD showHUDAddedTo:self.view animated:true];
        //开始支付
        [[IAPShare sharedHelper].iap buyProduct:self.chooseIapModel.product onCompletion:^(SKPaymentTransaction *transcation) {
            
            if (transcation.error) {
                [self payFailureMethod];
                NSLog(@"购买商品失败");
            }else if (transcation.transactionState == SKPaymentTransactionStatePurchased){
                
                NSLog(@"购买成功，服务器验证");
                NSData *receipt = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] appStoreReceiptURL]];
                //客户端做收据验证 (不建议)
                [self checkReceipt:receipt tran:transcation];
            }else{
                [self payFailureMethod];
                NSLog(@"购买失败");
            }
        }];
    }
}

#pragma mark ---data method
//支付失败
- (void)payFailureMethod{
    
    NSLog(@"支付失败");
    [MBProgressHUD hideHUDForView:self.view animated:true];
    [AlertTool showALertTitle:@"提示" content:@"支付失败" showType:oneButton sure:^{
        
    } cancel:^{
        
    }];
}

//支付成功
- (void)paySuccessMethod{
    
    NSLog(@"支付成功");
    [MBProgressHUD hideHUDForView:self.view animated:true];
    //更新数据
    [IntegralTool shareTool].integral += self.chooseIapModel.integral;
    [[IntegralTool shareTool] submitIntegral];
    
    self.tinyLabel.text = [NSString stringWithFormat:@"余额：%li积分",(long)[IntegralTool shareTool].integral];
}
#pragma mark --- delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.prodcutArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    IAPCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:iap_cell forIndexPath:indexPath];
    cell.model = self.prodcutArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.chooseIapModel = [self.prodcutArray objectAtIndex:indexPath.row];
}

#pragma mark ---set get method
- (void)setChooseIapModel:(IAPModel *)chooseIapModel{
    
    _chooseIapModel = chooseIapModel;
    self.priceLabel.text = [NSString stringWithFormat:@"价钱:%@",chooseIapModel.productPrice];
    self.nameLabel.text = chooseIapModel.productName;
}
@end
