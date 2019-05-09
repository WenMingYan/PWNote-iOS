//
//  TYDFTableView.m
//  PWNote
//
//  Created by 温明妍 on 2019/5/6.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "TYDFTableViewAgency.h"
#import <Masonry/Masonry.h>
#import "TYDeviceFunctionDefine.h"
#import "TYDeviceFunctionSingleTableViewCell.h"

@interface TYDFTableViewAgency () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, weak) id<TYDFSingleSectionModelProtocol> selectModel;/**< 选中的Model  */

@end

@implementation TYDFTableViewAgency

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TYDeviceFunctionSingleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(TYDeviceFunctionSingleTableViewCell.class)];
    if (!cell) {
        cell = [[TYDeviceFunctionSingleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                
                                                          reuseIdentifier:NSStringFromClass(TYDeviceFunctionSingleTableViewCell.class)];
    }
    id<TYDFSingleSectionModelProtocol> model = [self.actions objectAtIndex:indexPath.row];
    cell.model = model;
    if (model.isSelect) {
        self.selectModel = model;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return TYScreenAdaptor(64);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.actions.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectModel.select = NO;
    id<TYDFSingleSectionModelProtocol> model = [self.actions objectAtIndex:indexPath.row];
    model.select = YES;
    [tableView reloadData];
    if (self.selectItemBlock) {
        self.selectItemBlock(model,indexPath.row);
    }
}

#pragma mark - --------------------CustomDelegate--------------
#pragma mark - --------------------Event Response--------------
#pragma mark - --------------------private methods--------------
#pragma mark - --------------------getters & setters & init members ------------------

- (void)setActions:(NSArray<TYDFSingleSectionModelProtocol> *)actions {
    _actions = actions;
    [self.selectTableView reloadData];
}

- (UITableView *)selectTableView {
    if (!_selectTableView) {
        _selectTableView = [[UITableView alloc] init];
        _selectTableView.delegate = self;
        _selectTableView.dataSource = self;
        [_selectTableView registerClass:[TYDeviceFunctionSingleTableViewCell class]
                 forCellReuseIdentifier:NSStringFromClass(TYDeviceFunctionSingleTableViewCell.class)];
        _selectTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _selectTableView;
}

@end
