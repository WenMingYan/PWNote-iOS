//
//  TYDFCollectionTopView.m
//  PWNote
//
//  Created by 温明妍 on 2019/5/8.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "TYSmartActionDialogCollectionTopView.h"
#import <Masonry/Masonry.h>
#import "TYDeviceFunctionDefine.h"
#import "TYSmartActionDialogTopCollectionViewCell.h"

@interface TYSmartActionDialogCollectionTopView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation TYSmartActionDialogCollectionTopView

#pragma mark - --------------------dealloc ------------------
#pragma mark - --------------------life cycle--------------------

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

#pragma mark - --------------------UITableViewDelegate--------------
#pragma mark - --------------------CustomDelegate--------------

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.models.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(TYScreenAdaptor(70), TYScreenAdaptor(78));
}

- (TYSmartActionDialogTopCollectionViewCell *)collectionView:(UICollectionView *)collectionView
                     cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TYSmartActionDialogTopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TYDFTopCollectionViewCell" forIndexPath:indexPath];
    id<TYSmartActionDialogModelProtocol> model = [self.models objectAtIndex:indexPath.row];
    if (self.selectIndex == indexPath.row) {
        [cell setSelectCell:YES];
    } else {
        [cell setSelectCell:NO];
    }
    [cell setItemData:model];
    return cell;
}

// 设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, TYScreenAdaptor(30), 0, TYScreenAdaptor(30));
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    TYSmartActionDialogTopCollectionViewCell *lastCell =
    (TYSmartActionDialogTopCollectionViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectIndex inSection:0]];
    [lastCell setSelectCell:NO];
    
    TYSmartActionDialogTopCollectionViewCell *cell = (TYSmartActionDialogTopCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell setSelectCell:YES];
    self.selectIndex = indexPath.row;
    
    if (self.clickBlock) {
        id<TYSmartActionDialogModelProtocol> model = [self.models objectAtIndex:indexPath.row];
        self.clickBlock(indexPath.row, model);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - --------------------Event Response--------------
#pragma mark - --------------------private methods--------------
#pragma mark - --------------------getters & setters & init members ------------------

- (void)setModels:(NSArray<id<TYSmartActionDialogModelProtocol>> *)models {
    _models = models;
    [self.collectionView reloadData];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[TYSmartActionDialogTopCollectionViewCell class]
            forCellWithReuseIdentifier:@"TYDFTopCollectionViewCell"];
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}

@end
