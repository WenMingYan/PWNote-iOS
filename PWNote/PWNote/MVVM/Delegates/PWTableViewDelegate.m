//
//  PWTableViewDelegate.m
//  PWNote
//
//  Created by 明妍 on 2018/11/26.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWTableViewDelegate.h"
#import "PWDataSource.h"
#import "UITableViewCell+PWItemView.h"

@interface PWTableViewDelegate ()

@property(nonatomic, weak) UITableView *tableView;/**< tableView  */

@end

@implementation PWTableViewDelegate

- (instancetype)initWithtableView:(UITableView *)tableView {
    if (self = [super init]) {
        self.tableView = tableView;
    }
    return self;
}

- (void)setDataSource:(PWDataSource *)dataSource {
    _dataSource = dataSource;
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    id<PWViewModelProtocol> viewModel = [self.dataSource footerViewModelWithSection:section];
    viewModel.indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    return viewModel.itemSize.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    id<PWViewModelProtocol> viewModel = [self.dataSource footerViewModelWithSection:section];
    UIView<PWItemViewProtocol> *itemView = [[[viewModel itemViewClass] alloc] init];
    itemView.viewModel = viewModel;
    return itemView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    id<PWViewModelProtocol> viewModel = [self.dataSource headerViewModelWithSection:section];
    viewModel.indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    return viewModel.itemSize.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    id<PWViewModelProtocol> viewModel = [self.dataSource headerViewModelWithSection:section];
    UIView<PWItemViewProtocol> *itemView = [[[viewModel itemViewClass] alloc] init];
    itemView.viewModel = viewModel;
    return itemView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<PWViewModelProtocol> viewModel = [self.dataSource viewModelWithIndexPath:indexPath];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([viewModel itemViewClass])];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([viewModel itemViewClass])];
    cell.backgroundColor = [UIColor clearColor];
    UIView<PWItemViewProtocol> *itemView;
    if (!cell.itemView) {
        itemView = [[[viewModel itemViewClass] alloc] init];
        itemView.interactor = self.interactor;
        cell.itemView = itemView;
    } else {
        itemView = cell.itemView;
    }
    viewModel.indexPath = indexPath;
    itemView.viewModel = viewModel;
    viewModel.itemView = itemView;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<PWViewModelProtocol> viewModel = [self.dataSource viewModelWithIndexPath:indexPath];
    return viewModel.itemSize.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<PWSectionModelProtocol> sectionModel = [self.dataSource.sectionModels objectAtIndex:section];
    return sectionModel.viewModels.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.sectionModels.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIView<PWItemViewProtocol> *itemView = cell.itemView;
    if ([itemView respondsToSelector:@selector(onSelected)]) {
        [itemView onSelected];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([self.viewController respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        @weakify(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            @strongify(self);
            [self.viewController performSelector:@selector(scrollViewDidEndDecelerating:) withObject:scrollView];
        });
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([self.viewController respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        @weakify(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            @strongify(self);
            [self.viewController performSelector:@selector(scrollViewDidEndDragging:willDecelerate:)
                                      withObject:scrollView
                                      withObject:@(decelerate)];
        });
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.viewController respondsToSelector:@selector(scrollViewDidScroll:)]) {
        @weakify(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            @strongify(self);
            [self.viewController performSelector:@selector(scrollViewDidScroll:) withObject:scrollView];
        });
    }
}



@end
