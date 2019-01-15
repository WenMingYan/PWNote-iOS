//
//  PWSkinManager.h
//  PWNote
//
//  Created by mingyan on 2019/1/8.
//  Copyright © 2019 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTitleColor [PWSkinManager sharedInstance].titleColor
#define kSubTitleColor [PWSkinManager sharedInstance].subTitleColor
#define kThemeColor [PWSkinManager sharedInstance].themeColor
#define kLightSubTitleColor [PWSkinManager sharedInstance].lightSubTitleColor
#define kWhiteColor [PWSkinManager sharedInstance].whiteColor
#define kLightBackgroundColor [PWSkinManager sharedInstance].lightBackgroundColor
#define kMargin [PWSkinManager sharedInstance].margin


@interface PWSkinManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong) UIColor *titleColor; /**< 主标题颜色  */
@property (nonatomic, strong) UIColor *subTitleColor; /**< 副标题颜色  */
@property (nonatomic, strong) UIColor *lightSubTitleColor; /**< 次副标题颜色  */
@property (nonatomic, strong) UIColor *themeColor; /**< 主题颜色  */
@property (nonatomic, strong) UIColor *whiteColor; /**< 白颜色  */
@property (nonatomic, strong) UIColor *lightBackgroundColor; /**< 背景灰颜色  */

@property (nonatomic, assign) CGFloat margin;

@end
