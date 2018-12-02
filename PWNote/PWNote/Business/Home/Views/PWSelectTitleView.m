//
//  PWSelectTitleView.m
//  PWNote
//
//  Created by 明妍 on 2018/12/1.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWSelectTitleView.h"
#import <Masonry/Masonry.h>
#import "PWSelectTitleItemCell.h"

@interface PWSelectTitleView () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSMutableArray<PWSelectTitleItemCell *> *titleItems;

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *slimLineView;

@end

@implementation PWSelectTitleView


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
    [self.collectionView registerClass:[PWSelectTitleItemCell class]
            forCellWithReuseIdentifier:@"PWSelectTitleItemCell"];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width / 3);
        make.height.mas_equalTo(5);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(self);
    }];
    
    [self addSubview:self.slimLineView];
    [self.slimLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self);
        make.height.mas_equalTo(0.5);
        make.bottom.mas_equalTo(self);
        make.left.equalTo(self);
    }];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

#pragma mark - --------------------UICollectionViewDelegate--------------


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                     cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PWSelectTitleItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PWSelectTitleItemCell" forIndexPath:indexPath];
    NSString *title = [self.titles objectAtIndex:indexPath.row];
    [cell setTitle:title];
    cell.isSelected = (indexPath.row == self.selectedIndex);
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width / self.titles.count, 35);
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
    self.selectedIndex = indexPath.row;
    [self.collectionView reloadData];
    if ([self.delegate respondsToSelector:@selector(selectTitleView:didSelectIndex:)]) {
        [self.delegate selectTitleView:self didSelectIndex:self.selectedIndex];
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}



#pragma mark - --------------------CustomDelegate--------------
#pragma mark - --------------------Event Response--------------
#pragma mark - --------------------private methods--------------
#pragma mark - --------------------getters & setters & init members ------------------

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    CGFloat left = selectedIndex * [UIScreen mainScreen].bounds.size.width / 3;
    CGRect frame = self.lineView.frame;
    frame.origin.x = left;
    [self.collectionView reloadData];
    [UIView animateWithDuration:0.3 animations:^{
        self.lineView.frame = frame;
    }];
}

- (NSMutableArray<PWSelectTitleItemCell *> *)titleItems {
    if (!_titleItems) {
        _titleItems = [NSMutableArray<PWSelectTitleItemCell *> array];
    }
    return _titleItems;
}

- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    [self.collectionView reloadData];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(100, 35);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor redColor];
    }
    return _lineView;
}

- (UIView *)slimLineView {
    
    if (!_slimLineView) {
        _slimLineView = [[UIView alloc] init];
        _slimLineView.backgroundColor = [UIColor grayColor];
    }
    return _slimLineView;
}
@end
