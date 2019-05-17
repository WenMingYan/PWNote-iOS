//
//  TYDFSingleCollectionCell.m
//  PWNote
//
//  Created by 温明妍 on 2019/5/11.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "TYSmartActionDialogSingleCell.h"
#import <Masonry/Masonry.h>

@interface TYSmartActionDialogSingleCell ()

@property (nonatomic, strong) TYSmartActionDialogTableViewAgency *agency;

@end

@implementation TYSmartActionDialogSingleCell

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
    [self addSubview:self.agency.selectTableView];
    [self.agency.selectTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
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

- (void)setSelectItemBlock:(SelectItemBlock)selectItemBlock {
    self.agency.selectItemBlock = [selectItemBlock copy];
}

- (void)setModel:(id<TYSmartActionDialogSelectorModelProtocol>)model {
    _model = model;
    self.agency.actions = model.dialogOptions;
}

- (TYSmartActionDialogTableViewAgency *)agency {
    if (!_agency) {
        _agency = [[TYSmartActionDialogTableViewAgency alloc] init];
    }
    return _agency;
}

@end
