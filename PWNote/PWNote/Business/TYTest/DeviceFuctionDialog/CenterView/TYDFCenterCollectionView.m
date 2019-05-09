//
//  TYDFCenterCollectionView.m
//  PWNote
//
//  Created by 温明妍 on 2019/5/8.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "TYDFCenterCollectionView.h"

@interface TYDFCenterCollectionView ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation TYDFCenterCollectionView

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
#if DEBUG
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor redColor].CGColor;
#endif
    [self addSubview:self.scrollView];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}
#pragma mark - --------------------UITableViewDelegate--------------
#pragma mark - --------------------CustomDelegate--------------
#pragma mark - --------------------Event Response--------------
#pragma mark - --------------------private methods--------------
#pragma mark - --------------------getters & setters & init members ------------------

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}

@end
