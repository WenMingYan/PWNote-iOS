//
//  TYDFTableView.m
//  PWNote
//
//  Created by 温明妍 on 2019/5/6.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "TYSmartActionDialogTableViewAgency.h"
#import <Masonry/Masonry.h>
#import "TYDeviceFunctionDefine.h"
#import "TYSmartActionDialogSingleTableViewCell.h"

@interface TYSmartActionDialogTableViewAgency () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, weak) id<TYSmartActionDialogSelectorModelProtocol> selectModel;/**< 选中的Model  */



@end

@implementation TYSmartActionDialogTableViewAgency

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TYSmartActionDialogSingleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(TYSmartActionDialogSingleTableViewCell.class)];
    if (!cell) {
        cell = [[TYSmartActionDialogSingleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                          reuseIdentifier:NSStringFromClass(TYSmartActionDialogSingleTableViewCell.class)];
    }
    [cell setTitle:[self.actions objectAtIndex:indexPath.row]];
    cell.selectCell = (self.selectIndex == indexPath.row);
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
    TYSmartActionDialogSingleTableViewCell *lastCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectIndex inSection:0]];
    lastCell.selectCell = NO;
    TYSmartActionDialogSingleTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectCell = YES;

    self.selectIndex = indexPath.row;
    [tableView reloadData];
    if (self.selectItemBlock) {
        self.selectItemBlock(indexPath.row);
    }
}

#pragma mark - --------------------CustomDelegate--------------
#pragma mark - --------------------Event Response--------------
#pragma mark - --------------------private methods--------------
#pragma mark - --------------------getters & setters & init members ------------------

- (void)setActions:(NSArray<TYSmartActionDialogSelectorModelProtocol> *)actions {
    _actions = [actions copy];
    [self.selectTableView reloadData];
}

- (UITableView *)selectTableView {
    if (!_selectTableView) {
        _selectTableView = [[UITableView alloc] init];
        _selectTableView.delegate = self;
        _selectTableView.dataSource = self;
        _selectTableView.backgroundColor = [UIColor clearColor];
        [_selectTableView registerClass:[TYSmartActionDialogSingleTableViewCell class]
                 forCellReuseIdentifier:NSStringFromClass(TYSmartActionDialogSingleTableViewCell.class)];
        _selectTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _selectTableView;
}

@end
