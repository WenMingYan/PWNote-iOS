//
//  TYDFCenterCollectionView.m
//  PWNote
//
//  Created by 温明妍 on 2019/5/8.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "TYSmartActionDialogCenterCollectionView.h"
#import <Masonry/Masonry.h>
#import "TYSmartActionDialogTableViewAgency.h"
#import "TYSmartActionDialogSingleCell.h"
#import "TYSmartActionDialogNumberSliderCell.h"
#import "TYSmartActionDialogColoursSliderCell.h"
#import "TYSmartActionDialogColoursSaturabilityCell.h"
#import "TYSmartActionDialogColoursSaturabilityIntensityCell.h"
#import "TYSmartActionDialogTimerSetCell.h"
#import "TYSmartActionDialogTimerCell.h"

//TODO: wmy to delete
#import <RACEXTScope.h>

@interface TYSmartActionDialogCenterCollectionView () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation TYSmartActionDialogCenterCollectionView

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
    [self.collectionView registerClass:[TYSmartActionDialogSingleCell class]
            forCellWithReuseIdentifier:NSStringFromClass(TYSmartActionDialogSingleCell.class)];
    [self.collectionView registerClass:[TYSmartActionDialogNumberSliderCell class]
            forCellWithReuseIdentifier:NSStringFromClass(TYSmartActionDialogNumberSliderCell.class)];
    [self.collectionView registerClass:[TYSmartActionDialogColoursSliderCell class]
            forCellWithReuseIdentifier:NSStringFromClass(TYSmartActionDialogColoursSliderCell.class)];
    [self.collectionView registerClass:[TYSmartActionDialogColoursSaturabilityCell class]
            forCellWithReuseIdentifier:NSStringFromClass(TYSmartActionDialogColoursSaturabilityCell.class)];
    [self.collectionView registerClass:TYSmartActionDialogColoursSaturabilityIntensityCell.class
            forCellWithReuseIdentifier:NSStringFromClass(TYSmartActionDialogColoursSaturabilityIntensityCell.class)];
    [self.collectionView registerClass:TYSmartActionDialogTimerCell.class
            forCellWithReuseIdentifier:NSStringFromClass(TYSmartActionDialogTimerCell.class)];
    [self.collectionView registerClass:TYSmartActionDialogTimerSetCell.class
            forCellWithReuseIdentifier:NSStringFromClass(TYSmartActionDialogTimerSetCell.class)];
    
    [self.collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier:NSStringFromClass(UICollectionViewCell.class)];
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}
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
    CGSize size = self.collectionView.bounds.size;
    return size;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                     cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell;
    id<TYSmartActionDialogModelProtocol> model = [self.models objectAtIndex:indexPath.row];
    // 单选
    if ([model conformsToProtocol:@protocol(TYSmartActionDialogSelectorModelProtocol)]) {
        TYSmartActionDialogSingleCell *singleCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(TYSmartActionDialogSingleCell.class)
                                                                               forIndexPath:indexPath];
        singleCell.model = (id<TYSmartActionDialogSelectorModelProtocol>)model;
        @weakify(self);
        [singleCell setSelectItemBlock:^(NSInteger index) {
            @strongify(self);
            if ([self.delegate respondsToSelector:@selector(dialogSelectIndex:inPageIndex:)]) {
                [self.delegate dialogSelectIndex:index inPageIndex:indexPath.row];
            }
        }];
        cell = singleCell;
    }
    // 数字滑块
    else if ([model conformsToProtocol:@protocol(TYSmartActionDialogNumberModelProtocol)]) {
        TYSmartActionDialogNumberSliderCell *numCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(TYSmartActionDialogNumberSliderCell.class)
                                                                                  forIndexPath:indexPath];
        cell = numCell;
        numCell.model = (id<TYSmartActionDialogNumberModelProtocol>)model;
        @weakify(self);
        numCell.callback = ^(double number1) {
            @strongify(self);
            if ([self.delegate respondsToSelector:@selector(dialogSliderWithValue:)]) {
                [self.delegate dialogSelectIndex:number1 inPageIndex:indexPath.row];
            }
        };
    }
    // 色彩滑块
    else if ([model conformsToProtocol:@protocol(TYSmartActionDialogColoursModelProtocol)] ) {
        TYSmartActionDialogColoursSliderCell *sliderCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(TYSmartActionDialogColoursSliderCell.class) forIndexPath:indexPath];
        cell = sliderCell;
        sliderCell.model = (id<TYSmartActionDialogColoursModelProtocol>)model;
        @weakify(self);
        [sliderCell setBlock:^(double number, UIColor *color) {
            @strongify(self);
            if ([self.delegate respondsToSelector:@selector(dialogSliderWithColor:andColorProgress:inPageIndex:)]) {
                [self.delegate dialogSliderWithColor:color andColorProgress:number inPageIndex:indexPath.row];
            }
        }];
    }
    // 显示【色彩、饱和度】滑块选项框
    else if ([model conformsToProtocol:@protocol(TYDDFSliderColoursSaturabilityModelProtocol)]) {
        TYSmartActionDialogColoursSaturabilityCell *sCell =
        [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(TYSmartActionDialogColoursSaturabilityCell.class)
                                                  forIndexPath:indexPath];
        cell = sCell;
        sCell.model = (id<TYDDFSliderColoursSaturabilityModelProtocol>)model;
        @weakify(self);
        @weakify(sCell);
        [sCell setSaturabilityCallback:^(double number1) {
            @strongify(self);
            @strongify(sCell);
            sCell.color = sCell.color;
            sCell.colorProgress = number1;
            if ([self.delegate respondsToSelector:@selector(dialogColoursSaturabilityWithColor:colorProgress:saturabilityValue:inPageIndex:)]) {
                [self.delegate dialogColoursSaturabilityWithColor:sCell.color
                                                    colorProgress:sCell.colorProgress
                                                saturabilityValue:sCell.saturabilityValue
                                                      inPageIndex:indexPath.row];
            }
        }];

        [sCell setColoursCallback:^(double number, UIColor *color) {
            @strongify(self);
            @strongify(sCell);
            sCell.colorProgress = number;
            sCell.color = color;
            if ([self.delegate respondsToSelector:@selector(dialogColoursSaturabilityWithColor:colorProgress:saturabilityValue:inPageIndex:)]) {
                [self.delegate dialogColoursSaturabilityWithColor:color
                                                    colorProgress:number
                                                saturabilityValue:sCell.saturabilityValue
                                                      inPageIndex:indexPath.row];
            }
        }];
        
    }
    // 显示【色彩、饱和度、亮度】滑块选项框
    else if ([model conformsToProtocol:@protocol(TYSmartActionDialogSliderColoursSaturabilityIntensityModelProtocol)]) {
        TYSmartActionDialogColoursSaturabilityIntensityCell *csiCell =
        [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(TYSmartActionDialogColoursSaturabilityIntensityCell.class) forIndexPath:indexPath];
        cell = csiCell;
        csiCell.model = (id<TYSmartActionDialogSliderColoursSaturabilityIntensityModelProtocol>)model;
        @weakify(self);
        @weakify(csiCell);
        [csiCell setIntensityCallback:^(double number1) {
            @strongify(self);
            @strongify(csiCell);
            if ([self.delegate respondsToSelector:@selector(dialogColoursSaturabilityWithColor:colorProgress:saturabilityValue:intensityValue:inPageIndex:)]) {
                csiCell.intensityValue = number1;
                [self.delegate dialogColoursSaturabilityWithColor:csiCell.color
                                                    colorProgress:csiCell.colorProgress
                                                saturabilityValue:csiCell.intensityValue
                                                   intensityValue:number1
                                                      inPageIndex:indexPath.row];
            }
            
        }];
        [csiCell setSaturabilityCallback:^(double number1) {
            @strongify(self);
            @strongify(csiCell);
            if ([self.delegate respondsToSelector:@selector(dialogColoursSaturabilityWithColor:colorProgress:saturabilityValue:intensityValue:inPageIndex:)]) {
                csiCell.saturabilityValue = number1;
                [self.delegate dialogColoursSaturabilityWithColor:csiCell.color
                                                    colorProgress:csiCell.colorProgress
                                                saturabilityValue:number1
                                                   intensityValue:csiCell.intensityValue
                                                      inPageIndex:indexPath.row];
            }
        }];
        [csiCell setColoursCallback:^(double number, UIColor *color) {
            @strongify(self);
            @strongify(csiCell);
            if ([self.delegate respondsToSelector:@selector(dialogColoursSaturabilityWithColor:colorProgress:saturabilityValue:intensityValue:inPageIndex:)]) {
                csiCell.colorProgress = number;
                csiCell.color = color;
                [self.delegate dialogColoursSaturabilityWithColor:color
                                                    colorProgress:number
                                                saturabilityValue:csiCell.saturabilityValue
                                                   intensityValue:csiCell.intensityValue
                                                      inPageIndex:indexPath.row];
            }
        }];
        
    }
    // 定时
    else if ([model conformsToProtocol:@protocol(TYSmartActionDialogTimerModelProtocol)]) {
        id<TYSmartActionDialogTimerModelProtocol> timeModel = (id<TYSmartActionDialogTimerModelProtocol>)model;
        if (timeModel.hasSetTimer) {
            TYSmartActionDialogTimerCell *timeCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(TYSmartActionDialogTimerCell.class) forIndexPath:indexPath];
            cell = timeCell;
            timeCell.model = (id<TYSmartActionDialogTimerModelProtocol>)model;
        } else {
            //TODO: wmy
            TYSmartActionDialogTimerSetCell *timeSetCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(TYSmartActionDialogTimerSetCell.class) forIndexPath:indexPath];
            cell = timeSetCell;
            timeSetCell.model = (id<TYSmartActionDialogTimerModelProtocol>)model;
        }
    }
    else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(UICollectionViewCell.class) forIndexPath:indexPath];
    }
    
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

#pragma mark - --------------------Event Response--------------

- (void)selectIndex:(NSInteger)index {
    if (index < 0 || index >= self.models.count) {
        return;
    }
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]
                                atScrollPosition:UICollectionViewScrollPositionLeft
                                        animated:YES];
}

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
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.pagingEnabled = YES;
        _collectionView.scrollEnabled = NO;
    }
    return _collectionView;
}

@end
