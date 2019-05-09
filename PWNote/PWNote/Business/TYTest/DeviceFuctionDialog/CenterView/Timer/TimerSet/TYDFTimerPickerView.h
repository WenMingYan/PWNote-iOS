//
//  TYDFTimerPickerView.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/7.
//  Copyright © 2019 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, TYDFTimerPickerViewLineType) {
    TYDFTimerPickerViewLineTypeline,
    TYDFTimerPickerViewLineTypelineSegment,
    TYDFTimerPickerViewLineTypelineVertical,
};



@protocol TYDFTimerPickerViewDataSource, TYDFTimerPickerViewDelegate;
@interface TYDFTimerPickerView : UIView
@property(nonatomic, assign) TYDFTimerPickerViewLineType type;
@property(nonatomic,weak) id<TYDFTimerPickerViewDataSource> dataSource;    // default is nil. weak reference
@property(nonatomic,weak) id<TYDFTimerPickerViewDelegate>   delegate;      // default is nil. weak reference

@property(nonatomic, strong) UIColor *lineBackgroundColor;          // default is [UIColor grayColor]
@property (nonatomic, assign) CGFloat lineHeight;                   // default is 0.5

@property(nonatomic, strong) UIColor *verticalLineBackgroundColor; // default is [UIColor grayColor] type3 vertical line
@property (nonatomic, assign) CGFloat verticalLineWidth; // default is 0.5

@property (nonatomic, strong)UIColor *textColorOfSelectedRow;     // [UIColor blackColor]
@property(nonatomic, strong) UIFont *textFontOfSelectedRow;

@property (nonatomic, strong)UIColor *textColorOfOtherRow;        // default is [UIColor grayColor]
@property(nonatomic, strong) UIFont *textFontOfOtherRow;

// info that was fetched and cached from the data source and delegate
@property(nonatomic,readonly) NSInteger numberOfComponents;

@property (nonatomic) CGFloat rowHeight;             // default is 44

@property(nonatomic, assign) BOOL isHiddenMiddleText; // default is true  true -> hidden
@property(nonatomic, strong) UIColor *middleTextColor;
@property(nonatomic, strong) UIFont *middleTextFont;

@property(nonatomic, assign) BOOL isHiddenWheels; // default is true  true -> hidden
@property(nonatomic, assign) BOOL isCycleScroll; //default is false

- (NSInteger)numberOfRowsInComponent:(NSInteger)component;

// selection. in this case, it means showing the appropriate row in the middle
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated;// scrolls the specified row to center.

- (NSInteger)selectedRowInComponent:(NSInteger)component;// returns selected row. -1 if nothing selected
- (NSString *)textOfSelectedRowInComponent:(NSInteger)component;
// Reloading whole view or single component
- (void)reloadAllComponents;
- (void)reloadComponent:(NSInteger)component;
- (void)reloadComponent:(NSInteger)component refresh:(BOOL)refresh;
@end

@protocol TYDFTimerPickerViewDataSource<NSObject>
@required
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(TYDFTimerPickerView *)pickerView;

// returns the # of rows in each component..
- (NSInteger)pickerView:(TYDFTimerPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
@end

@protocol TYDFTimerPickerViewDelegate<NSObject>
@optional
// these methods return either a plain NSString, a NSAttributedString, or a view (e.g UILabel) to display the row for the component.
// for the view versions, we cache any hidden and thus unused views and pass them back for reuse.
// If you return back a different object, the old one will be released. the view will be centered in the row rect
- (NSString *)pickerView:(TYDFTimerPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
- (NSAttributedString *)pickerView:(TYDFTimerPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component; // attributed title is favored if both methods are implemented
- (UIColor *)pickerView:(TYDFTimerPickerView *)pickerView viewBackgroundColorForRow:(NSInteger)row forComponent:(NSInteger)component;

- (void)pickerView:(TYDFTimerPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
- (void)pickerView:(TYDFTimerPickerView *)pickerView title:(NSString *)title didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

- (CGFloat)rowHeightInPickerView:(TYDFTimerPickerView *)pickerView forComponent:(NSInteger)component;

- (NSString *)pickerView:(TYDFTimerPickerView *)pickerView middleTextForcomponent:(NSInteger)component;
- (CGFloat)pickerView:(TYDFTimerPickerView *)pickerView middleTextHorizontalOffsetForcomponent:(NSInteger)component;
- (CGFloat)pickerView:(TYDFTimerPickerView *)pickerView middleTextVerticalOffsetForcomponent:(NSInteger)component;

// type is TYDFTimerPickerViewLineTypelineVertical vertical line
- (UIColor *)pickerView:(TYDFTimerPickerView *)pickerView verticalLineBackgroundColorForComponent:(NSInteger)component;
- (CGFloat)pickerView:(TYDFTimerPickerView *)pickerView verticalLineWidthForComponent:(NSInteger)component;

- (UIColor *)pickerView:(TYDFTimerPickerView *)pickerView upLineBackgroundColorForComponent:(NSInteger)component;
- (UIColor *)pickerView:(TYDFTimerPickerView *)pickerView downLineBackgroundColorForComponent:(NSInteger)component;

- (CGFloat)pickerView:(TYDFTimerPickerView *)pickerView upLineHeightForComponent:(NSInteger)component;
- (CGFloat)pickerView:(TYDFTimerPickerView *)pickerView downLineHeightForComponent:(NSInteger)component;

- (UIFont *)pickerView:(TYDFTimerPickerView *)pickerView textFontOfSelectedRowInComponent:(NSInteger)component;
- (UIFont *)pickerView:(TYDFTimerPickerView *)pickerView textFontOfOtherRowInComponent:(NSInteger)component;

- (UIColor *)pickerView:(TYDFTimerPickerView *)pickerView textColorOfSelectedRowInComponent:(NSInteger)component;
- (UIColor *)pickerView:(TYDFTimerPickerView *)pickerView textColorOfOtherRowInComponent:(NSInteger)component;

- (UIFont *)pickerView:(TYDFTimerPickerView *)pickerView textFontOfOtherRow:(NSInteger)row InComponent:(NSInteger)component;
- (UIColor *)pickerView:(TYDFTimerPickerView *)pickerView textColorOfOtherRow:(NSInteger)row InComponent:(NSInteger)component;
@end

NS_ASSUME_NONNULL_END
