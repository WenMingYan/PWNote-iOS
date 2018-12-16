//
//  MYCollectionDelegate.m
//  PWNote
//
//  Created by 明妍 on 2018/11/25.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWCollectionDelegate.h"
#import "PWDataSource.h"
#import "UICollectionViewCell+PWItemView.h"

@interface PWCollectionDelegate ()

@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation PWCollectionDelegate

- (void)setDataSource:(PWDataSource *)dataSource {
    _dataSource = dataSource;
    [self.collectionView reloadData];
}

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView {
    if (self = [super init]) {
        self.collectionView = collectionView;
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSource.sectionModels.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    PWSectionModel *sectionModel = [self.dataSource.sectionModels objectAtIndex:section];
    return sectionModel.viewModels.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    PWViewModel *viewModel = [self.dataSource viewModelWithIndexPath:indexPath];
    return [viewModel itemSize];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                     cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PWViewModel *viewModel = [self.dataSource viewModelWithIndexPath:indexPath];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([viewModel itemViewClass])
                                                                           forIndexPath:indexPath];
    UIView<PWItemViewProtocol> *itemView;
    if (!cell.itemView) {
        itemView = [[[viewModel itemViewClass] alloc] init];
        cell.itemView = itemView;
    } else {
        itemView = cell.itemView;
    }
    itemView.viewModel = viewModel;
    return cell;
}

// 设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

@end
