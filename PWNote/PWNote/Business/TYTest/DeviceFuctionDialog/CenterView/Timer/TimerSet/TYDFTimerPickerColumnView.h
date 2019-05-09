//
//  TYDFTimerPickerColumnView.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/7.
//  Copyright © 2019 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TYDFTimerPickerColumnView;

@protocol TYDFTimerPickerColumnViewDelegate <NSObject>
@optional
- (void)pickerColumnView:(TYDFTimerPickerColumnView *)pickerColumnView didSelectRow:(NSInteger)row;
- (void)pickerColumnView:(TYDFTimerPickerColumnView *)pickerColumnView title:(NSString *)title didSelectRow:(NSInteger)row;

- (UIFont *)pickerColumnView:(TYDFTimerPickerColumnView *)pickerColumnView textFontOfOtherRow:(NSInteger)row InComponent:(NSInteger)component;
- (UIColor *)pickerColumnView:(TYDFTimerPickerColumnView *)pickerColumnView textColorOfOtherRow:(NSInteger)row InComponent:(NSInteger)component;
@end


@interface TYDFTimerPickerColumnView : UIView

@property (nonatomic, weak) id<TYDFTimerPickerColumnViewDelegate> delegate;
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, assign) NSUInteger component;
@property (nonatomic, assign) NSUInteger selectedRow;
@property (nonatomic, strong) NSArray<UIColor *> *viewBackgroundColors;
@property (nonatomic, assign) BOOL refresh;

@property (nonatomic, copy) NSString *textOfSelectedRow;
@property (nonatomic, strong)UIColor *textColorOfSelectedRow;
@property(nonatomic, strong) UIFont *textFontOfSelectedRow;

@property (nonatomic, strong)UIColor *textColorOfOtherRow;
@property(nonatomic, strong) UIFont *textFontOfOtherRow;

@property(nonatomic, assign) BOOL isHiddenWheels;
@property(nonatomic, assign) BOOL isCycleScroll;

- (instancetype)initWithFrame:(CGRect)frame rowHeight:(CGFloat)rowHeight upLineHeight:(CGFloat)upLineHeight downLineHeight:(CGFloat)downLineHeight isCycleScroll:(BOOL)isCycleScroll datas:(NSArray *)datas;
- (void)selectRow:(NSInteger)row animated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
