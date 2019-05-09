//
//  TYDFTimerPickerColumnView.m
//  PWNote
//
//  Created by 温明妍 on 2019/5/7.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "TYDFTimerPickerColumnView.h"
#import "TYDFTimerTableView.h"
#import "TYDFTimerPickerColumnCell.h"
#import "TYDeviceFunctionDefine.h"
#import "UIView+ALMAdditons.h"

@interface TYDFTimerPickerColumnView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) CGFloat rowHeight;

@property (nonatomic, weak) UIView *upView;
@property (nonatomic, weak) UIView *centerView;
@property (nonatomic, weak) UIView *downView;

@property (nonatomic, weak) TYDFTimerTableView *upTableView;
@property (nonatomic, weak) TYDFTimerTableView *centerTableView;
@property (nonatomic, weak) TYDFTimerTableView *downTableView;

@property (nonatomic, assign) CGFloat offset;
@property (nonatomic, assign) NSInteger offsetCount;
@property (nonatomic) CGFloat upLinePosY;

@property (nonatomic, assign) CGFloat upLineHeight;
@property (nonatomic, assign) CGFloat downLineHeight;

@property (nonatomic, assign) CGFloat showCount;

@property (nonatomic, assign) BOOL isSubViewLayouted;
@property (nonatomic, assign) CGFloat circumference;
@property (nonatomic, assign) CGFloat radius;

@property(nonatomic, assign) BOOL copyCycleScroll;
@property (nonatomic, assign) NSInteger copyOffsetCount;

@property(nonatomic, assign) BOOL isSelectedRow;

@end

@implementation TYDFTimerPickerColumnView


static NSString *const cellReuseIdentifier = @"TYDFTimerPickerColumnCell";

- (instancetype)initWithFrame:(CGRect)frame rowHeight:(CGFloat)rowHeight upLineHeight:(CGFloat)upLineHeight downLineHeight:(CGFloat)downLineHeight isCycleScroll:(BOOL)isCycleScroll datas:(NSArray *)datas {
    if (self = [super initWithFrame:frame]) {
        self.isCycleScroll = isCycleScroll;
        self.copyCycleScroll = isCycleScroll;
        self.rowHeight = rowHeight;
        self.upLineHeight = upLineHeight;
        self.downLineHeight = downLineHeight;
        self.backgroundColor = [UIColor clearColor];
        self.upLinePosY = (self.bounds.size.height - self.rowHeight) / 2 - self.upLineHeight;
        NSInteger index = self.upLinePosY / self.rowHeight;
        self.offsetCount = index + 1;
        self.offset = self.offsetCount * self.rowHeight - self.upLinePosY;
        if (self.offset == self.rowHeight) {
            self.offset = 0;
            self.offsetCount -= 1;
        }
        self.showCount = (frame.size.height / self.rowHeight - 1) / 2;
        self.circumference = self.rowHeight * self.showCount * 2 - 25;
        self.radius = self.circumference / M_PI * 2;
        self.copyOffsetCount = self.offsetCount;
        
        [self setupCycleScrollWithDatas:datas];
        [self setupView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.isSubViewLayouted) {
        return;
    }
    self.isSubViewLayouted = true;
}

- (void)setupCycleScrollWithDatas:(NSArray *)datas {
    if (self.frame.size.height >= self.rowHeight * datas.count) {
        self.isCycleScroll = false;
    }else {
        self.isCycleScroll = self.copyCycleScroll;
    }
    if (self.isCycleScroll) {
        self.offsetCount = 0;
    }else {
        self.offsetCount = self.copyOffsetCount;
    }
}

- (void)setupView {
    CGFloat upViewHeight = self.height / 2 - self.rowHeight / 2 - self.upLineHeight;
    CGFloat centerViewPosY = upViewHeight + self.upLineHeight;
    CGFloat downViewPosY = centerViewPosY + self.rowHeight + self.downLineHeight;
    
    UIView *upView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, upViewHeight)];
    upView.backgroundColor = [UIColor clearColor];
    upView.clipsToBounds = true;
    [self addSubview:upView];
    self.upView = upView;
    
    UIView *downView = [[UIView alloc]initWithFrame:CGRectMake(0, downViewPosY, self.width, self.height - downViewPosY)];
    downView.backgroundColor = [UIColor clearColor];
    downView.clipsToBounds = true;
    [self addSubview:downView];
    self.downView = downView;
    
    UIView *centerView = [[UIView alloc]initWithFrame:CGRectMake(0, centerViewPosY, self.width, self.rowHeight)];
    centerView.backgroundColor = [UIColor clearColor];
    centerView.clipsToBounds = true;
    [self addSubview:centerView];
    self.centerView = centerView;
    [self setupTableView];
}

- (void)setupTableView {
    {
        CGRect frame = self.bounds;
        frame.origin.y = -self.offset;
        frame.size.height += self.offset;
        TYDFTimerTableView *tableView = [[TYDFTimerTableView alloc]initWithFrame:frame style:UITableViewStylePlain];
        [tableView registerClass:[TYDFTimerPickerColumnCell class] forCellReuseIdentifier:cellReuseIdentifier];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.showsVerticalScrollIndicator = false;
        tableView.showsHorizontalScrollIndicator = false;
        [self.upView addSubview:tableView];
        self.upTableView = tableView;
    }
    {
        CGRect frame = [self convertRect:self.upTableView.frame toView:self.centerView];
        TYDFTimerTableView *tableView = [[TYDFTimerTableView alloc]initWithFrame:frame style:UITableViewStylePlain];
        [tableView registerClass:[TYDFTimerPickerColumnCell class] forCellReuseIdentifier:cellReuseIdentifier];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.showsVerticalScrollIndicator = false;
        tableView.showsHorizontalScrollIndicator = false;
        [self.centerView addSubview:tableView];
        self.centerTableView = tableView;
        [self bringSubviewToFront:tableView];
    }
    
    {
        CGRect frame = [self convertRect:self.upTableView.frame toView:self.downView];
        TYDFTimerTableView *tableView = [[TYDFTimerTableView alloc]initWithFrame:frame style:UITableViewStylePlain];
        [tableView registerClass:[TYDFTimerPickerColumnCell class] forCellReuseIdentifier:cellReuseIdentifier];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.showsVerticalScrollIndicator = false;
        tableView.showsHorizontalScrollIndicator = false;
        [self.downView addSubview:tableView];
        self.downTableView = tableView;
    }
}

- (NSInteger)setupSelectedRow {
    NSInteger row =  self.centerTableView.contentOffset.y / self.rowHeight +  0.5;
    if (self.isCycleScroll) {
        CGFloat posY = self.centerTableView.contentOffset.y + self.copyOffsetCount * self.rowHeight + self.rowHeight / 2;
        NSInteger count = posY / (self.datas.count * self.rowHeight);
        CGFloat newPosY = (self.centerTableView.contentOffset.y + self.copyOffsetCount * self.rowHeight) - (self.datas.count * self.rowHeight) * count;
        if (newPosY < 0) {
            newPosY = 0;
        }
        row =  newPosY / self.rowHeight +  0.5;
    }
    return row;
}

- (void)setupTableViewScroll:(UITableView *)tableView animated:(BOOL)animated {
    CGPoint offsetPoint = CGPointMake(tableView.contentOffset.x, tableView.contentOffset.y + self.rowHeight / 2);
    NSIndexPath *indexPath = [tableView indexPathForRowAtPoint: offsetPoint];
    [tableView scrollToRowAtIndexPath: indexPath atScrollPosition: UITableViewScrollPositionTop animated:animated];
}

- (void)selectRow:(NSInteger)row animated:(BOOL)animated {
    NSInteger newRow = row;
    if (self.isCycleScroll) {
        newRow = row - self.copyOffsetCount;
    }
    if (animated) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRow inSection:0];
        [self.centerTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:true];
        self.selectedRow = row;
        self.isSelectedRow = true;
    }else {
        self.centerTableView.contentOffset = CGPointMake(0, newRow * self.rowHeight);
        [self scrollViewDidEndDecelerating: self.centerTableView];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UITableView *)tableView {
    CGPoint offset = tableView.contentOffset;
    NSInteger rowHeight = self.rowHeight;
    NSInteger posY = offset.y;
    NSInteger value = posY % rowHeight;
    CGFloat itemAngle = value * ((rowHeight / self.radius) / rowHeight);
    
    if (self.isCycleScroll) {
        if (posY < self.rowHeight * self.datas.count * 2) {
            posY = posY + self.rowHeight * self.datas.count;
        }
        if (posY > self.rowHeight * self.datas.count * 3) {
            posY = posY - self.rowHeight * self.datas.count;
        }
    }
    
    if (self.centerTableView == tableView) {
        self.upTableView.contentOffset = CGPointMake(0, posY);
        self.downTableView.contentOffset = CGPointMake(0, posY);
        return;
    }
    
    if (tableView == self.downTableView) {
        self.centerTableView.contentOffset = CGPointMake(0, posY);
        if (!self.isHiddenWheels) {
            [tableView.visibleCells enumerateObjectsUsingBlock:^(__kindof TYDFTimerPickerColumnCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSUInteger index = idx - self.showCount;
                NSInteger length = index * rowHeight;
                CGFloat angle = length / self.radius - itemAngle;
                CGFloat scale = cos(angle / 2);
                [obj transformWith:angle scale:scale];
            }];
        }
        return;
    }
    
    if (tableView == self.upTableView) {
        self.centerTableView.contentOffset = CGPointMake(0, posY);
        if (!self.isHiddenWheels) {
            [tableView.visibleCells enumerateObjectsUsingBlock:^(__kindof TYDFTimerPickerColumnCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSUInteger index = self.showCount - idx;
                NSInteger length = index * rowHeight;
                CGFloat angle = length / self.radius + itemAngle;
                CGFloat scale = cos(angle / 2);
                [obj transformWith:angle scale: scale];
            }];
        }
    }
}

- (void)scrollViewDidEndDragging:(UITableView *)scrollView willDecelerate:(BOOL)decelerate{
    if (decelerate) return;
    [self scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UITableView *)tableView {
    [self setupTableViewScroll:tableView animated:true];
    self.selectedRow = [self setupSelectedRow];
}

- (void)scrollViewDidEndScrollingAnimation:(UITableView *)tableView {
    if (!self.isSelectedRow) {
        [self setupTableViewScroll:tableView animated:false];
        NSUInteger row = [self setupSelectedRow];
        self.selectedRow = row;
    }
    if (self.isSelectedRow) {
        self.isSelectedRow = false;
    }
    
}

#pragma mark - row logic
- (NSUInteger)numberOfRowsInTableView {
    return self.datas.count + self.offsetCount * 2;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.isCycleScroll) {
        return 10;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self numberOfRowsInTableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    TYDFTimerPickerColumnCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    NSInteger row = indexPath.row - self.offsetCount;
    
    if (indexPath.row < self.offsetCount || row >= self.datas.count) {
        cell.label.attributedText = [[NSAttributedString alloc] initWithString: @""];
        cell.contentView.backgroundColor = [UIColor clearColor];
    }else {
        cell.label.attributedText = self.datas[row];
        cell.contentView.backgroundColor = self.viewBackgroundColors[row];
        
        if (!self.isHiddenWheels) {
            if (tableView == self.downTableView) {
                NSUInteger index = row - self.selectedRow;
                NSInteger length = index * self.rowHeight;
                CGFloat angle = length / self.radius;
                CGFloat scale = cos(angle / 2);
                [cell transformWith:angle scale:scale];
            }else if (tableView == self.upTableView) {
                NSUInteger index = self.selectedRow - row;
                NSInteger length = index * self.rowHeight;
                CGFloat angle = length / self.radius;
                CGFloat scale = cos(angle / 2);
                [cell transformWith:angle scale:scale];
            }
        }
    }
    if (tableView == self.centerTableView) {
        cell.label.textColor = self.textColorOfSelectedRow;
        cell.label.font = self.textFontOfSelectedRow;
    }else {
        cell.label.textColor = [self textColorOfOtherRow:row];
        cell.label.font = [self textFontOfOtherRow:row];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (row < self.offsetCount || row >= self.datas.count + self.offsetCount) {
        return;
    }
    UITableViewScrollPosition position = UITableViewScrollPositionTop;
    if (self.isCycleScroll) {
        position = UITableViewScrollPositionMiddle;
    }
    row = indexPath.row - self.offsetCount;
    [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row - self.offsetCount inSection: indexPath.section] animated:true scrollPosition:position];
    self.selectedRow = indexPath.row - self.offsetCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self numberOfRowsInTableView] - 1 == indexPath.row && !self.isCycleScroll) {
        CGFloat tmp = self.offsetCount * self.rowHeight - self.upLinePosY;
        if (self.rowHeight > 44) {
            return fabs(tmp - self.rowHeight);
        }
    }
    return self.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.rowHeight;
}

#pragma mark - Setter
- (void)setSelectedRow:(NSUInteger)selectedRow {
    _selectedRow = selectedRow;
    if (self.datas.count > selectedRow) {
        NSAttributedString *attriString = self.datas[selectedRow];
        self.textOfSelectedRow = attriString.string;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerColumnView:didSelectRow:)]) {
        [self.delegate pickerColumnView:self didSelectRow:selectedRow];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerColumnView:title:didSelectRow:)]) {
        [self.delegate pickerColumnView:self title:self.textOfSelectedRow didSelectRow:selectedRow];
    }
}

- (void)setDatas:(NSArray *)datas {
    _datas = datas;
    [self setupCycleScrollWithDatas:datas];
    [self safeReloadData];
}

#pragma mark - other
- (UIFont *)textFontOfOtherRow:(NSInteger)row {
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerColumnView:textFontOfOtherRow:InComponent:)]) {
        return [self.delegate pickerColumnView:self textFontOfOtherRow:row InComponent:self.component];
    }
    return self.textFontOfOtherRow;
}

- (UIColor *)textColorOfOtherRow:(NSInteger)row {
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerColumnView:textColorOfOtherRow:InComponent:)]) {
        return [self.delegate pickerColumnView:self textColorOfOtherRow:row InComponent:self.component];
    }
    return self.textColorOfOtherRow;
}

- (void)safeReloadData {
    [self.centerTableView reloadData];
    [self.upTableView reloadData];
    [self.downTableView reloadData];
    
    NSInteger index =  [self setupSelectedRow];
    NSAttributedString *attriString = [[NSAttributedString alloc]initWithString:@""];
    if (self.datas.count > index) {
        attriString = self.datas[index];
        self.textOfSelectedRow = attriString.string;
    }
}



@end
